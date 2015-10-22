%Authors: Maria del Cerro, Johannes Gätjen, Lorena Morton
%initialize the constants
R=8.31;
T=310;
F=96485;
Vt=(R*T/F)*1000;  % multiply by 1000 to convert V to mV

% potassium reversal potential with Nernst equation
K_out=5;K_in=140;
z=1;
Erev_K=(Vt/z)*log(K_out/K_in);

% sodium reversal potential
Na_out=145;Na_in=15;
z=1;
Erev_Na=(Vt/z)*log(Na_out/Na_in);

% chloride reversal potential
Cl_out=110;Cl_in=13;
z=-1;
Erev_Cl=(Vt/z)*log(Cl_out/Cl_in);

%output of results
display([Erev_K,Erev_Na,Erev_Cl]);

%solutions for Goldman equation were calculated with calculator