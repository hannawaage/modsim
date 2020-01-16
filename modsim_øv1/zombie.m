timis = 10^(-6);
timia = 10^(-8);
a = 1.4*timis;
b = 3.1*timia;
bd = 5.6*10^(16);
d = 2.8*timia; 
i = 2.6*timis; 
n = 1.4*timis;
r = 0.28*timis;
qi = 2.7*timis;
qz = qi; 
dq = 28*timis; 

H0 = (b-d)/bd;

%% Without quarantine
[th, H] = ode45(@(t, H) h(b, bd, d, i, H,Z), [0 20], H0);

%% With quarantine
