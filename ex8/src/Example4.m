function Example4

clear all;
close all;


%% examples of using the function SensResp4

% 10 stimuli of strength s=4

'10 times with s=4'
    
    Sin = repmat( [4], 1, 10 )
    
    Xout = SensResp4( Sin )
    
    Xmean = mean(Xout, 2)  % mean of response  over repeats
    
    Xstd  = std(Xout, 0, 2)   % standard deviation  over repeats
    
    
% 10 stimuli B with strength s=6

'10 times with s=6'
    
    Sin = repmat( [6], 1, 10 )
    
    Xout = SensResp4( Sin )
    
    Xmean = mean(Xout, 2)  % mean of response over repeats
    
    Xstd = std(Xout, 0, 2)   % standard deviation over repeats

    
    
    
% 20 stimuli of randomly chosen strength


'20 stimuli between s=0 and s=20'
    
    Xin = 20 * rand(1,20);
    
    [srt, idx] = sort( rand(1,20) );
    
    Sin = Xin(:,idx)
    
    Xout = SensResp4( Sin )
    
    Xmean = mean(Xout, 2)  % mean of response
    
    Xstd  = std(Xout, 0, 2)   % standard deviation
    
    
