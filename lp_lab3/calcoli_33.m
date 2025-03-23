close all,
clearvars,
clc
format long

%% Dati (@ 1V, 5 MHz)
% ritardi [ns]
t_reg = 2;
t_inc = 48;
t_comp = 78;
t_mux = 12;

% potenza [uW]
P_reg = 0.5;
P_inc = 2.35;
P_comp = 2.4;
P_mux2 = 1.72; % mux2to1
P_mux4 = 3 * P_mux2; % mux4to1

% area [um^2]
A_reg = 309;
A_inc = 230;
A_comp = 148;
A_mux2 = 123; % mux2to1
A_mux4 = 3 * A_mux2; % mux4to1

% definizione vettori
delay = zeros(1, 6);
target_delay = zeros(1, 6);
sup = zeros(1, 6);
power = zeros(1, 6);
u_min = zeros(1,6);
Vdd_min = zeros(1,6);
P_min = zeros(1,6);

%% Circuito originale
N = 1; % datapath in parallelo
f_ref = 5; % frequenza di clock [MHz]
T_ref = (1 / f_ref) * 1e3; % periodo di clock/ritardo massimo [ns]
Vth = 0.25; % tensione di soglia [V]
Vddnom = 4 * Vth; % tensione di alimentazione nominale [V]
delay_ref = t_reg + t_inc + t_comp + t_mux; % ritardo [ns]
power_ref = 3 * P_reg + 2 * P_inc + P_comp + P_mux2; % potenza consumata [uW]
area_ref = 3 * A_reg + 2 * A_inc + A_comp + A_mux2; % occupazione d'area [um^2]

%% CASO 1 (1 DP, 0 pipe), circuito originale
% percorso critico = uguale a circuito originale
% frequenza = f_ref (la concorrenza è rimasta invariata)
% # blocchi = 3 reg, 2 inc, 1 comp, 1 mux2to1
delay(1) = delay_ref; % [ns]
target_delay(1) = T_ref; % 200 ns
sup(1) = area_ref;
power(1) = power_ref;

%% CASO 2 (1 DP, 1 pipe)
% percorso critico = pipe reg + comp + mux2to1
% frequenza = f_ref (la concorrenza è rimasta invariata)
% # blocchi = architettura originale + 2 pipe reg
delay(2) = t_reg + t_comp + t_mux; % [ns]
target_delay(2) = T_ref; % 200 ns
sup(2) = area_ref + 2 * A_reg;
power(2) = power_ref + 2 * P_reg;

%% CASO 3 (2 DP, 0 pipe)
% percorso critico = uguale a circuito originale
% frequenza = f_ref/2 perché la concorrenza è raddoppiata
% # blocchi = architettura originale raddoppiata + mux2to1 di uscita
delay(3) = delay_ref; % [ns]
target_delay(3) = 2 * T_ref; % 400 ns
sup(3) = 2 * area_ref + A_mux2;
power(3) = power_ref + P_mux2;

%% CASO 4 (2 DP, 1 pipe)
% percorso critico = pipe reg + comp + mux2to1
% frequenza = f_ref/2 perché la concorrenza è raddoppiata
% # blocchi = architettura originale raddoppiata + 4 pipe reg + mux2to1 di uscita
delay(4) = t_reg + t_comp + t_mux; % [ns]
target_delay(4) = 2 * T_ref; % 400 ns
sup(4) = 2 * area_ref + 4 * A_reg + A_mux2;
power(4) = power_ref + 4 * P_reg + P_mux2;

%% CASO 5 (2 DP, 2 pipe)
% percorso critico = pipe reg + comp
% frequenza = f_ref/2 perché la concorrenza è raddoppiata
% # blocchi = architettura originale raddoppiata + 10 pipe reg + mux2to1 di uscita
delay(5) = t_reg + t_comp; % [ns]
target_delay(5) = 2 * T_ref; % 400 ns
sup(5) = 2 * area_ref + 10 * A_reg + A_mux2;
power(5) = power_ref + 10 * P_reg + P_mux2;

%% CASO 6 (4 DP, 0 pipe)
% percorso critico = uguale a circuito originale
% frequenza = f_ref/4 perché la concorrenza è quadruplicata
% # blocchi = architettura originale quadruplicata + mux4to1 di uscita
delay(6) = delay_ref;
target_delay(6) = 4 * T_ref; % 800 ns
sup(6) = 4 * area_ref + A_mux4;
power(6) = power_ref + P_mux4;

%% Minimizzazione dei consumi e visualizzazione risultati
for i = 1:6
    [u_min(i), Vdd_min(i), P_min(i)] = minpower(Vddnom, delay(i), target_delay(i), power(i));
    fprintf('CASO %d:\n', i)
    printoutput(delay(i), target_delay(i), sup(i), power(i), u_min(i), P_min(i));
end

%% Rappresentazione grafica
t_normalized = @(u) (0.75 * u) ./ (u - 0.25); % t/tnom
P_normalized = @(u) u.^2; % P/Pnom
u_vec = linspace(0.27,1, 1e4);

figure
yyaxis left
plot(u_vec, t_normalized(u_vec), LineWidth=1.5)
hold on
plot(u_min, t_normalized(u_min), 'o')
ylabel('t/t_{nom}')
yyaxis right
plot(u_vec, P_normalized(u_vec), LineWidth=1.5)
plot(u_min, P_normalized(u_min), 'o')
ylabel('P/P_{nom}')
grid on
xlabel('u')
xlim([min(u_vec) max(u_vec)])
for i = 1:6
    xline(u_min(i), LineWidth=0.3, LineStyle='-')
end
fig = gcf;
fig.Position(3:4)=[850,450];
exportgraphics(gcf,'delay_power.pdf')

%% Funzione per stampa output
function printoutput(d, td, A, P, u, Pmin)
    fprintf('Delay critical path: %.0f ns\n', d);
    fprintf('Frequenza massima: %.2f MHz\n', 1e3/d);
    fprintf('Target delay: %.0f ns\n', td);
    fprintf('Area occupata: %.0f um^2\n', A);
    fprintf('Consumo di potenza: %.2f uW\n', P);
    fprintf('Fattore di riduzione di Vdd: %.2f\n', u);
    fprintf('Consumo di potenza minimo: %.2f uW\n', Pmin);
    fprintf('\n');
end

%% Funzione per calcolare i consumi minimi
function [u_min, Vdd_min, power_min] = minpower(Vddnom, d, td, P)
    u_min = (td / d) * (td / d - 0.75)^(-1) * 0.25; % Vdd/Vddnom
    Vdd_min = Vddnom * u_min; % Vdd minima
    power_min = P * u_min^2; % potenza minima
end