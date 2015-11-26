rads = (0:11)*pi/12;
stimulusSize = 50;
responses1_m_std = [rads * 0; rads*0];
responses2_m_std = [rads * 0; rads*0];
repititions = 5000;
s_types = [1,2];

for s = s_types
    for i = 1:length(rads)
        display(i);
        rep_response1 = 1:repititions;
        rep_response2 = 1:repititions;
        for j = 1:repititions
            if s == 1
                stimulus = OnBar(stimulusSize, rads(i));
            else
                stimulus = OffBar(stimulusSize, rads(i));
            end
            rep_response1(j) = MysteriousNeuron1(stimulus);
            rep_response2(j) = MysteriousNeuron2(stimulus);
        end
        responses1_m_std(1, i) = mean(rep_response1);
        responses1_m_std(2, i) = std(rep_response1);
        responses2_m_std(1, i) = mean(rep_response2);
        responses2_m_std(2, i) = std(rep_response2);
    end
    
    if s == 1
        figure('Position', [50, 50, 400, 600], 'Name', 'On Bar');
    else
        figure('Position', [50, 50, 400, 600], 'Name', 'Off Bar');
    end
    subplot(2, 1, 1);
    plot(rads, responses1_m_std(1,:));hold on;
    plot(rads, responses1_m_std(1,:) + responses1_m_std(2,:), 'r');
    plot(rads, responses1_m_std(1,:) - responses1_m_std(2,:), 'r');
    subplot(2, 1, 2);
    plot(rads, responses2_m_std(1,:));hold on;
    plot(rads, responses2_m_std(1,:) + responses2_m_std(2,:), 'r');
    plot(rads, responses2_m_std(1,:) - responses2_m_std(2,:), 'r');
end