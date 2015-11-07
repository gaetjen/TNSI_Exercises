function [asymptote, tau] = HH_equi_tau_h( membrane_voltage ) 

% Na inactivation gate h
% membrane_voltage [mV]
% asymptote [1]
% tau [ms]

[alpha, beta] = HH_alpha_beta_H( membrane_voltage );

tau = 1 ./ (alpha + beta );

asymptote = alpha ./ ( alpha + beta );

end

function [alpha,beta] = HH_alpha_beta_H ( membrane_voltage )

% membrane_voltage [mV]
% alpha, beta [1/ms]

% alpha = 0.07 * exp( -0.05 * (V + 65) )
% beta  = 1 / ( 1 + exp(-0.1*(V + 35) ) )


va = 0.05 * ( membrane_voltage + 65);  % mV
vb = 0.1 * ( membrane_voltage + 35 );  % mV

alpha = 0.07 * exp( -va );

beta = 1 ./ ( 1 + exp( -vb ) );

end

