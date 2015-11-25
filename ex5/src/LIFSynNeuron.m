%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton
classdef LIFSynNeuron
    %LIFSYNNEURON Model behavior of a LIF Neuron with synapses
    %This class encapsulates the behavior of a LIF Neuron with "one"
    %excitatory and inhibitory synapse each. Instead of considering
    %multiple synapses we just increase the synaptic activity by a factor
    
    properties
        capacitance
        potential_thresh
        potential_reset
        %the membrane potential is actually the only property that changes
        %over time
        %we do not set tau_eff or V_inf_eff as properties, because they are
        %dependent on the synaptic activity, which we give as input
        %parameters when simulating one time step. after the time step
        %calculation is finished, the membrane voltage would be at t+deltaT
        %whereas tau_eff and V_inf_eff would be at t.
        potential_membrane 
        reversal_leak
        reversal_exc
        reversal_inh
        conductance_leak
        conductance_exc
        conductance_inh
        %boolean value to be able to turn off firing behavior
        firing
    end
    
    methods
        function obj = LIFSynNeuron(capacitance, potential_thresh, potential_reset, potential_membrane, reversal_leak,...
                reversal_exc, reversal_inh, conductance_leak, conductance_exc, conductance_inh, firing)
            obj.capacitance = capacitance;
            obj.potential_thresh = potential_thresh;
            obj.potential_membrane = potential_membrane;
            obj.reversal_leak = reversal_leak;
            obj.reversal_exc = reversal_exc;
            obj.reversal_inh = reversal_inh;
            obj.conductance_leak = conductance_leak;
            obj.conductance_exc = conductance_exc;
            obj.conductance_inh = conductance_inh;
            obj.potential_reset = potential_reset;
            obj.firing = firing;
        end
        
        function [obj, spike] = time_step(obj, act_exc, act_inh, deltaT)
            %calculates the membrane voltage after a given synaptic
            %activation for time deltaT. Also returns whether a spike
            %occurred
            den = (obj.conductance_leak + obj.conductance_exc * act_exc + obj.conductance_inh * act_inh);
            tau_eff = obj.capacitance / den;
            num = (obj.conductance_leak * obj.reversal_leak + obj.conductance_exc * act_exc * obj.reversal_exc +...
                obj.conductance_inh * act_inh * obj.reversal_inh);
            potential_equi = num/den;
            %calculate new membrane potential
            obj.potential_membrane = potential_equi + (obj.potential_membrane - potential_equi)*exp(-deltaT/tau_eff);
            %handle spiking behavior
            if obj.firing && obj.potential_membrane > obj.potential_thresh
                obj.potential_membrane = obj.potential_reset;
                spike = true;
            else
                spike = false;
            end
        end
        
    end
    
end

