clear;
close all;

x0 = -1; y0 = -1; 
state0 = [x0; y0];

x = sym('x',[2 1]);
f(x) = [x(1)*x(2)-2; (x(1)^4/4)+(x(2)^3/3) - 1];
J = jacobian(f, x);
tol = 10^-14;
N = 10;
[Iterates, norms] = NewtonsMethodTemplate(f, J, state0, tol, N);

figure(1); 
semilogy(norms); grid;
title('Semilogarithmic plot of the infinity norm of the residuals, tol = 10^{-1}');
ylabel('||f(x_k)||_{\infty}');
xlabel('Iterations');