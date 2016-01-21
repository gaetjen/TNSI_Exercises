%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton

function [ P_count_and_condition, count_range ] = CountProbability( t_ink, t_zero )

    [Ncondition, Nrepeat, ~] = size(t_ink);
    %for every condition and repeat, count number of spikes that occured before t_zero
    spike_counts = sum(t_ink < t_zero, 3);

    count_min = min(spike_counts(:));
    count_max = max(spike_counts(:));
    count_range = count_min:count_max;

    P_count_given_condition = zeros(Ncondition, length(count_range));

    for idx = 1:length(count_range)
        count = count_range(idx);
        P_count_given_condition(:, idx) = sum(spike_counts == count, 2) / Nrepeat;
    end

    %uniformly distributed conditions, so P(condition) = 1/Ncondition
    P_count_and_condition = P_count_given_condition / Ncondition;

end

