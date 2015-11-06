% Author: Johannes Gätjen, Lorena Morton, Maria del Cerro

% Course on theoretical neuroscience
% Teacher: Jochen Braun
% Assistent teachers: Stephanie Lehmann, Joachim Haenicke
% Exercise02: Single-compartment model
% Main script
% 09/08/09

% clear workspace to make sure i'm not using old values
clear all;

% 2. Define parameters (rm, cm, i0, taum, V0).
membraneResistance = 0.9; % MOhm * mm^2
membraneCapacitance = 12; % nF/mm^2
electrodeCurrentStart = 25; % nA/mm^2
timeConstant = membraneResistance * membraneCapacitance; % MOhm * nF = ms
membraneVoltageStart = 0; %mV

% 3. Define time vector (dt, T, t).
minT = 0;
maxT = 250; % ms
deltaT = 0.05; %ms
timeVector = minT:deltaT:maxT; % ms

% 4. Generate your own input current vector.
electrodeCurrentConstant = timeVector * 0 + electrodeCurrentStart;
electrodeCurrentLow = electrodeCurrentConstant .* sin(2 * pi * 10 * timeVector/1000); % divide by 1000 for correct scale
electrodeCurrentMed = electrodeCurrentConstant .* sin(2 * pi * 100 * timeVector/1000);
tcoarse = 0:10*deltaT:maxT;
electrodeCurrentRan = electrodeCurrentConstant .* interp1( tcoarse, 2*(rand(size(tcoarse))-0.5), timeVector);

% define membrane voltage vectors
membraneVoltageConstant = timeVector * 0 + membraneVoltageStart;
membraneVoltageLow = membraneVoltageConstant;
membraneVoltageMed = membraneVoltageConstant;
membraneVoltageRan = membraneVoltageConstant;


% 6. Iteratively calculate membrane potential and capacitor current
for i = 2:length(timeVector)
    membraneVoltageConstant(i) = voltage_Tplus1(membraneVoltageConstant(i-1), deltaT, membraneResistance, electrodeCurrentConstant(i - 1), timeConstant);
    membraneVoltageLow(i) = voltage_Tplus1(membraneVoltageLow(i-1), deltaT, membraneResistance, electrodeCurrentLow(i - 1), timeConstant);
    membraneVoltageMed(i) = voltage_Tplus1(membraneVoltageMed(i-1), deltaT, membraneResistance, electrodeCurrentMed(i - 1), timeConstant);
    membraneVoltageRan(i) = voltage_Tplus1(membraneVoltageRan(i-1), deltaT, membraneResistance, electrodeCurrentRan(i - 1), timeConstant);
end


% Plot everything
make_figure(timeVector, electrodeCurrentConstant, membraneVoltageConstant, membraneResistance);
make_figure(timeVector, electrodeCurrentLow, membraneVoltageLow, membraneResistance);
make_figure(timeVector, electrodeCurrentMed, membraneVoltageMed, membraneResistance);
make_figure(timeVector, electrodeCurrentRan, membraneVoltageRan, membraneResistance);


