clear
close all
clc
%%Parameters
lambda = -2;
A = lambda;
% Mass-damper-spring vector field
fClassicTest = @(t,x) A*x;

%% Explicit Euler (RK1)
A = 0;
b = 1;
c = 0;
EulerTableau = struct('A',A,'b',b,'c',c);
%% Runge-Kutta 2 (RK2)
A = diag(0.5, -1);
b = [0; 1];
c = [0; 0.5];
RK2Tableau = struct('A',A,'b',b,'c',c);
%% Runge-Kutta 4 (RK4)
A = diag([0.5; 0.5; 1], -1);
b = [1/6; 1/3; 1/3; 1/6];
c = [0; 0.5; 0.5; 1];
RK4Tableau = struct('A',A,'b',b,'c',c);

%% Simulate & Plot
delta_test = [0.1; 0.5; 0.8; 1.4];
timespan = [0 2];
x0 = 1;
for i = 1:4
    delta_t = delta_test(i);
    T = 0:delta_t:2;
    %% Simulate
    X_RK1 = ERKTemplate(EulerTableau,fClassicTest,T,x0, delta_t);
    X_RK2 = ERKTemplate(RK2Tableau,fClassicTest,T,x0, delta_t);
    X_RK4 = ERKTemplate(RK4Tableau,fClassicTest,T,x0, delta_t);

    subplot(3,1,1)
    plot(T,X_RK1, 'linewidth', 2);
    hold on;
    ylabel('x(t)')
    xlabel('Time [s]')
    title('Explicit Euler (RK1)');
    grid on
    subplot(3,1,2)
    plot(T,X_RK2, 'linewidth', 2);
    hold on;
    ylabel('x(t)')
    xlabel('Time [s]')
    title('Runge-Kutta 2 (RK2)');
    grid on
    subplot(3,1,3)
    plot(T,X_RK4, 'linewidth', 2);
    hold on;
    ylabel('x(t)')
    xlabel('Time [s]')
    title('Runge-Kutta 4 (RK4)');
    grid on
end

[t, correct] = ode45(fClassicTest, timespan, x0);
subplot(3, 1, 1);
plot(t, correct, 'o', 'linewidth', 0.1);
legend('\Delta t = 0.1','\Delta t = 0.5', '\Delta t = 0.8', '\Delta t = 1',  'Solution (ode45)');
subplot(3, 1, 2);
plot(t, correct, 'o', 'linewidth', 0.1);
legend('\Delta t = 0.1','\Delta t = 0.5', '\Delta t = 0.8', '\Delta t = 1','Solution (ode45)');
subplot(3, 1, 3);
plot(t, correct, 'o', 'linewidth', 0.1);
legend('\Delta t = 0.1','\Delta t = 0.5', '\Delta t = 0.8', '\Delta t = 1','Solution (ode45)');

