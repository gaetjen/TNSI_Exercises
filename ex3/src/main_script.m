%authors: Maria del Cerro, Johannes Gätjen, Lorena Morton

%define time vector, in seconds
delta_t = 0.0001;
time_vector = 0:delta_t:0.5;

%create our neurons, using standard units
neuron_constant = LIFNeuron(1.5, 0.02, -0.065, -0.065, -0.05, -0.065);
neuron_low = LIFNeuron(1.5, 0.02, -0.065, -0.065, -0.05, -0.065);
neuron_ramp = LIFNeuron(1.5, 0.02, -0.065, -0.065, -0.05, -0.065);

%create our input currents
input_constant = time_vector * 0 + 0.012;
input_low = input_constant .* sin(2 * pi * 4 * time_vector);
input_ramp = input_constant .* time_vector / 0.15;

%create our vectors to store the membrane voltage
voltage_vector_constant = time_vector * 0;
voltage_vector_constant(1) = neuron_constant.potential_membrane;
%in this case, all neurons start with the same potential
voltage_vector_low = voltage_vector_constant;
voltage_vector_ramp = voltage_vector_constant;

%create the vectors to store the spikes
t_spikes_constant = [];
t_spikes_low = [];
t_spikes_ramp = [];
for i = 2:length(input_constant)
    input = input_constant(i - 1);
    [neuron_constant, spike] = input_step(neuron_constant, input, delta_t);
    voltage_vector_constant(i) = neuron_constant.potential_membrane;
    if spike
        t_spikes_constant = [t_spikes_constant time_vector(i)];
    end
    
    input = input_low(i - 1);
    [neuron_low, spike] = input_step(neuron_low, input, delta_t);
    voltage_vector_low(i) = neuron_low.potential_membrane;
    if spike
        t_spikes_low = [t_spikes_low time_vector(i)];
    end
    
    input = input_ramp(i - 1);
    [neuron_ramp, spike] = input_step(neuron_ramp, input, delta_t);
    voltage_vector_ramp(i) = neuron_ramp.potential_membrane;
    if spike
        t_spikes_ramp = [t_spikes_ramp time_vector(i)];
    end
end

%plot stuff
make_figure(time_vector, input_constant, voltage_vector_constant);
make_figure(time_vector, input_low, voltage_vector_low);
make_figure(time_vector, input_ramp, voltage_vector_ramp);

%calculate and plot the inter-spike-intervals
%not for low frequency input current because there are no spikes
t_isi_constant = diff(t_spikes_constant);
t_isi_ramp = diff(t_spikes_ramp);

figure();
plot(t_isi_constant*1000);
xlabel('spike number', 'interpreter', 'latex', 'FontSize', 16);
ylabel('interval length [ms]', 'interpreter', 'latex', 'FontSize', 16);

figure();
plot(t_isi_ramp*1000);
xlabel('spike number', 'interpreter', 'latex', 'FontSize', 16);
ylabel('interval length [ms]', 'interpreter', 'latex', 'FontSize', 16);
