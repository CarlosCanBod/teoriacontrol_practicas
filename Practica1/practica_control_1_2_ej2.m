clearvars;
% Ejercicio 2
% multiplicar por s/s
b = 0.1;
k = 0.2;
j = 0.1;
sys1 = tf([1 0],[j b k]);


pole(sys1);
zero(sys1);

t = 0:0.05:20;

% Apartado a
subplot(2,2,1)
step(sys1,t);

% Apartado b
%impulse(sys1,t);

% Apartado c
pole(sys1);
zero(sys1);

title("J=0.1 K=0.2 B=0.1")
ylabel("Velocidad angular")

% Apartado d
j = 3;
sys2 =  tf([1 0],[j b k]);
% Aumentado M
subplot(2,2,2)
step(sys2,t)
title("J=3 K=0.2 B=0.1")
ylabel("Velocidad angular")

% Aumentando K
k = 20;
j = 0.1;
sys3 =  tf([1 0],[j b k]);

subplot(2,2,3)
step(sys3,t)
title('J=0.1 K=20 B=0.1')
ylabel("Velocidad angular")

% Aumentando b
k = 0.2;
b = 0;
sys4 =  tf([1 0],[j b k]);

subplot(2,2,4)
step(sys4,t)
title('J=0.1 K=0.2 B=0')
ylabel("Velocidad angular")

