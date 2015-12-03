%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton
stimulusSize = 50;
ave_stim1 = zeros(stimulusSize);
ave_stim2 = zeros(stimulusSize);
totalresponse1 = 0;
totalresponse2 = 0;
s_types =1:3;

for s = s_types
    if s == 3
        repititions = 15000;
    else
        repititions = 5000;
    end
    for j = 1:repititions
        if s == 1
            stimulus = OnSpot(stimulusSize);
        elseif s == 2
            stimulus = OffSpot(stimulusSize);
        else
            stimulus = WhiteNoise(stimulusSize);
        end
        response1 = MysteriousNeuron1(stimulus);
        response2 = MysteriousNeuron2(stimulus);
        totalresponse1 = totalresponse1 + response1;
        totalresponse2 = totalresponse2 + response2;
        ave_stim1 = ave_stim1 + stimulus * response1;
        ave_stim2 = ave_stim2 + stimulus * response2;
    end
    % ave_stim1 = ave_stim1;
    figure;
    imshow(mat2gray(ave_stim1/totalresponse1), 'InitialMagnification', 1000);
    figure;
    imshow(mat2gray(ave_stim2/totalresponse2), 'InitialMagnification', 1000);
end