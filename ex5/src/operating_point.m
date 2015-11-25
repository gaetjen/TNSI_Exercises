%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton
deltaT = 0.1;
maxT = 1000;

rate_exc = 20;
rate_inh = 20;
tau_exc = 1;
tau_inh = 2;
num_exc = 100;
num_inh = 0;

rate = 9999;
coeff_vector = [];
mean_voltage = [];
%simulate with increasing numbers of inhibitory neuron until we have no 
%firing anymore
while rate > 0
    neuron_sim;
    coeff_vector = [coeff_vector, coeff_v];
    mean_voltage = [mean_voltage, mean(voltage_nospike)];
    display(rate);
    num_inh = num_inh + 1;
end

figure();
plot(mean_voltage, coeff_vector, '.');
display(num_inh);
[cv, idx] = max(coeff_vector)
mean_voltage(idx)