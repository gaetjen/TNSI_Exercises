function P_s_total = synaptic_activation(nu, t, tau_s)

% Course on theoretical neuroscience
% Teacher: Jochen Braun
% Assistent teachers: Stephanie Lehmann, Joachim Haenicke
% Exercise06: Operating point of a spiking neuron
% Function
% 11/14/09
% This function generates a vector of synaptic impulses.
% input: nu, combined spike rate of all presynaptic neurons, in Hz
%        t, vector of time steps in ms
%        tau_s, synaptic time constant
% output: P_s_total, normalized time course of total synaptic activation


T_end = int16(t(end)); % get time of the last step

nu = nu / 1000;   % convert spike rate from s^{-1} to ms^{-1}

N = 1;
T = zeros(1,2*nu*T_end);
T(1) = - log(rand)/nu; % first spike time
while T(N) < T_end    
    N = N+1;    
    T(N) = T(N-1) - log( rand ) / nu;
end
T_spk = T(1:N-1);   % discard the last spike, which occurs after Tend

% Generate time course of synaptic acitvation
% alpha function: P_s = (t-tspk)/tau_s*exp(1-(t-tspk)/tau_s)
%                 P_s = alpha*exp(1-alpha)
P_s_total = zeros(size(t)); % reserve memory for result
for i=1:length(t) % loop through all time steps
    alpha = (t(i)-T_spk)/tau_s;
    % Take positive values only. Constrict precision to 10*tau_s
    ix = find(alpha>0 & alpha<10*tau_s);
    if ~isempty(ix) % were there any spikes in the near past?
        %collect their contribution and sum over all contributions.
        P_s_total(i) = sum(alpha(ix) .* exp(1-alpha(ix)));
    end
end

% There is a small flaw to this function: Only a single spike can occur 
% during each time step. This minor detail is not important, as long as the
% time steps and the total spike rate are small enough.