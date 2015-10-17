% Author: Johannes Gätjen

function newVoltage = voltage_Tplus1( membraneVoltage, deltaT, membraneResistance, electrodeCurrent, timeConstant)
%VOLTAGE_TPLUS1 calculate the membrane voltage at time t + deltaT
    firstPart = membraneVoltage * (1 - deltaT / timeConstant);
    secondPart = membraneResistance * electrodeCurrent * deltaT / timeConstant;
    newVoltage = firstPart + secondPart;
end

