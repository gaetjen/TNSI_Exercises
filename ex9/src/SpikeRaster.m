function tink = SpikeRaster( nu_i, Ncondition, Nrepeat, Nspike )

global fs;

% generate spike rasters

% Nrepeat repetitions of each of the Ncondition conditions

% each repetition is terminated after Nspike spikes

tink = nan( Ncondition, Nrepeat, Nspike );   % allocate space

for i=1:Ncondition  % loop over conditions
    
    for n=1:Nrepeat  % loop over repetitions
        
        tisi_k = -log( rand(1,Nspike) ) / nu_i(i);  % Nspike Poisson intervals with rate nu_i(i)
        
        tink(i,n,:) = cumsum( tisi_k );   % spike times are cumulative sums of intervals
    end
    
end


tend = 2 * Nspike / nu_i(1);   % choose suitable time range, tend = 2 * Nspike / nu 

figure;
hold on;
for i=1:Ncondition
    for n=1:Nrepeat
        yvalue = (i-1) + (n-1)/Nrepeat;  
        plot( squeeze(tink(i,n,:)), yvalue * ones(1,Nspike), 'k.' );
    end
    plot( [0 tend], [1 1]*(i-1), 'k' );
    
    text( tend-1, i-0.5, ['\nu = ' num2str(nu_i(i),'%4.2f') ], 'FontSize', fs );
end
hold off;

set( gca, 'FontSize', fs );

set( gca, 'PlotBoxAspectRatio', [1 1 1]);

xlabel( 'time [s]', 'FontSize', fs );

ylabel( 'conditions and repeats', 'FontSize', fs );

title( 'Spike raster, conditions and repeats  ', 'FontSize', fs+4 );

return;