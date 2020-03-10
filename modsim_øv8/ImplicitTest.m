%clear;
%close all;
%clc; 

%% Parameters
lambda = -2;
A = lambda;
syms x;
f(x) = A*x;
x0 = 1;
dfdx = jacobian(f, x)';
tf = 5; 
%delta_t = 0.2;
T =0:delta_t:tf;

x = ImplicitEulerTemplate(f, dfdx, T, x0);
[t, z] = ode45(@(t, z) A*z, [0 tf], x0);
%figure(1);
plot(T, x); grid;
hold on
%plot(t, z);
%xlabel('Time t');
ylabel('x(t)');
title('Classic Test, Implicit Euler Method');
delta_text = num2str(delta_t);
leg = 'Implicit Euler, \Delta t = ';
fullLeg = [leg, delta_text];
legendList = [legendList; fullLeg];

