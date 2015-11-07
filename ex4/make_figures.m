%authors: Johannes Gätjen, Maria del Cerro, Lorena Morton
function make_figures( time, state_matrix )
%MAKE_FIGURES plots the state variables over time
    figure('Position', [200 200 800 650])
    subplot(2, 1, 1);
    plot(time, state_matrix(1, :));
    xlabel('\textbf{time [ms]}', 'interpreter', 'latex', 'Fontsize', 16);
    ylabel('\textbf{membrane voltage [mV]}', 'interpreter', 'latex', 'Fontsize', 16);
    subplot(2, 1, 2);
    plot(time, state_matrix(2:end, :));
    xlabel('\textbf{time [ms]}', 'interpreter', 'latex', 'Fontsize', 16);
    ylabel('\textbf{gating variable []}', 'interpreter', 'latex', 'Fontsize', 16);
    legend('n', 'm', 'h');
end

