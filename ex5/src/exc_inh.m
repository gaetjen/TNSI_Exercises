%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton
% 10Hz --> 30 Neurons
% coefficient of variation: 0.9532
% average non-spiking voltage: -61.3304
% actual spiking rate: 10.3333

% 30Hz --> 22 Neurons
% coefficient of variation: 0.9460
% average non-spiking voltage: -58.6190
% actual spiking rate: 28.7

% 70Hz --> 13 Neurons
% coefficient of variation: 0.8338
% average non-spiking voltage: -54.5539
% actual spiking rate: 70

deltaT = 0.1;
maxT = 2000;

rate_exc = 20;
rate_inh = 20;
tau_exc = 1;
tau_inh = 2;
num_exc = 100;
%choose the minimum value with which to start 
num_inh = 0;
% choose the rate for which you want to know how many inhibitory neurons it
% takes
target_rate = 10;
rate = 999;
min_num = 0;
found_first = false;
% check all possible numbers, that are within a 1.3 factor "error margin"
while rate > target_rate/1.3
    neuron_sim;
    if ~found_first && rate < target_rate*1.3
        min_num = num_inh;
        found_first = true;
    end
    display(rate);
    num_inh = num_inh + 1;
end
display(num_inh);
display(min_num);
maxT = 8000;
best_diff = target_rate;
best_num = min_num;
%evaluate our selected numbers more accurately
for num_inh = min_num:num_inh
    neuron_sim;
    display(rate);
    if abs(target_rate - rate) < best_diff
        best_diff = abs(target_rate - rate);
        best_num = num_inh;
    end
end

display('finished, best estimate:');
display(best_num);
display(best_diff);
%make a final evaluating with high accuracy
num_inh = best_num;
maxT = 30000;
display('last run');
display(coeff_v);
display(mean(voltage_nospike));
display(rate);