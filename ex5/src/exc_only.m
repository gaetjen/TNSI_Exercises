%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton
% 10Hz --> 30 Neurons
% coefficient of variation: 0.8566
% average non-spiking voltage: -57.3477
% actual spiking rate: 10.5333

% 30Hz --> 40 Neurons
% coefficient of variation: 0.7029
% average non-spiking voltage: -55.1735
% actual spiking rate: 30.2667

% 70Hz --> 56 Neurons
% coefficient of variation: 0.5285
% average non-spiking voltage: -51.9781
% actual spiking rate: 69.1334

deltaT = 0.1;
maxT = 2000;

rate_exc = 20;
rate_inh = 20;
tau_exc = 1;
tau_inh = 2;
num_inh = 0;
%choose a value with which to start. if it is too high, the result will be
%wrong, if it is too low, it will take very long
num_exc = 40;
% choose the rate for which you want to know how many excitatory neurons it
% takes
target_rate = 70;
%initialize with 0 to ensure while loop starts
rate = 0;
min_num = 0;
%flag to check whether we have found the smallest plausible candidate
found_first = false;
%check all possible numbers of neurons, take everything with 
%target/1.3 < rate for this number < target * 1.3 as candidate for correct solution
while rate < target_rate*1.3
    neuron_sim;
    if ~found_first && rate > target_rate/1.3
        min_num = num_exc;
        found_first = true;
    end
    display(rate);
    num_exc = num_exc + 1;
end
display(num_exc);
display(min_num);
maxT = 8000;
best_diff = target_rate;
best_num = min_num;
%evaluate our selected candidates with a higher precision and select best
%of these
for num_exc = min_num:num_exc
    neuron_sim;
    display(rate);
    if abs(target_rate - rate) < best_diff
        best_diff = abs(target_rate - rate);
        best_num = num_exc;
    end
end

display('finished, best estimate:');
display(best_num);
display(best_diff);
%calculate once more for our found best estimate, to get more accurate
%values
num_exc = best_num;
maxT = 30000;
neuron_sim;
display('last run');
display(coeff_v);
display(mean(voltage_nospike));
display(rate);

    