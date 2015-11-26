function S = OffSpot( n )


% returns stimulus array of size n x n, 
%
% with a dark spot, 
%
% spot position (x0,y0) is random
%
% stimulus values between -1 and 1

S = zeros(n:n);

x=-0.5*(n+1)+[1:n];
y=-0.5*(n+1)+[1:n];

[X,Y] = meshgrid( x, y );

x0 = 0.8 * (rand-0.5) * n;
y0 = 0.8 * (rand-0.5) * n;

S = -exp( - 0.5 * ( (X-x0).^2  + (Y-y0).^2 ) );

s_max = max(max(-S));

S = 2*(0.5+S/s_max);
