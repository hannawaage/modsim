clear;
close all;

x0 = 1.0027; y0 = 1.0027;
state0 = [x0; y0];

x = sym('x',[2 1]);
g(x) = 100*(x(2) - x(1))^2 + (x(1)-1)^4;
f(x) = jacobian(g, x).';

J = jacobian(f, x);
H = hessian(g, x);
tol = 10^-10;
N = 10;
[Iterates, norms] = NewtonsMethodTemplate(f, J, state0, tol, N);

figure(1); 
semilogy(norms); grid;
title('Semilogarithmic plot of the infinity norm of the residuals, tol = 10^{-10}');
ylabel('||f(x_k)||_{\infty}');
xlabel('Iterations');