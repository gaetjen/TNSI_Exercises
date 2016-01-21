function pkt = Multiintervaldistribution( lambda, range )

% Poisson multi-interval distribution

% lambda average number

% range range of counts

pkt = zeros(size(range));

for i=1:numel(range)
    
    n = range(i);
    
    pkt(i) = exp( n * log(lambda) - lambda - sum(log(1:n)) );
    
end

return;