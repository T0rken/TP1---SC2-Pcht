clear all; clc; close all

%   Genero una matriz con los datos proporcionados
Data = readmatrix('G:\My Drive\a Ingenieria\2024 Primer Semestre\Sistemas de Control 2\Entregas\Pucheta\Act N1 - fecha max 23_04\Consignas\Curvas_Medidas_RLC_2024.xls');
DataBis = readmatrix('Curvas_Medidas_RLC_2024.xls');

%   Genero las graficas correspondientes a cada dato en funcion del tiempo
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
%   Para el problema en cuestion se sabe que:
%       u(t) = v_e(t)
%       y(t) = v_c(t)
%
%   Desarrollando por Transf de Laplace, se puede ver que la funcion de
%   transferencia del sistema sera:
%       G(s) = 1 / (L*C*(s^2) + C*R*s + 1)
%
%   Se utilizara el metodo de Chen para hallar los valores de la funcion de
%   transferencia del sistema, de manera que se propone que:
%       G(s) = (K * (T_3*s + 1) / ((T_1*s + 1) * (T_2*s + 1))
%

%   Defino el tiempo t1
t1 = 0.0131;   
t = 0.003;  %se tomara un intervalo de t=3[ms] entre los puntos

%   obtengo los 3 puntos de la salida
t_t1 = Data(131,1); %la muestra 102 de la columna 1 (Tiempo [s])
y_t1 = Data(131,3); %la muestra 102 de la columna 3 (V_cap [V])

t_2t1 = Data(161,1);
y_2t1 = Data(161,3);

t_3t1 = Data(191,1);
y_3t1 = Data(191,3);

%   Viendo los valores de las graficas, puedo identificar que la ganancia
%   estatica del sistema es unitaria
K = 1;

%   Puedo hallar asi los valores k1, k2 y k3
k1 = (y_t1 / K) - 1;
k2 = (y_2t1 / K) - 1;
k3 = (y_3t1 / K) - 1;

%   Con ello obtengo los valores b,alfa_1 y alfa_2
b = 4*(k1^3)*k3 - 3*(k1^2)*(k2^2) - 4*(k2^3) + (k2^2) + 6*k1*k2*k3;
alfa1 = ( k1*k2 + k3 - sqrt(b) ) / ( 2*((k1^2)+k2) );
alfa2 = ( k1*k2 + k3 + sqrt(b) ) / ( 2*((k1^2)+k2) );
beta = ( 2*(k1^3) + 3*k1*k2 + k3 - sqrt(b) ) / ( sqrt(b) );

%   Puedo luego hallar los valores estimados de las constantes de tiempo
%   T1, T2 y T3
T1_est = -( t_t1 ) / ( log(alfa1) );
T2_est = -( t_t1 ) / ( log(alfa2) );
T3_est = beta*(T1_est-T2_est)+T1_est;

%   Ya tendre entonces los valores necesarios para obtener la Transf de la
%   funcion de transferencia como la propone Chen
s = tf('s');
G = ( K * (T3_est*s + 1) ) / ( (T1_est*s + 1) * (T2_est*s + 1) );
%   Ademas, desprecio el cero de la propuesta, puesto que la FT analizada
%   no lo tiene
G = ( K * 1 ) / ( (T1_est*s + 1) * (T2_est*s + 1) );
[numG,denG]=tfdata(G,'v');    %obtengo el numerador y el denominador de la FT en forma de vectores

