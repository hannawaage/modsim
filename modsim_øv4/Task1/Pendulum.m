function [x_dot] = Pendulum(t, x, parameters)
   F = -5*x(1) - x(2);
   %F = 0; 
   [W, RHS] = PendulumODEMatrices(x, F, parameters);
   dq = x(4:6);
   ddq = inv(W)*(RHS);
   x_dot = [dq; ddq];
end

