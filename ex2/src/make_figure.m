% Author: Johannes Gätjen, Lorena Morton, Maria del Cerro

function make_figure( timeVector, electrodeCurrent, capacitorCurrent, membraneVoltage , membraneResistance)
%MAKE_FIGURES Takes all the calculated data and puts it into a nice figure
    figure('Position', [200, 200, 800, 500]);
    subplot(2, 1, 1);
    plot(timeVector, electrodeCurrent); 
    hold on;
    plot(timeVector, capacitorCurrent, 'r');
    % membrane current
    plot(timeVector, membraneVoltage / membraneResistance, 'g');
    xlabel('time [ms]', 'FontSize', 16, 'interpreter', 'latex');
    ylabel('current $[\frac{nA}{mm^2}]$', 'FontSize', 16, 'interpreter', 'latex');
    xlim([timeVector(1) timeVector(length(timeVector))]);
    legend('electrode current', 'capacitor current', 'membrane current', 'Location', 'eastoutside');
    subplot(2, 1, 2);
    plot(timeVector, membraneVoltage);
    hold on;
    % V_infinity
    plot(timeVector, membraneResistance * electrodeCurrent, 'r'); 
    
    xlabel('time [ms]', 'FontSize', 16, 'interpreter', 'latex');
    ylabel('Voltage [mV]', 'FontSize', 16, 'interpreter', 'latex');
    xlim([timeVector(1) timeVector(length(timeVector))]);
    legend('membrane voltage', 'equilibrium potential', 'Location', 'eastoutside');
end

