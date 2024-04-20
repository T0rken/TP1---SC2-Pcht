%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Caso 2 - item 5
clear all; clc; close all
%   " A partir de las curvas de mediciones de las variables graficadas en la Fig. 1-3, se requiere 
%   obtener el modelo del sistema considerando como entrada un escalón de 12V, como salida a la 
%   velocidad angular, y al torque de carga TL aplicado una perturbación."
%    Se requiere obtener el modelo dinámico, para establecer las constantes del modelo 
%   (1-5) (1-6).  

%   Genero una matriz con los datos proporcionados
Data = readmatrix('G:\My Drive\a Ingenieria\2024 Primer Semestre\Sistemas de Control 2\Entregas\Pucheta\Act N1 - fecha max 23_04\Consignas\Curvas_Medidas_Motor_2024.xls');
DataBis = readmatrix('Curvas_Medidas_Motor_2024.xls');
%   Notese que las muestras no estan equiespaciadas en el tiempo

%   Genero las graficas correspondientes a cada dato en funcion del tiempo
fig = figure(1);
fig.Name = 'Vel angular';
plot(Data(:,1),Data(:,2),'r'); %genero un grafico de la corriente (col 2) en funcion del tiempo (col 1)
title('Velocidad angular [rad/seg]') %esta es una variable de estado
xlabel('Tiempo [s]');
ylabel('Velocidad angular [rad/seg]');
grid on

fig = figure(2);
fig.Name = 'i armadura';
plot(Data(:,1),Data(:,3),'b'); %genero un grafico de la corriente (col 2) en funcion del tiempo (col 1)
title('Corriente de armadura [A]') %esta es una variable de estado
xlabel('Tiempo [s]');
ylabel('Corriente [A]');
grid on

fig = figure(3);
fig.Name = 'tension de entrada';
plot(Data(:,1),Data(:,4),'c'); %genero un grafico de la corriente (col 2) en funcion del tiempo (col 1)
title('Tension [V]') %esta es una variable de estado
xlabel('Tiempo [s]');
ylabel('Tension [V]');


fig = figure(4);
fig.Name = 'torque carga';
plot(Data(:,1),Data(:,5),'g'); %genero un grafico de la corriente (col 2) en funcion del tiempo (col 1)
title('Torque de Carga [N.m]') %esta es una variable de estado
xlabel('Tiempo [s]');
ylabel('Newton metro [N.m]');
grid on
