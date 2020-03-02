function x_dot = DAEapprox(t, x, param)
    % x = [x; z]
    a = param(2);
    x_t = x(1:2);
    z_t = x(3:4); 
    H = [1 1; 
         0 1]; 
    dx = -H*x_t - z_t; 
    A = [x_t(1)^2 x_t(2); 
         0 x_t(2)^2] + a*eye(2);
    dA = [2*x_t(1)*dx(1) dx(2); 
           0 2*x_t(2)*dx(2)]; 
    dz = A\(0.1*dx - dA*z_t);
    x_dot = [dx; dz];
    
end

