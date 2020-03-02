function [ state_dot ] = ODEfunc2( t, state, parameters)
    % state = [x; z] = [x1; x2; z1; z2]
    % parameters = [eps; alpha]
    
    x = state(1:2);
    z = state(3:4);
    
    %eps = parameters(1);
    alpha = parameters(2);
    A = [x(1)^2 x(2); 0 x(2)^2] + alpha*eye(2);
    Ax = [2*x(1)*z(1) z(2); 0 2*x(2)*z(2)];
    xdot = -[1 1; 0 1]*x - z;
    zdot = A\(xdot*0.1-Ax*xdot);
    
    state_dot = [xdot; zdot];    
end
