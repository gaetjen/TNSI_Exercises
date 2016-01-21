%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton

global fs;
fs = 12;
close all;

Ncondition = 8;
nu_i = linspace( 5, 20, Ncondition);
Nrepeat = 100;
Nspike = 20;
t_ink = SpikeRaster (nu_i, Ncondition, Nrepeat, Nspike );

t_zero = 0.5;

[count_prob, range] = CountProbability(t_ink, t_zero);

ShowCountProbability(count_prob, range, nu_i, t_zero, Nspike);

[H_joint, H_count, H_condition, H_given_count, H_given_condition] = GetEntropies(count_prob);

display('Mutual information:');
mutual = H_count + H_condition - H_joint

%allow for limited floating point precision
epsilon = 10^-12;
assert(mutual - (H_count - H_given_condition) < epsilon, 'Mutual information not consistent!');
assert(mutual - (H_condition - H_given_count) < epsilon, 'Mutual information not consistent!');
display('Mutual information consistent.');

%% assignment 3
Nrepeat = 1000;
t_vect = [0.4 0.8 1.2 1.6 2];
%t_vect = 30:10:200;
f_emp = [];
f_ea = [];
f_ana = [];
for t_zero = t_vect;
    t_ink = SpikeRaster(nu_i, Ncondition, Nrepeat, Nspike);
    [count_prob, range] = CountProbability(t_ink, t_zero);
    %%%% like in IdentificationPerformance
    P_count = sum(count_prob);
    P_condition_given_count = count_prob ./ repmat(P_count,Ncondition,1);
    f_correct = max( P_condition_given_count );
    Fcorrect = sum( f_correct .* P_count );
    %%%%
    [H_joint, H_count, H_cond, ~, ~] = GetEntropies(count_prob);
    mutual = H_count + H_cond - H_joint;
    f_emp = [f_emp, (2^mutual)/Ncondition];
    f_ana = [f_ana, IdentificationPerformance(nu_i, range, t_zero)];
    f_ea = [f_ea, Fcorrect];
end

figure;
plot(t_vect, f_emp); hold on;
plot(t_vect, f_ana, 'r');
legend('empirical', 'analytical');
xlabel('time [s]');
ylabel('fraction correct');
%plot(t_vect, f_ea, 'g');
% ylim([0, 0.5])