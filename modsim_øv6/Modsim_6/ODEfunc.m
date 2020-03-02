function [ state_dot ] = ODEfunc( t, state, parameters )
    % state = [x; z] = [x1; x2; z1; z2]
    % parameters = [eps; alpha]
    
    x = state(1:2);
    z = state(3:4);
    
    eps = parameters(1);
    alpha = parameters(2);
    A = [x(1)^2 x(2); 0 x(2)^2] + alpha*eye(2);
    
    xdot = -[1 1; 0 1]*x - z;
    zdot = 1/eps*(0.1*x - A*z);
    
    state_dot = [xdot; zdot];    
end


