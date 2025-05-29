% Teniendo en cuenta la informaci´on disponible para las caracter´ısticas
% de los motores que accio-
% nan las ruedas del Turtlebot, construye un modelo de estados para el sistema electromec´anico
% de accionamiento. Las caracter´ısticas del modelo de motor en el Turtlebot, est´an en “Kobuki
% User Guide” disponible en el anexo B.
clearvars;

La = 1.51/1000; % mH
Ra = 1.5506; % 1.5506 ohm 25 C
Kt = 10.913/1000; % Torque constant N*m/A  % Torque Constant(Kt): 10.913 mN·m/A
Kw = 1/830; %Speed constant  V*s/rad % Velocity Constant(Kv): 830 rpm/V
Jm = 0.05;
B = 0.05;

% Variables de estado [Intensidad   w    angulo_giro]
% Ia_1 = (1/La-Ra/La)*Ia -Kw/La*W
% W_1 =  Kt/Jm*Ia -B/Jm*W
% ang = W


A = [-Ra/La -Kw/La 0;Kt/Jm -B/Jm 0; 0 1 0];
B = [1/La; 0; 0];   % Dato de entrada es la tension
C = [0 0 0;0 1 0; 0 0 0]; % [Intensidad  w   angulo_giro]
D = 0;
sys = ss(A,B,C,D);

t = 0:0.05:50;
u4 = zeros(length(t),1);
u4(t>=0) = 12;
u4(t>=25) = 0;

x0 = [0;0;0];
%lsim ( sys , u4 , t , x0 );
[y , ts , x ] = lsim ( sys , u4 , t , x0 );
plot(ts,x);