clear;
close all;
clc;

x0 = 3;

syms x;
f(x) = (x - 1)*(x - 2)*(x - 3) + 1 - (x^3 - 6*x^2 + 11*x - 5);
J = jacobian(f, x);
tol = 10^-5;
N = 10;
[Iterates, norms] = ScalarNewtonsMethodTemplate(f, J, x0, tol, N);

figure(1); 
semilogy(norms); grid;
title('Semilogarithmic plot of the infinity norm of the residuals, tol = 10^{-1}');
ylabel('||f(x_k)||_{\infty}');
xlabel('Iterations');