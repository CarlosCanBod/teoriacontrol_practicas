% Ejercicio 2.2.1.
clearvars;

Kp = 500;
Ki = 380;
Kd = 62;

s = tf('s');
muestreo = 0.005;
t = 0:muestreo:2;


m = 1;
b = 10;
k = 10;

P = 1/( m*s ^2 + b* s + k);
% A partir de aqui no lazo abierto creo
%Para apartado 3
% kp = 500, KI = 380, kd = 62

% Cosa ziegler apartado 4

valores_continuo = step(P,t);
gradiente = gradient(valores_continuo,muestreo);

%Buscar pendiente maxima
% Y el tiempo donde esta
pend_max = gradiente(1);
pos_max = 0;

for n = 1:length(gradiente)
    if pend_max < gradiente(n)
        pend_max = gradiente(n);
        pos_max = n;
    end
end
tiempo_pend_max = pos_max*muestreo;


% Cosas de recta para buscar cuando vale 0
c = valores_continuo(pos_max);

L = (-c/pend_max)+tiempo_pend_max;


% Funcion lazo abierto

subplot(2,2,1)
%%step(P,t)
%%title('Lazo abierto')

% Pid Manual
C0 = pid(Kp,Ki,Kd) %#ok<NOPTS>
T0 = feedback(C0*P,1);
step(T0,t)
title('PID manual')
ylabel("Distancia")

%P

Kp_ziegler = 1/(pend_max*L);
C1 = pid(Kp_ziegler);
T1 = feedback(C1*P,1);

subplot(2,2,2)
step(T1,t)
title('P')
ylabel("Distancia")

%PI

Kp_zieglerpi = 0.9/(pend_max*L);
Ti_ziegler = 3*L;
Ki_ziegler = Kp_zieglerpi/Ti_ziegler;

C2 = pid(Kp_zieglerpi,Ki_ziegler);
T2 = feedback(C2*P,1);
subplot(2,2,3)
step(T2,t)
title('PI')
ylabel("Distancia")

% PID


Kp_zieglerpid = 1.2/(pend_max*L);
Ti_ziegler2 = 2*L;
Ki_ziegler2 = Kp_zieglerpid/Ti_ziegler2;

Td_ziegler = 0.5*L;
Kd_ziegler = Kp_ziegler*Td_ziegler;

C3 = pid(Kp_zieglerpid,Ki_ziegler2,Kd_ziegler);
T3 = feedback(C3*P,1);
subplot(2,2,4)
step(T3,t)
title('PID')
ylabel("Distancia")
