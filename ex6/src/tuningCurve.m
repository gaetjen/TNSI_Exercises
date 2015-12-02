%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton
%maximum 1: 30°
%maximum 2: 60°
num_deg_samples = 12;
rads = (0:num_deg_samples-1)*pi/num_deg_samples;
degs = rads ./ pi * 180;
stimulusSize = 50;
responses1_m_std = [rads * 0; rads*0];
responses2_m_std = [rads * 0; rads*0];
repititions = stimulusSize;
s_types = [1,2];

figure('Position', [50, 50, 800, 600], 'Name', 'Left: On Bar, Right: Off Bar');
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
        subplot(2, 2, 1);
    else
        subplot(2, 2, 2);
    end
    plot(degs, responses1_m_std(1,:));hold on;
    plot(degs, responses1_m_std(1,:) + responses1_m_std(2,:), '--r');
    plot(degs, responses1_m_std(1,:) - responses1_m_std(2,:), '--r');
    xlabel('bar angle [$^\circ$]', 'interpreter', 'latex', 'fontsize', 16);
    ylabel('firing rate [Hz]', 'interpreter', 'latex', 'fontsize', 16);
    l=legend('$\mu$', '$\mu \pm \sigma$'); 
    set(l, 'interpreter', 'latex', 'Fontsize', 12)
    if s == 1
        subplot(2, 2, 3);
    else
        subplot(2, 2, 4);
    end
    plot(degs, responses2_m_std(1,:));hold on;
    plot(degs, responses2_m_std(1,:) + responses2_m_std(2,:), '--r');
    plot(degs, responses2_m_std(1,:) - responses2_m_std(2,:), '--r');
    xlabel('bar angle [$^\circ$]', 'interpreter', 'latex', 'fontsize', 16);
    ylabel('firing rate [Hz]', 'interpreter', 'latex', 'fontsize', 16);
    l=legend('$\mu$', '$\mu \pm \sigma$'); 
    set(l, 'interpreter', 'latex', 'Fontsize', 12)
end