%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton

%input stimuli
sin = 5:20;
%possible responses
xout = 0:30;
%prior joint probability distributions and expected response for a given
%stimulus
[prior_x_and_s, expected_x] = RespPDF(sin, xout);

marginal_x = sum(prior_x_and_s, 3);

%P(s|x) = P(s,x) / P(x)
cond_stim_ll = prior_x_and_s ./ repmat(marginal_x, [1, 1, 16]);

ShowRespPDF(sin, xout, cond_stim_ll, expected_x);
%preferred stimuli: 5, 10, 15 and 20 respectively


%assignment 2: stimulus likelihoods
resp=[11, 8, 3, 1; 1, 4, 10, 4; 2, 0, 5, 8];
num_stim = length(sin);
cond_stim_ll = permute(cond_stim_ll, [3, 1, 2]);
idx = sub2ind([size(cond_stim_ll, 2), size(cond_stim_ll, 3)], repmat(1:4,3, 1), resp + 1);
log_ll = zeros(3, num_stim);
for s = 1:num_stim
    log_ll(:, s) = sum(reshape(log(cond_stim_ll(s, idx)), 3, 4), 2);
end
figure;
plot(sin, log_ll');
legend('a', 'b', 'c', 'Location', 'south');

%assignment 3
num_rep = 100;
stimuli = repmat(sin', 1, num_rep);

responses = zeros(4, 16, num_rep);

%get all the neuronal responses
for s = 1:num_stim
    stimulus = stimuli(s, :);
    response = SensResp4(stimulus);
    responses(:, s, :) = response;
end

%calculate all the stimulus likelihoods
% likelihood for stimulus x actual stimulus x number of repetitions 
log_ll = zeros(num_stim, num_stim, num_rep);
for r = 1:num_stim*num_rep
    resp = responses(:, r);
    idx = sub2ind([size(cond_stim_ll, 2), size(cond_stim_ll, 3)], 1:4, resp' + 1);
    for s = 1:num_stim
        log_ll(s, r) = sum(log(cond_stim_ll(s, idx)));
    end
end

%get indices for maximum likelihoods
[~, ml_stim] = max(log_ll, [], 2);
%add 4, because stimuli go from 5-20
ml_stim = ml_stim + 4;

stim_av = mean(ml_stim, 3);
stim_std = std(ml_stim, 0, 3);
figure;
plot(sin, sin, '--r'); hold on;
plot(sin, stim_av);
plot(sin, stim_av + stim_std, 'g');
plot(sin, stim_av - stim_std, 'g');

