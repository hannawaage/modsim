function x_dot = odefun(t, x, param)
    % x = [x; z]
    B = -[1 1; 
      0 1];
    eps = param(1);
    a = param(2);
    x_t = x(1:2); 
    A = [x_t(1)^2 x_t(2);
         0 x_t(2)^2] + a*eye(2);
    z_t = x(3:4);
    dz = (1/eps)*(0.1*x_t - A*z_t);
    dx = B*x_t - z_t;
    x_dot = [dx; dz];
end

