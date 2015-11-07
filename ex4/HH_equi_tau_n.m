function [asymptote, tau] = HH_equi_tau_n( membrane_voltage ) 

% K activation gate n
% membrane_voltage [mV]
% asymptote [1]
% tau [ms]

[alpha,beta] = HH_alpha_beta_N( membrane_voltage );

tau = 1 ./ (alpha + beta );

asymptote = alpha ./ ( alpha + beta );

end

function [alpha,beta] = HH_alpha_beta_N ( membrane_voltage )

% membrane_voltage [mV]
% alpha, beta [1/ms]

% alpha = 0.01 * (V+55) / (1 - exp(-0.1 * (V+55) ) )
% beta  = 0.125 * exp( -0.0125*(V+65) );


va = 0.1 * ( membrane_voltage + 55 );
vb = 0.0125 * (membrane_voltage + 65 );

alpha = zeros(size(membrane_voltage));
beta =  zeros(size(membrane_voltage));

ns = find( abs(va) > 0.01 );
ss = find( abs(va) <= 0.01 );

% if ~isempty(ns)
%     alpha(ns) = 0.1 * va(ns) ./ ( 1 - exp( -va(ns) ) );
% end
% 
% if ~isempty(ss)
%     alpha(ss) = 0.1 ./ ( 1 - va(ss)/2 );    
% end 

alpha = 0.1*va ./ ( 1 - exp( -va ) );
beta = 0.125 * exp( -vb );

end

