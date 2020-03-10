clear;
close all;

x0 = 1; y0 = 3; 
state0 = [x0; y0];

x = sym('x',[2 1]);
f(x) = [x(1)-1 + (cos(x(2))*x(1)+1)*cos(x(2)); -x(1)*sin(x(1))*(cos(x(2))*x(1)+1)];
J = jacobian(f, x);
tol = 10^-5;
N = 10;
[Iterates, norms] = NewtonsMethodTemplate(f, J, state0, tol, N);

figure(1); 
semilogy(norms); grid;
title('Semilogarithmic plot of the infinity norm of the residuals, tol = 10^{-10}');
ylabel('||f(x_k)||_{\infty}');
xlabel('Iterations');