clearvars;
Kp = 1;
Ki = 1;
Kd = 1;

s = tf('s');

m = 1;
b = 10;
k = 10;

P = 1/( m*s ^2 + b* s + k);

C = pid(Kp);
T = feedback(C*P,1);
t = 0:0.01:10;

pidTuner(P,"p")

