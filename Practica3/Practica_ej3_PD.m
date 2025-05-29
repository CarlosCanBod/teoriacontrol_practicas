clearvars;
% Ejercicio 3 compensacion PID
den = [1 10 27 18];
F = tf(15,den);

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
wn = 3/(factor_amort*ts);
polo_objetivo = -factor_amort*wn + 1i*wn*sqrt(1-(factor_amort*factor_amort))
polos_tf = pole(F);
y1 = 0;
s1_x = real(polo_objetivo);
s1_y = imag(polo_objetivo);

phi1 =  99.68; %180 - atand(abs(s1_y-y1)/abs(s1_x-x1));
phi2 =  62.89; %180 -atand(abs(s1_y-y1)/abs(s1_x-x2));
phi3 =  33.07; %180 -atand(abs(s1_y-y1)/abs(s1_x-x3));

phic =  -360 + phi1 + phi2 + phi3 

zc_obj = -s1_x + (s1_y/tand(phic))


% Ejercicio 3.1.1.3.
k= 0.325;
D_obj = tf(k*[1 zc_obj],[0 1]);

P = feedback(D_obj*F,1);
subplot(1, 2, 2);
step(P)
title("PD");
grid on;

subplot(1, 2, 1); 
rlocusplot(P)
title('Lugar de raices del PD');
grid on;