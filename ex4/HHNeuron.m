%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton

classdef HHNeuron
    %HHNEURON a class that stores the current state of a Hodgkin-Huxley
    %neuron
    
    properties
        capacitance %nF/mm^2
        conductance_leak %microS/mm^2
        conductance_K %microS/mm^2
        conductance_Na %microS/mm^2
        reversal_leak %mV
        reversal_K %mV
        reversal_Na %mV
        %gating variables for the sodium and potassium channels
        n
        m
        h
        membrane_voltage %mV
    end
    
    methods
        function obj = HHNeuron(capacitance, conductance_leak, conductance_K, conductance_Na, reversal_leak, reversal_K, reversal_Na, n, m, h, membrane_voltage)
            %initialize the neuron state variables and parameters
            obj.capacitance = capacitance;
            obj.conductance_leak = conductance_leak;
            obj.conductance_K = conductance_K;
            obj.conductance_Na = conductance_Na;
            obj.reversal_leak = reversal_leak;
            obj.reversal_K = reversal_K;
            obj.reversal_Na = reversal_Na;
            obj.n = n;
            obj.m = m;
            obj.h = h;
            obj.membrane_voltage = membrane_voltage;
        end
        
        function obj = input_step(obj, input_current, deltaT)
            %calculate the new state of the neuron with an input current
            %over a time deltaT
            [equilibrium_voltage, tau_eff] = equi_tau_voltage(obj, input_current);
            %calculate these before the new membrane voltage, because they
            %use the old value (at time t, not t + deltaT)
            [equi_n, tau_n] = HH_equi_tau_n(obj.membrane_voltage);
            [equi_m, tau_m] = HH_equi_tau_m(obj.membrane_voltage);
            [equi_h, tau_h] = HH_equi_tau_h(obj.membrane_voltage);
            obj.membrane_voltage = exponential_relaxation(obj.membrane_voltage, equilibrium_voltage, tau_eff, deltaT);
            obj.n = exponential_relaxation(obj.n, equi_n, tau_n, deltaT);
            obj.m = exponential_relaxation(obj.m, equi_m, tau_m, deltaT);
            obj.h = exponential_relaxation(obj.h, equi_h, tau_h, deltaT);
            
        end
        
        function [membrane_voltage, n, m, h] = get_state(obj)
            %gives some of the current state variables, i.e. the values that change
            %over time (does not include equilibrium potential and tau_eff)
            membrane_voltage = obj.membrane_voltage;
            n = obj.n;
            m = obj.m;
            h = obj.h;
        end
        
        function [equilibrium_voltage, tau] = equi_tau_voltage(obj, current)
            num1 = obj.conductance_leak * obj.reversal_leak + current;
            num2 = obj.conductance_Na * obj.m^3 * obj.h * obj.reversal_Na;
            num3 = obj.conductance_K * obj.n^4 * obj.reversal_K;
            den1 = obj.conductance_leak + obj.conductance_K * obj.n^4;
            den2 = obj.conductance_Na * obj.m^3 * obj.h;
            equilibrium_voltage = (num1 + num2 + num3)/(den1 + den2);
            tau = obj.capacitance / (obj.conductance_leak + obj.conductance_Na * obj.m^3 * obj.h + obj.conductance_K * obj.n^4);
        end
    end
end