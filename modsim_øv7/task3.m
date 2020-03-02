close all
clear

x0 = 2;
y0 = 0;
state0 = [x0; y0];

tf = 25;
tspan = [0 tf];

[t,x] = ode45(@(t, x) vanDerPool(t, x),tspan,state0);
X = x(:, 1);
Y = x(:, 2);
figure
sgtitle('Comparing ode45 and RK4, \Delta t = 0.17');
subplot(2,1,1)
plot(t,X)
ylabel('x(t)')
xlabel('Time [s]')
grid on
hold on
subplot(2,1,2)
plot(t,Y)
grid on
ylabel('y(t)')
xlabel('Time [s]')
hold on

%% Runge-Kutta 4 (RK4)
A = diag([0.5; 0.5; 1], -1);
b = [1/6; 1/3; 1/3; 1/6];
c = [0; 0.5; 0.5; 1];
RK4Tableau = struct('A',A,'b',b,'c',c);
delta_t = 0.13;
T = 0:delta_t:tf;
X_RK4 = ERKTemplate(RK4Tableau,@(t, x) vanDerPool(t, x),T,state0,delta_t);
X = X_RK4(1, :);
Y = X_RK4(2, :);
subplot(2,1,1)
plot(T,X);
ylabel('x(t)')
xlabel('Time [s]')
grid on
legend('Ode45', 'RK4');
subplot(2,1,2)
plot(T,Y);
grid on
ylabel('y(t)')
xlabel('Time [s]')
legend('Ode45', 'RK4');
% 
% %% Plotting timesteps
% deltats = zeros(length(t));
% deltats(1) = t(1); 
% for i = 2:length(t)
%     deltats(i) = t(i) - t(i-1);
% end
% delta_t = delta_t*ones(length(t), 1);
% figure(2); 
% grid;
% semilogy(deltats); 
% hold on; 
% semilogy(delta_t, 'linewidth', 2);
% legend('Ode45', 'RK4');
% ylim([10^(-3) 1])