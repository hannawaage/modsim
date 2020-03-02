close
clear
eps = 10^(-6);
a = 0;
%a = 10^(-3);
param = [eps; a];

x0 = [1 1]'; z0 = x0;
state0 = [x0; z0];
A = [x0(1)^2 x0(2); 0 x0(2)^2] + a*eye(2);
z0_DAE = A\x0*0.1;
state0DAE = [x0; z0_DAE];

tspan = [0 10];
[tsim_1, xsim] = ode15s(@(t, x)odefun(t, x, param), tspan, state0);
xsim = xsim.';

param = [0; a];
[tsim_2, xsim_2] = ode15s(@(t, x_2)DAEapprox(t, x_2, param), tspan, state0DAE);
xsim_2 = xsim_2.';

figure(1);
sgtitle('Simulated trajectories, \epsilon = 10^{-3}, \alpha = 0');
subplot(2, 2, 1);
plot(tsim_1, xsim(1, :)); 
hold on
plot(tsim_2, xsim_2(1, :));
legend('ODE solved', 'DAE approximated');
title('x_1');
ylabel('x_1(t)');
xlabel('time(s)');

subplot(2, 2, 2);
plot(tsim_1, xsim(2, :)); 
hold on
plot(tsim_2, xsim_2(2, :));
legend('ODE solved', 'DAE approximated');
title('x_2');
ylabel('x_2(t)');
xlabel('time(s)');

subplot(2, 2, 3);
plot(tsim_1, xsim(3, :)); 
hold on
plot(tsim_2, xsim_2(3, :));
legend('ODE solved', 'DAE approximated');
title('z_1');
ylabel('z_1(t)');
xlabel('time(s)');

subplot(2, 2, 4);
plot(tsim_1, xsim(4, :)); 
hold on
plot(tsim_2, xsim_2(4, :));
legend('ODE solved', 'DAE approximated');
title('z_2');
ylabel('z_2(t)');
xlabel('time(s)');


