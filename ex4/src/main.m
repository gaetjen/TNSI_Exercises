%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton
clear all;
% define our time vector
deltaT = 0.1;
maxT = 40;
time_vector = 0:deltaT:maxT;

% these values just for reference
% capacitance = 10; %nF/mm^2
% conductance_leak = 3; %microS/mm^2
% conductance_K = 360; %microS/mm^2
% conductance_Na = 1200; %microS/mm^2
% reversal_leak = -54.402; %mV
% reversal_K = -77; %mV
% reversal_Na = -50; %mV

%create our neurons
neuron_zero = HHNeuron(10, 3, 360, 1200, -54.402, -77, 50, 0.3, 0, 0, -70);
neuron_med = HHNeuron(10, 3, 360, 1200, -54.402, -77, 50, 0.37, 0.08, 0.5, -65);
neuron_med_ = HHNeuron(10, 3, 360, 1200, -54.402, -77, 50, 0.37, 0.08, 0.5, -65);

%create our input currents
input_zero = time_vector * 0;
input_med = input_zero + 62; %nA/mm^2
input_med_ = input_zero + 61; %nA/mm^2

%save all state variables in one big matrix
states_zero = repmat(input_zero, 4, 1);
%from top to bottom: membrane voltage, n, m, h
[voltage, n, m, h] = get_state(neuron_zero);
states_zero(:, 1) = [voltage, n, m, h]';

states_med = repmat(input_zero, 4, 1);
[voltage, n, m, h] = get_state(neuron_med);
states_med(:, 1) = [voltage, n, m, h]';

states_med_ = repmat(input_zero, 4, 1);
[voltage, n, m, h] = get_state(neuron_med_);
states_med_(:, 1) = [voltage, n, m, h]';

for i = 2:length(time_vector)
    neuron_zero = input_step(neuron_zero, input_zero(i - 1), deltaT);
    [voltage, n, m, h] = get_state(neuron_zero);
    states_zero(:, i) = [voltage, n, m, h]';
    
    neuron_med = input_step(neuron_med, input_med(i - 1), deltaT);
    [voltage, n, m, h] = get_state(neuron_med);
    states_med(:, i) = [voltage, n, m, h]';
    
    neuron_med_ = input_step(neuron_med_, input_med_(i - 1), deltaT);
    [voltage, n, m, h] = get_state(neuron_med_);
    states_med_(:, i) = [voltage, n, m, h]';
end

make_figures(time_vector, states_zero);
make_figures(time_vector, states_med);
make_figures(time_vector, states_med_);

%we can now check what the steady state values are and do the large input
%current
display('steady states V, n, m, h:');
ss = states_zero(:, end)
%create input current
input_large = input_zero + 100; %nA/mm^2
%create neuron with the steady states
neuron_large = HHNeuron(10, 3, 360, 1200, -54.402, -77, 50, ss(2), ss(3), ss(4), ss(1));
%initialize result matrix
states_large = repmat(input_zero, 4, 1);
[voltage, n, m, h] = get_state(neuron_large);
states_large(:, 1) = [voltage, n, m, h]';

for i = 2:length(time_vector)
    neuron_large = input_step(neuron_large, input_large(i - 1), deltaT);
    [voltage, n, m, h] = get_state(neuron_large);
    states_large(:, i) = [voltage, n, m, h]';
end  
make_figures(time_vector, states_large);