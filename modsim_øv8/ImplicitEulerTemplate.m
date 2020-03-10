function x = ImplicitEulerTemplate(f, dfdx, T, x0)
    % Returns the iterations of the implicit Euler method
    % f: Function handle
    %    Vector field of ODE, i.e., x_dot = f(t,x)
    % dfdx: Function handle
    %       Jacobian of f w.r.t. x
    % T: Vector of time points, 1 x Nt
    % x0: Initial state, Nx x 1
    % x: Implicit Euler iterations, Nx x Nt
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Nt = size(T, 2);
    Nx = size(x0, 1);
    delta_t = T(2); 
    x = NaN(Nx, Nt);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    xt = x0; % initial iteration
    x(:, 1) = x0;
    % Loop over time points
    for nt=2:Nt
        xnext = xt + delta_t*f(xt);
        g = xt + delta_t*f - xnext; %Residual function
        J = dfdx(xnext) - eye(Nx);
        X = ScalarNewtonsMethodTemplate(g, J, xt);
        X(isnan(X)) = [];
        if(isempty(X))
            xt = xnext;
        else
            xt = X(:, end);
        end
        x(:, nt) = xt;
    end
end