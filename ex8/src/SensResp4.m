function Xout = SensResp4( Sin )

global Rmax Rdark SA SB SC SD gamma2A gamma2B gamma2C gamma2D;

% input of size [1,n], representing a series of stimuli ;

% output of sizze[4,n], representing series of population responses ;

%% ensure that input meets requirements (correct matrix size), range 5 to 20

[n,m] = size( Sin );

if n ~= 1
    'size(Sin) ~= [1,n]'
    return;
end


kk = find( Sin < 5 );
if ~isempty(kk)
    Sin(kk) = 5 * ones(size(kk));
end

kk = find( Sin > 20 );
if ~isempty(kk)
    Sin(kk) = 20 * ones(size(kk));
end

%% get tuning parameters of neurons A, B, C, D

SetParams;


Rout = nan( 4, m );

Sin2 = Sin.^2;

Rout(1,:) = Rdark + Rmax * exp( -(Sin-SA).^2 / gamma2A );
Rout(2,:) = Rdark + Rmax * exp( -(Sin-SB).^2 / gamma2B );
Rout(3,:) = Rdark + Rmax * exp( -(Sin-SC).^2 / gamma2C );
Rout(4,:) = Rdark + Rmax * exp( -(Sin-SD).^2 / gamma2D );
    

%% compute actual (noisy) response to each stimulus

Xout=poissrnd(Rout);


