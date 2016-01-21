%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton
function [ H_joint, H_count, H_condition, H_condition_given_count, H_count_given_condition ] = GetEntropies( P_count_and_condition )
    %GETENTROPIES Compute the different entropies from a joint probability
    %distribution
    
    [Ncondition, Ncount] = size(P_count_and_condition);
    %marginal probabilities for the counts and conditions
    P_count = sum(P_count_and_condition, 1);
    P_condition = sum(P_count_and_condition, 2);
    
    zero_counts = P_count == 0;
    zero_conditions = P_condition == 0;
   
    P_count_no_zero = P_count(~zero_counts);
    P_condition_no_zero = P_condition(~zero_conditions);
    
    P_given_count = zeros(size(P_count_and_condition));
    P_given_count(:, ~zero_counts) = P_count_and_condition(:, ~zero_counts) ./ repmat(P_count_no_zero, Ncondition, 1);
    
    P_given_condition = zeros(size(P_count_and_condition));
    P_given_condition(~zero_conditions, :) = P_count_and_condition(~zero_conditions, :) ./ repmat(P_condition_no_zero, 1, Ncount);
    
    H_count = - sum(P_count_no_zero(:) .* log2(P_count_no_zero(:)));
    H_condition = - sum(P_condition_no_zero(:) .* log2(P_condition_no_zero(:)));
    
    P_given_count_no_zero = P_given_count(P_given_count ~= 0);
    P_given_condition_no_zero = P_given_condition(P_given_condition ~= 0);
    
    P_joint_no_count_zero = P_count_and_condition(P_given_count ~= 0);
    P_joint_no_condition_zero = P_count_and_condition(P_given_condition ~= 0);
    
    H_condition_given_count = -sum(P_joint_no_count_zero(:) .* log2(P_given_count_no_zero(:)));
    H_count_given_condition = -sum(P_joint_no_condition_zero(:) .* log2(P_given_condition_no_zero(:)));
    
    P_joint_no_zero = P_count_and_condition(P_count_and_condition ~= 0);
    H_joint = - sum(P_joint_no_zero(:) .* log2(P_joint_no_zero(:)));

end

