timis = 10^(-6);
timia = 10^(-8);
a = 1.4*timis;
b = 3.1*timia;
bd = 5.6*10^(-16);
d = 2.8*timia; 
i = 2.6*timis; 
n = 1.4*timis;
r = 0.28*timis;
qi = 2.7*timis;
qz = qi; 
dq = 28*timis; 

day = 24*3600; 
tspan = linspace(0, 100*day, 1000);
options = odeset('RelTol', 1e-11, 'AbsTol', 0.001, 'InitialStep', 1);

%% Simulate with and without quarantine
H0 = (b-d)/bd;
y0_wo = [H0 0 0 0];
[t, y_wo] = ode45(@(t, y_wo) wo_quarantine(t, y_wo, a, b, d, bd, i, r, n), tspan, y0_wo, options);
y0_w = [H0 0 0 0 0];
[t, y_w] = ode45(@(t, y_w) w_quarantine(t, y_w, a, b, d, bd, i, r, n, dq, qi, qz), tspan, y0_w, options);

figure(1); 
sgtitle('Zombie apocalypse')
y_wo = y_wo';
y_w = y_w'; 
subplot(2, 3, 1);
plot(t/day, y_wo(1, :));
hold on; 
plot(t/day, y_w(1, :), '-o');
title('Healthy'); 
legend('Without Q', 'With Q');
xlabel('Time [days]')
ylabel('Population [individuals]')

subplot(2, 3, 2);
plot(t/day, y_wo(2, :));
hold on; 
plot(t/day, y_w(2, :), '-o');
title('Infected'); 
legend('Without Q', 'With Q');
xlabel('Time [days]')
ylabel('Population [individuals]')

subplot(2, 3, 4);
plot(t/day, y_wo(3, :));
hold on; 
plot(t/day, y_w(3, :), '-o');
title('Zombie'); 
legend('Without Q', 'With Q');
xlabel('Time [days]')
ylabel('Population [individuals]')

subplot(2, 3, 5);
plot(t/day, y_wo(4, :));
hold on; 
plot(t/day, y_w(4, :), '-o');
title('Dead'); 
legend('Without Q', 'With Q');
xlabel('Time [days]')
ylabel('Population [individuals]')

subplot(2, 3, 3);
plot(t/day, y_w(5, :), '-o');
title('Quarantined'); 
legend('With Q');
xlabel('Time [days]')
ylabel('Population [individuals]')


