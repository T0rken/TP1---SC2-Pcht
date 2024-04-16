% Caso 1 - item 1
% Sistema de dos variables de estado

clc;clear all;close all;

% Valores constantes del sistema 
R = 47;     % 47 ohm
L = 1e-6;   % 1 uHy
C = 100e-9; % 100 nF


% Entrada del sistema U -> "Una entrada de tensión escalón de 12V, que cada 1ms cambia de signo"
amp = 12;   % 12 V
paso = 0.00001;  % 0.01ms - defino un paso 100 veces mas chico que el tiempo de cambio de signo
t = 0:paso:0.01999;  % defino un vector tiempo con 2000 pasos, que vaya de 0 a 20ms, con un paso de 0.01ms
u = zeros(size(t));  % creo la entrada del sistema inicialmente como un vector de ceros, con la cantidad de pasos igual a el tiempo t (2000)
for i=1:49  % relleno el vector u con valores para cada paso
    u(i) = 0;   %durante 0.5ms, la entrada vale 0V 
end
u(50) = amp;
aux = 0;
for i= 51:length(t)
    if aux < 100
        u(i) = u(i-1);
        aux = aux+1;
    elseif aux == 100
        u(i) = -u(i-1);
        aux = 0;
    end
end
% plotteo
plot(t, u);
grid on;
title('Entrada u_t,V_a')
xlabel('Tiempo [ s ]');
ylabel('Voltaje [ V ]');

% Matrices del sistema
matA = [-R/L -1/L; 1/C 0];  % Matriz A
matB = [1/L;0];   % Matriz B

% Defino el voltaje en el capacitor -> sea v_c la salida del sistema
matC_T1 = [0 1]; 
matD = [];
sist1 = ss(matA,matB,matC_T1,matD);  %genero el espacio de estados para este sistema
figure % genero una ventana de figura para el sistema
lsim(sist1,u,t); % simulo la respuesta en el tiempo del sistema (lineal) a la entrada u
% ploteo
grid on;
title('Voltaje Capacitor v_c(t)');
xlabel('Tiempo [ s ])');
ylabel('Voltaje [ V ]');

% Defino la corriente en el circuito
matC_T2 = [1 0]; 
matD = [];
sist2 = ss(matA,matB,matC_T2,matD);  %genero el espacio de estados para este sistema
figure % genero una ventana de figura para el sistema
lsim(sist2,u,t); % simulo la respuesta en el tiempo del sistema (lineal) a la entrada u
% ploteo
grid on;
title('Corriente i(t)');
xlabel('Tiempo [ s ])');
ylabel('Corriente [ i ]');
