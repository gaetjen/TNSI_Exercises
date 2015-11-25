%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton
% simulates two neurons with parameterized synaptic inputs
% one neuron has a firing mechanism, while the other does not
% requires all of these variables.
% variables are defined outside of script to facilitate rapidly changing
% values (exc_only, exc_inh and operating_point scripts)

% deltaT = 0.1;
% maxT = 200;
% time_vector = 0:deltaT:maxT;
% 
% rate_exc = 20;
% rate_inh = 20;
% tau_exc = 1;
% tau_inh = 2;
% num_exc = 30;
% num_inh = 1;

time_vector = 0:deltaT:maxT;
% we want one spiking and one nonspiking neuron
neuron_spiking = LIFSynNeuron(10, -54, -70, -70, -65, 0, -80, 1.2, 0.1, 0.5, 1);
neuron_nospike = LIFSynNeuron(10, -54, -70, -70, -65, 0, -80, 1.2, 0.1, 0.5, 0);

% get the time courses for the synaptic activation
act_exc = synaptic_activation(rate_exc * num_exc, time_vector, tau_exc);
act_inh = synaptic_activation(rate_inh * num_inh, time_vector, tau_inh);

% vectors to save time-dependent membrane voltage
voltage_spiking = time_vector * 0;
voltage_nospike = time_vector * 0;

voltage_spiking(1) = neuron_spiking.potential_membrane;
% vector to save when spikes occurred
t_spikes = [];
voltage_nospike(1) = neuron_nospike.potential_membrane;

% iteratively give neurons synaptic input and save the membrane voltage
for i = 2:length(time_vector)
    [neuron_spiking, spike] = time_step(neuron_spiking, act_exc(i-1), act_inh(i-1), deltaT);
    voltage_spiking(i) = neuron_spiking.potential_membrane;
    if spike
        t_spikes = [t_spikes, time_vector(i)];
    end
        
    neuron_nospike = time_step(neuron_nospike, act_exc(i-1), act_inh(i-1), deltaT);
    voltage_nospike(i) = neuron_nospike.potential_membrane;
end

% calculate our measures of interest
inter_spikes = diff(t_spikes);
% averate inter spike interval length
inter_mean = mean(inter_spikes);
std_dev = std(inter_spikes);
% coefficient of variation of inter spike interval lengths
coeff_v = std_dev/inter_mean;
% firing rate in Hz (convert maxT to seconds to get Hz instead of kHz)
rate = length(t_spikes)/(maxT/1000);

plot(time_vector, voltage_spiking, 'LineWidth', 2);
hold on;
plot(time_vector, voltage_nospike, '--r', 'LineWidth', 2);
xlabel('time [ms]', 'interpreter', 'latex', 'Fontsize', 16);
ylabel('membrane voltage [mV]', 'interpreter', 'latex', 'Fontsize', 16);
legend('spiking neuron', 'non-spiking neuron', 'location', 'southeast');
