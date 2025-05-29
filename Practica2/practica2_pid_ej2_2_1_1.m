% Ejercicio 2.2.1.1
clearvars;

Kp = 500;
Ki = 380;
Kd = 62;

s = tf("s");
muestreo = 0.005;
t = 0:muestreo:10;


m = 1;
b = 10;
k = 10;

P = 1/( m*s ^2 + b* s + k);

% Apartado 1
step(P,t)
ylabel("Distancia")
