% Caso 1 - item 2

clear all; clc; close all

%genero una matriz con los datos proporcionados
Data = readmatrix('G:\My Drive\a Ingenieria\2024 Primer Semestre\Sistemas de Control 2\Entregas\Pucheta\Act N1 - fecha max 23_04\Consignas\Curvas_Medidas_RLC_2024.xls');
DataBis = readmatrix('Curvas_Medidas_RLC_2024.xls');

%genero las graficas correspondientes a cada dato en funcion del tiempo 
fig = figure(1);
fig.Name = 'Corriente';
plot(Data(:,1),Data(:,2)); %genero un grafico de la corriente (col 2) en funcion del tiempo (col 1)
title('Corriente i') %esta es una variable de estado
xlabel('Tiempo [s]');
ylabel('Corriente [A]');

fig = figure(2);
fig.Name = 'Tension del Capacitor';
plot(Data(:,1),Data(:,3)); %genero un grafico de la tension del capacitor (col 3) en funcion del tiempo (col 1)
title('Tension Vc') %esta es una variable de estado
xlabel('Tiempo [s]');
ylabel('Tension [V]');

fig = figure(3);
fig.Name = 'Tension de Entrada';
plot(Data(:,1),Data(:,4)); %genero un grafico de la tension de entrada (col 4) en funcion del tiempo (col 1)
title('Tension Vin') %esta es una variable de entrada
xlabel('Tiempo [s]');
ylabel('Tension [V]');

%   Observando las graficas, se puede apreciar:
%       Condiciones iniciales nulas
%       Retardo = 0.01 [s]
%       Duracion de cada estado de la entrada = 0.04 [s]
%       Amplitud de la tension de entrada = 12 [V] -> varia entre +12 y -12
%       Amplitud de la tension de capacitor = 12 [V]
%
