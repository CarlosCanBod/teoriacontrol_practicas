% Ejercicio 5.2.1.
A = [[0 1 0];[0 0 1];[-50 -20 -10]];
B = [0;0;1];
C = [30 0 0];
D = 0;

sys = ss(A,B,C,D);
contr = ctrb(sys);
rank(contr); 
% La ss es de orden 3, y como la matriz de controlabilidad
% es de rango 3, el sistema es controlable
obser = obsv(sys);

% Obtener las matrices controlabilidad y obser con operaciones
% matriciales
contr_2 = [B,A*B,A*A*B];
obser_2 = [C;C*A;C*A*A];
rank(obser_2);

% Como es un sistema de orden 3, y los rangos de las matrices de
% controlabilidad y observabilidad es 3, el sistema es observable
% y controlable