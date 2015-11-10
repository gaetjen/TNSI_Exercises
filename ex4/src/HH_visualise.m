% Course on theoretical neuroscience
% Teacher: Jochen Braun
% Assistent teachers: Stephanie Lehmann, Joachim Haenicke
% Exercise05: The Hodgkin-Huxley Model
% Example function to plot voltage dependent equilibrium values and time
% constants of gating variables.
% 09/25/09

function HH_visualise

Vm = -100:0.1:20; % A vector with a varying membrane potential in mV.

% Get equilibrium values and time constants for each gating variable using
% the provided functions.
[m_infty, tau_m] = HH_equi_tau_m(Vm); 
[h_infty, tau_h] = HH_equi_tau_h(Vm);
[n_infty, tau_n] = HH_equi_tau_n(Vm);

figure;

subplot(1,2,1);
plot(Vm, m_infty, 'r', 'LineWidth', 2.0);
hold on;
plot(Vm, h_infty, 'g--', 'LineWidth', 2.0);
plot(Vm, n_infty, 'b', 'LineWidth', 2.0);
hold off;
axis 'square';
legend('m','h', 'n','Location','SouthEast');
xlabel('V_m [mV]','FontWeight','b','FontSize',12);
ylabel('z_\infty [.]','FontWeight','b','FontSize',12);
title('Equilibium values m_\infty , h_\infty , n_\infty','FontWeight','b','FontSize',12);
set(gca,'FontWeight','bold','FontSize',12)

subplot(1,2,2);
plot(Vm, tau_m, 'r', 'LineWidth', 2.0);
hold on;
plot(Vm, tau_h, 'g--', 'LineWidth', 2.0);
plot(Vm, tau_n, 'b', 'LineWidth', 2.0);
hold off;
axis 'square';
legend('m','h', 'n','Location','NorthEast');
xlabel('V_m [mV]','FontWeight','b','FontSize',12);
ylabel('\tau_z [ms]','FontWeight','b','FontSize',12);
title('Time constants  \tau_m, \tau_h, \tau_n','FontWeight','b','FontSize',12);
set(gca,'FontWeight','bold','FontSize',12)

