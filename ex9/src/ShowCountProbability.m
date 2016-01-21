function ShowCountProbability( P_count_and_condition, count_range, nu_i, t0, Nspike )

global fs;

[Ncondition, Nrange] = size( P_count_and_condition );

count_min = min( count_range );
count_max = max( count_range );

P_condition = sum(P_count_and_condition,2);
P_count_given_condition = P_count_and_condition ./ repmat(P_condition,1,Nrange);

scale = 0.8 / max(P_count_given_condition(:));

tend = 2 * Nspike / nu_i(1);   % choose suitable time range, tend = 2 * Nspike / nu 

figure;
hold on;
for i=1:Ncondition
    
    lambda = nu_i(i) * t0;
    
    pkt = Multiintervaldistribution( lambda, count_range );  
    plot( count_range, (i-1) + scale * pkt, 'r', 'LineWidth', 2 );

    plot( count_range, (i-1) + scale * P_count_given_condition( i, :), 'k', 'LineWidth', 2 );
    

    
    plot( [count_min count_max], [1 1]*(i-1), 'k' );
    
    text( tend-1, i-0.5, ['\nu = ' num2str(nu_i(i),'%4.2f') ], 'FontSize', fs );
end
hold off;

set( gca, 'FontSize', fs );

set( gca, 'PlotBoxAspectRatio', [1 2 1]);

xlabel( 'spike count', 'FontSize', fs );

ylabel( 'probability', 'FontSize', fs );

title( 'Count probability, observed and expected', 'FontSize', fs+4 );

return;