%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Caso 2 - Pre
clear all; clc; close all
%   Se pide un algoritmo de simulacion para conocer el comportamiento de
%   las variables de interes utilizando la integracion por Euler con un
%   deltaT = 1*e-3[s]

%   Tengo los valores de diferentes parametros
Laa = 366e-6;
J = 5e-9;
Ra = 55.6;
Bm = 0;
Ki = 6.49e-3;
Km = 6.53e-3;

%   Las matrices del sistema seran
matA = [-(Ra/Laa) -(Km/Laa) 0;Ki/J -(Bm/J) 0;0 1 0];
matB = [1/Laa 0;0 -(1/J);0 0];
matC1 = [1 0 0];   %considerando como variable de salida a la iA 
matC2 = [0 1 0];   %considerando como variable de salida wr
matD = [0 0];

%   Implemento euler con las caracteristicas solicitadas
t0 = 0;             %timepo inicial
tf = 5;             %tiempo de simulacion 5[s]
delta_t = 1e-5;     %timepo de paso 10^-7[s]
puntos_sim = round((tf-t0)/delta_t);
%t = linspace(t0,tf,puntos_sim);
t = t0:delta_t:tf;

%   Defino la señal de entrada Va suponiendo que se inicia pasados 0,3[seg]
u1 = zeros(1, puntos_sim);
for i=(round(0.3/delta_t)):1:(puntos_sim+1)
    u1(1,i) = 12;
end
%   Grafico la señal de entrada Va
fig = figure(1);
fig.Name = 'Entrada Va';
plot(t,u1);
title('Entrada Va');

%   Defino la señal de entrada T_L -> primeramente supongo T_L nula
u2 = zeros(1, puntos_sim+1);
%   defino el vector de entrada (en realidad es una matriz)
u = [u1;u2];

%   las funciones de transferencia de cada salida
%[num1,den1] = ss2tf(matA,matB,matC1,matD,1); %obtengo el valor de y1(t)/u1(t)
%[num2,den2] = ss2tf(matA,matB,matC2,matD,1);


%   me interesa ahora conocer el comportamiento de iA y wr
%   suponiendo que las variables de estado son inicialmente nulas
x(1,1) = 0;
x(2,1) = 0;
x(3,1) = 0;

for ii=1:1:(puntos_sim+1)
    if ii>=(round(0.3/delta_t))
    x1(1,ii)= x(1,1);
    x2(1,ii)= x(2,1);
    x3(1,ii)= x(3,1);
    
    xp = matA*x+matB*u(:,i);
    x = x+delta_t*xp;   %la matriz X se va modificando con cada iteracion
    end
end

%   Puedo ahora graficar las variables de interes
%   Corriente iA
fig = figure(2);
fig.Name = 'Salida iA';
plot(t,x1);
title('Corriente de i_A');
xlabel('Tiempo [s]');
ylabel('Corriente [A]');
xlim([0,2]);
%   Velocidad angular wr
fig = figure(3);
fig.Name = 'Salida wr';
plot(t,x2);
title('Velocidad angular wr');
xlabel('Tiempo [s]');
ylabel('Velocidad angular [rad/s]');
xlim([0,2]);
%   Posicion tita_t
fig = figure(4);
fig.Name = 'Posicion angular tita_t';
plot(t,x3);
title('Posicion angular tita_t');
xlabel('Tiempo [s]');
ylabel('Posicion [rad]');
xlim([0,2]);
