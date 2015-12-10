%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton

numStimuli = 10000; %number of times each stimulus is presented
histogramBins = 0:45;
for strength = [2, 7, 200]
    stimuli = repmat([strength 0;0 strength], 1, numStimuli);
    stimuli = stimuli(:, randperm(2*numStimuli));
    
    resp = SensResp(stimuli);
    respA = resp(stimuli(1, :) ~= 0);
    respB = resp(stimuli(2, :) ~= 0);
    densA = hist(respA, histogramBins) / numStimuli;
    densB = hist(respB, histogramBins) / numStimuli;
    
    figure('Position', [100 50 400 600]);
    subplot(2, 1, 1);
    bar(histogramBins, densA, 1);
    xlim([histogramBins(1)-1, histogramBins(end)+1]);
    ylim([0, 1.02 * max([densA, densB])]);
    xlabel('response to stimulus A [au]');
    ylabel('density');
    
    subplot(2, 1, 2);
    bar(histogramBins, densB, 1);
    xlim([histogramBins(1)-1, histogramBins(end)+1]);
    ylim([0, 1.02* max([densA, densB])]);
    xlabel('response to stimulus B [au]');
    ylabel('density');

end

%we have now the stimuli with strength 20 and corresponding response
%top row in roc variable: false positive rate
%bottom row: true positive rate
roc = [histogramBins;histogramBins];
for i = 1:length(histogramBins)
    criterion = histogramBins(i);
    %count all responses larger or equal to the criterion
    roc(1, i) = sum(respB>=criterion)/numStimuli;
    roc(2, i) = sum(respA>=criterion)/numStimuli;
end
figure;
plot(roc(1, :), roc(2, :));
hold on;
plot([0 1], [0, 1], '--k')
axis equal
xlim([0 1]);
ylim([0 1]);
xlabel('false alarm rate');
ylabel('hit rate');
%reverse order, because line starts at right side
auc = trapz(roc(1, end:-1:1), roc(2, end:-1:1))

marginalX = (densA + densB) / 2;
conditionalA = densA * 0.5 ./ marginalX;
conditionalB = densB * 0.5 ./ marginalX;


figure;
plot(histogramBins, conditionalA);
hold on;
plot(histogramBins, conditionalB, 'r');
legend('L(A|x)', 'L(B|x)');
xlabel('response rate x');
ylabel('probability');
