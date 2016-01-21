function Fcorrect = IdentificationPerformance( nu_i, count_range, t0 )

Ncondition = numel( nu_i );

Nrange = numel( count_range );

P_count_given_condition = zeros( Ncondition, Nrange );

for i=1:Ncondition
    
    lambda = nu_i(i) * t0;
    
    P_count_given_condition( i, : ) = Multiintervaldistribution( lambda, count_range );  
    
end


P_count_and_condition = P_count_given_condition / Ncondition;

P_count = sum( P_count_and_condition, 1 );

P_condition = sum( P_count_and_condition, 2 );

P_condition_given_count = P_count_and_condition./repmat(P_count,Ncondition,1);

f_correct = max( P_condition_given_count );
    
Fcorrect = sum( f_correct .* P_count );
    
return;