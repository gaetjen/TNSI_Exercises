%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton
function new_value = exponential_relaxation(current_value, target_value, time_constant, deltaT)
    %EXPONENTIAL_RELAXATION calculates the new value for an exponential relaxation
    new_value = target_value + (current_value - target_value)*exp(-deltaT/time_constant);
end