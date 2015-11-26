stimulusSize = 50;
ave_stim1 = zeros(stimulusSize);
ave_stim2 = zeros(stimulusSize);
ave_cov1 = zeros(stimulusSize ^2);
ave_cov2 = zeros(stimulusSize ^2);
s_types = 1;

for s = s_types
    if s == 3
        repititions = 100000;
    else
        repititions = 100000;
    end
    display(s);
    total_response2 = 0;
    for j = 1:repititions
        if mod(j, 500) == 0
            display(j);
        end
        if s == 1
            stimulus = OnSpot(stimulusSize);
        elseif s == 2
            stimulus = OffSpot(stimulusSize);
        else
            stimulus = WhiteNoise(stimulusSize);
        end
        stim_cov = reshape(stimulus, numel(stimulus), 1) * reshape(stimulus, 1, numel(stimulus));
        response1 = MysteriousNeuron1(stimulus);
        response2 = MysteriousNeuron2(stimulus);
        ave_stim1 = ave_stim1 + stimulus * response1;
        ave_stim2 = ave_stim2 + stimulus * response2;
    %    ave_cov1 = ave_cov1 + stim_cov * response1;
        ave_cov2 = ave_cov2 + stim_cov * response2;
        total_response2 = total_response2 + response2;
    end
    ave_cov2 = ave_cov2 ./ total_response2;
    figure;
    imshow(mat2gray(ave_stim1), 'InitialMagnification', 1000);
    figure;
    imshow(mat2gray(ave_stim2), 'InitialMagnification', 1000);
    %eigs only calculates largest eigenvalues, and is much faster
    [eigVec, eigVal] = eigs(ave_cov2, 2);
    figure;
    imshow(mat2gray(reshape(eigVec(:, 3), stimulusSize, stimulusSize)), 'InitialMagnification', 1000);
    figure;
    imshow(mat2gray(reshape(eigVec(:, 4), stimulusSize, stimulusSize)), 'InitialMagnification', 1000);
end