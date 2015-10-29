classdef LIFNeuron
    %LIFNEURON Encapsulate the behavior of a leaky integrate-and-fire
    %neuron
    
    properties
        resistance
        capacitance
        %put "potential" at the front of all variable names, specify the
        %type of potential at the end
        potential_reverse
        potential_reset
        potential_threshold
        potential_membrane
        time_constant
    end
    
    methods
        function obj = LIFNeuron(resistance, capacitance, potential_reverse, potential_reset, potential_threshold, potential_membrane_start)
            obj.resistance = resistance;
            obj.capacitance = capacitance;
            obj.potential_reverse = potential_reverse;
            obj.potential_reset = potential_reset;
            obj.potential_threshold = potential_threshold;
            obj.potential_membrane = potential_membrane_start;
            obj.time_constant = resistance * capacitance;
        end
        
        function [obj, spike] = input_step(obj, input_current, delta_t)
            %split equation into multiple parts for better readability
            spike = false;
            first_part = obj.potential_membrane * exp(-delta_t / obj.time_constant);
            second_part = input_current * obj.resistance + obj.potential_reverse;
            third_part = 1 - exp(-delta_t/obj.time_constant);
            obj.potential_membrane = first_part + second_part * third_part;
            if obj.potential_membrane > obj.potential_threshold
                obj.potential_membrane = obj.potential_reset;
                spike = true;
            end
        end
    end
    
end

