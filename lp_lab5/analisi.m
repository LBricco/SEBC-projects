close all
clearvars
clc
format long e

%% 5.5 Dipendenza da T
T0 = 330; % [K]
T = [-50 0 50 100 130 160 190] + 273.15; % [K]
Vth_N0 = [0.464 0.431 0.398 0.365 0.345 0.326 0.306];
Vth_N1 = [0.431 0.398 0.365 0.332 0.313 0.293 0.273];
Vth_P = [0.423 0.386 0.350 0.314 0.293 0.271 0.249];

myfittype_Vth_N0 = fittype("Vth0_n0 - k_n0*(T-330)", dependent="Vth_N0",independent="T", coefficients=["Vth0_n0" "k_n0"]);
f_Vth_N0 = fit(T', Vth_N0', myfittype_Vth_N0, 'StartPoint', [0 0.431]);
myfittype_Vth_N1 = fittype("Vth0_n1 - k_n1*(T-330)", dependent="Vth_N1",independent="T", coefficients=["Vth0_n1" "k_n1"]);
f_Vth_N1 = fit(T', Vth_N1', myfittype_Vth_N1, 'StartPoint', [0 0.431]);
myfittype_Vth_P = fittype("Vth0_p - k_p*(T-330)", dependent="Vth_N0",independent="T", coefficients=["Vth0_p" "k_p"]);
f_Vth_P = fit(T', Vth_P', myfittype_Vth_P, 'StartPoint', [0 0.431]);

%% 5.6 Dipendenza da VDD
VDD = 0.7:0.1:1.4;
P_tot = [2.34 2.98 3.72 4.59 5.61 6.79 8.16 9.74];
f_P_tot = fit(VDD', P_tot', 'poly2');

figure
h = plot(f_P_tot, VDD, P_tot, '*');
set(h(2), 'LineWidth', 1.5, 'Color', [0.8500 0.3250 0.0980])
grid on
%xlim([0 2])
xlabel('V_{DD} [V]')
ylabel('P_{tot} [nW]')
fig = gcf;
fig.Position(3:4)=[800,500];
exportgraphics(fig, 'immagini/P_tot_vs_Vdd_polyfit.pdf')