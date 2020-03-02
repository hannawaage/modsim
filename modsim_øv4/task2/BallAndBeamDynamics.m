function x_dot = BallAndBeamDynamics(t, x, parameters)
   To = 200*(x(1) - x(2)) + 70*(x(3) - x(4)) + 15;
   [W, RHS] = BallAndBeamODEMatrices(x, To, parameters);
   dq = x(3:4);
   ddq = inv(W)*(RHS);
   x_dot = [dq; ddq];
end

