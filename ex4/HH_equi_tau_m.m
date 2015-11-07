function [asymptote, tau] = HH_equi_tau_m( membrane_voltage ) 

% Na activation gate m
% membrane_voltage [mV]
% asymptote [1]
% tau [ms]

[alpha,beta] = HH_alpha_beta_M( membrane_voltage );

tau = 1 ./ (alpha + beta );

asymptote = alpha ./ ( alpha + beta );

end

function [alpha,beta] = HH_alpha_beta_M ( membrane_voltage )

% membrane_voltage [mV]
% alpha, beta [1/ms]

% alpha = 0.1 * (V+40) / (1 - exp( -0.1*(V + 40) ) );
% beta  = 4 * exp( -0.0556*(V+65) );

va = 0.1 * ( membrane_voltage + 40 );
vb = 0.0556 * ( membrane_voltage + 65 );

alpha = zeros(size(membrane_voltage));
beta = zeros(size(membrane_voltage));

ns = find( abs(va) > 0.01 );
ss = find( abs(va) <= 0.01 );

% if ~isempty(ns)
%     alpha(ns) = va(ns) ./ ( 1 - exp( -va(ns) ) );
% end
% 
% if ~isempty(ss)
%     alpha(ss) = 1 ./ ( 1 - va(ss)/2 );    
% end    
alpha = va ./ ( 1 - exp( -va ) );
beta = 4 * exp( -vb );

end
