% Ejercicio 5.4.1
clearvars;
L = 23;
R = 3.5;
phi_0 = 0;  % Angulo sobre el que se linealiza el sistema
phi_inicial = 0;  % Angulo inicial del turtlebot
%https://automaticaddison.com/how-to-derive-the-state-space-model-for-a-mobile-robot/
A = [0 0 -sin(phi_0); 0 0 cos(phi_0); 0 0 0];
B = [(R/2)*cos(phi_0) cos(phi_0)*R/2; sin(phi_0)*R/2 sin(phi_0)*R/2; R/L -R/L];
C = [1 0 0; 0 1 0; 0 0 1]; % Para ver distancia en eje x , y e angulo
D = 0;
sys = ss(A,B,C,D);

x0 = [0;0;phi_inicial];   % Condiciones iniciales  x,y,phi
t = 0:0.05:10;
u = zeros(length(t),2);
u(t<=10,1) = 1;
u(t<=10,2) = 1;

[y , ts , x ] = lsim ( sys , u , t , x0 );
y
plot(y(:,1),y(:,2));
