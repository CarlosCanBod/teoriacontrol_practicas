% Ejercicio 1.2 Ejercicios a realizar
% Ej 1
clearvars;
m = 2;
b = 0.1;
k = 0.2;
sys1 = tf(1,[m, b ,k]);

t = 0:0.25:40;

% Apartado a
subplot(2,2,1)
step(sys1,t);

% Apartado b
%impulse(sys1,10)

% Apartado c
pole(sys1);
zero(sys1);


title("M=2 K=0.1 B=0.2")
ylabel("Distancia")
% Apartado d
m = 10;
sys2 = tf(1,[m, b ,k]);

% Aumentado M
subplot(2,2,2)
step(sys2,t)
title("M=10 K=0.1 B=0.2")
ylabel("Distancia")

% Aumentando K
k = 20;
m = 2;
sys3 = tf(1,[m, b ,k]);
subplot(2,2,3)
step(sys3,t)
title("M=2 K=20 B=0.2")
ylabel("Distancia")

% Aumentando b
k = 0.2;
b = 0;
sys4 = tf(1,[m, b ,k]);

subplot(2,2,4)
step(sys4,t)
title("M=2 K=0.2 B=0")
ylabel("Distancia")



