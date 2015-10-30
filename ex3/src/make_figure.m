function make_figure(time, input, voltage, spikes)
%MAKE_FIGURE does everything to create the plots
    figure('Position', [100 100 800 650]);
    subplot(2, 1, 1);
    plot(time * 1000, input*1000);
    xlabel('time [ms]', 'interpreter', 'latex', 'FontSize', 16);
    ylabel('current [$\frac{\mathrm{nA}}{\mathrm{mm}^2}$]', 'interpreter', 'latex', 'FontSize', 16);
    subplot(2, 1, 2);
    plot(time*1000, voltage*1000);
    xlabel('time [ms]', 'interpreter', 'latex', 'FontSize', 16);
    ylabel('voltage [mV]', 'interpreter', 'latex', 'FontSize', 16);
end

