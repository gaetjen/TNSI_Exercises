function Xout = SensResp( Sin )

% input of size [2,n], representing a series of stimuli A = [s,0]'; or B = [0,s]';

% mean response is

% r = rmax * s^2 / ( sA^2 + s^2 )  for stimuli A
%
% r = rmax * s^2 / ( sB^2 + s^2 )  for stimuli B

% actual response is Poisson distributed

% background response level darkLight = 3;
% 
% if s is a vector, then r is another vector of the same size

%% ensure that input meets requirments (correct matrix size?  smaller entry
% of each pair must be zero

[n,m] = size( Sin );

if n ~= 2
    'size(Sin) ~= [2,n]'
    return;
end

kk = find( Sin(1,:) >= Sin(2,:) );
Sin(2,kk) = zeros(size(kk));
ll = find( Sin(1,:) <  Sin(2,:) );
Sin(1,ll) = zeros(size(ll));


%% compute average response to each stimulus

SA = 5;

SB = 10;

Rmax = 20;

Rdark = 1;

Rout = nan( 1, m );

kk = find(Sin(1,:) ~= 0);

if ~isempty(kk)
    Sin2 = Sin(1,kk).^2;
    
    Rout(kk) = Rdark + Rmax * Sin2 ./ ( SA^2 + Sin2 );
    
end

ll = (Sin(2,:) ~= 0);
if ~isempty(ll)
    
    Sin2 = Sin(2,ll).^2;
    
    Rout(ll) = Rdark + Rmax * Sin2 ./ ( SB^2 + Sin2 );
end
%% compute actual (noisy) response to each stimulus

xrand=rand(size(Rout));

Xout=poissinv(xrand,Rout);