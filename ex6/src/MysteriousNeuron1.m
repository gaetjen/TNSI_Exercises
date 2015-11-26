function r = MysteriousNeuron1( S )

% a mysterious visual neuron is stimulated with a 2D stimulus
% array s and responds with a spike rate r (in spikes per second)

[yh,xw] = size( S );

A = zeros(yh,xw);

[X,Y] = meshgrid( -0.5*(yh+1)+[1:yh], -0.5*(xw+1)+[1:xw] );

A = 0.0016 * exp( - 0.005 * (X.^2 + Y.^2) ) .* cos( 0.433 * X + 0.25 * Y + 0.5 );

r = sum(sum(A .* S)) / sum(sum(A .* A));

if r < 0 
    r = 0;
end

r = r^3 / ( 0.3^2.5 + r^2.5 );

r = r + ( 0.1 + 0.1 * r ) * randn;



