clearvars;

% Ejercicio 5.1.3.
A = [[0 1 0];[0 0 1];[-50 -20 -10]];
B = [0;0;1];
C = [30 0 0];
D = 0;

sys = ss(A,B,C,D);

% Apartado 2
%step(sys) 

% Apartado 3
x0 = [0;5;-1];
u0 = [0;0;0];
%initial ( sys , x0 );
[y , t ,x ] = initial ( sys , x0 );
plot(t,x);

% Apartado 4
t = 0:0.05:10;
u4 = zeros(length(t),1);
u4(t>=0) = 1;
%lsim ( sys , u4 , t , x0 );
%[y , ts , x ] = lsim ( sys , u4 , t , x0 );
%plot(ts,y,ts,u4);

% Apartado 5
u5 = zeros(length(t),1);
u5 = max(0,min(t,2.5)*2);
x0_5 = [0;0;0];
t3_a = t >= 7.5;
t3 = t(t3_a);
u5(t>=7.5) = linspace(5, 0, length(t3));
[y , ts , x ] = lsim ( sys , u5 , t , x0_5 );
plot(ts,x);

% Apartado 6
%systf = tf(sys);
%step(sys) 
%step(systf)