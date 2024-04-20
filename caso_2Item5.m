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

%
%   Para el problema en cuestion se sabe que:
%       u1(t) = vin(t)
%       u2(t) = TL(t)
%       y1(t) = wr(t)
%       y2(t) = iA(t)
%
%   Tendremos entonces cuatro funciones de transferencia en este sistema,
%   puesto que se tiene dos salidas para cada entrada, las cuales son dos
%

%   Se desarrolla las T. de Laplace para el sistema de ecuaciones que
%   modela este sistema

%   Primero se obtiene las funciones de transferencia para la entrada Vin
%   (se pasiva la entrada TL)

%   funcion de transferencia iA / Vin
syms s iA Ra Laa Km wr Vin Ki J Bm tita_r;
%TL = 0;
ec1 = ( s*iA ) == ( (-Ra/Laa)*iA - (Km/Laa)*wr + (1/Laa)*Vin );
ec2 = ( s*wr ) == ( (Ki/J)*iA - (Bm/J)*wr );    %sin TL
ec3 = ( s*tita_r ) == ( wr ); 

wr = solve(ec2,wr);     %   despejo wr en funcion de iA
ec1 = eval(ec1);        %   reemplazo wr en la ecuacion 1
iA = solve(ec1,iA);      %   de la ecuacion 1 obtengo iA
iA_div_Vin = collect(iA / Vin);    % iA / Vin

%   funcion de transferencia wr / Vin
syms s iA Ra Laa Km wr Vin Ki J Bm tita_r;
%TL = 0;
ec1 = ( s*iA ) == ( (-Ra/Laa)*iA - (Km/Laa)*wr + (1/Laa)*Vin );
ec2 = ( s*wr ) == ( (Ki/J)*iA - (Bm/J)*wr );    %sin TL
ec3 = ( s*tita_r ) == ( wr ); 

iA = solve(ec2,iA);     %   despejo iA en funcion de wr
ec1 = eval(ec1);        %   reemplazo wr en la ecuacion 1
wr = solve(ec1,wr);      %   de la ecuacion 1 obtengo wr
wr_div_Vin = collect(wr / Vin); 

%   funcion de transferencia tita_r / Vin
syms s iA Ra Laa Km wr Vin Ki J Bm tita_r;
%TL = 0;
ec1 = ( s*iA ) == ( (-Ra/Laa)*iA - (Km/Laa)*wr + (1/Laa)*Vin );
ec2 = ( s*wr ) == ( (Ki/J)*iA - (Bm/J)*wr );    %sin TL
ec3 = ( s*tita_r ) == ( wr ); 

iA = solve(ec2,iA);
ec1 = eval(ec1);
wr = solve(ec3,wr);
ec1 = eval(ec1);
tita_r = solve(ec1,tita_r);
titaR_div_Vin = collect(tita_r / Vin);

%   Luego se obtiene las funciones de transferencia para TL como entrada y
%   pasivando Vin

%   funcion de transferencia iA / TL
syms s iA Ra Laa Km wr TL Ki J Bm tita_r;
%Vin = 0;
ec1 = ( s*iA ) == ( (-Ra/Laa)*iA - (Km/Laa)*wr ); %sin Vin
ec2 = ( s*wr ) == ( (Ki/J)*iA - (Bm/J)*wr ) - (1/J)*TL;    
ec3 = ( s*tita_r ) == ( wr ); 

wr = solve(ec1,wr);     %   despejo wr en funcion de iA
ec2 = eval(ec2);        %   reemplazo wr en la ecuacion 2
iA = solve(ec2,iA);      %   de la ecuacion 1 obtengo iA
iA_div_TL = collect(iA / TL);    % iA / TL

%   funcion de transferencia wr / TL
syms s iA Ra Laa Km wr TL Ki J Bm tita_r;
%Vin = 0;
ec1 = ( s*iA ) == ( (-Ra/Laa)*iA - (Km/Laa)*wr ); %sin Vin
ec2 = ( s*wr ) == ( (Ki/J)*iA - (Bm/J)*wr ) - (1/J)*TL;    
ec3 = ( s*tita_r ) == ( wr ); 

iA = solve(ec1,iA);     %   despejo iA en funcion de wr
ec2 = eval(ec2);        %   reemplazo wr en la ecuacion 1
wr = solve(ec2,wr);      %   de la ecuacion 1 obtengo wr
wr_div_TL = collect(wr / TL); 

%   funcion de transferencia tita_r / TL
syms s iA Ra Laa Km wr TL Ki J Bm tita_r;
%Vin = 0;
ec1 = ( s*iA ) == ( (-Ra/Laa)*iA - (Km/Laa)*wr ); %sin Vin
ec2 = ( s*wr ) == ( (Ki/J)*iA - (Bm/J)*wr ) - (1/J)*TL;    
ec3 = ( s*tita_r ) == ( wr ); 

iA = solve(ec1,iA);
ec2 = eval(ec2);
wr = solve(ec3,wr);
ec2 = eval(ec2);
tita_r = solve(ec2,tita_r);
titaR_div_TL = collect(tita_r / TL);
