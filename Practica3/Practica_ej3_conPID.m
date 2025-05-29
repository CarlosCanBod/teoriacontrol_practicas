clearvars;
% Ejercicio 3 compensacion PID
den = [1 10 27 18];
num = [15]; %#ok<NBRAK2>
F = tf(num,den);

%D = tf(k*[1 5],[0 1]);
% P es la funcion con retroalimentacion y PID
%P = feedback(D*F,1);

figure;

%subplot(1, 2, 1); 
%rlocusplot(F)
%title('F');
%grid on;


OS = 0.2; % Entre 0 y 1. 0.2 es 20 por ciento
factor_amort = -(log(OS))/(sqrt(pi*pi+log(OS)*log(OS)));


ts = 2;
wn = 4/(factor_amort*ts); % Con 3/(factor_amort*ts); da diferente
polo_objetivo = -factor_amort*wn + 1i*wn*sqrt(1-(factor_amort*factor_amort))
polos_tf = pole(F);
y1 = 0;
x1 = polos_tf(1);
x2 = polos_tf(2);
x3 = polos_tf(3);
s1_x = real(polo_objetivo);
s1_y = imag(polo_objetivo);

% Angulo entre polo -6 y objetivo -1.5 +2.928 es 33.05
% Angulo entre polo -3 y objetivo -1.5 +2.928 es 62.87
% Angulo entre polo -1 y objetivo -1.5 +2.928 es 99.69
% En geogebra con Con 3/(factor_amort*ts)


phi1 =  atand((s1_y-y1)/(s1_x-x1)); %99.68; %180 - atand(abs(s1_y-y1)/abs(s1_x-x1));
phi2 =  atand((s1_y-y1)/(s1_x-x2)); %62.89; %180 -atand(abs(s1_y-y1)/abs(s1_x-x2));
phi3 =  atand((s1_y-y1)/(s1_x-x3)); %33.07; %180 -atand(abs(s1_y-y1)/abs(s1_x-x3));

phic = phi1 + phi2 + phi3 

zc_obj = -s1_x + (s1_y/tand(phic))

% Añadiendo PI
% D(s) = K(s+zc)
% D_obj = tf(k*[1 zc_obj],[0 1]);

% Kp +Ki/s + Kd/s
% (kd*s**2+kp*s + ki)/s

%k= 0.325;   % wn = 3/(factor_amort*ts); 
k= 1.08;   % wn = 4/(factor_amort*ts); 


%k =
%real((polo_objetivo+polos_tf(1))*(polo_objetivo+polos_tf(2))*(polo_objetivo+polos_tf(3))/15)
%No funciona

ki_cero = 0.68;
I_obj =tf([1 ki_cero],[1 0]);
D_obj = tf(k*[1 zc_obj],[0 1]);

P = feedback(D_obj*F,1);    % PD
P2 = feedback(I_obj*D_obj*F,1);% PID
P3 = I_obj*D_obj*F; % En lazo abierto


subplot(1, 2, 1); 
%rlocusplot(P3)
step(P)
title('PD');
grid on;

subplot(1, 2, 2);
step(P2)
title('PID');
grid on;

% Para los valores de las constantes del PID
c = pid(7.72,4.406,1.08)
I_obj*D_obj