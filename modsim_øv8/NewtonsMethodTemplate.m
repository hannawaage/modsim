function [X, fknorms] = NewtonsMethodTemplate(f, J, x0, tol, N)
    if nargin < 5
        N = 100;
    end
    if nargin < 4
        tol = 1e-6;
    end
    Nx = size(x0, 1);
    X = NaN(Nx, N);
    fknorms = NaN(1, N);
    
    xn = x0; % initial estimate
    n = 1; % iteration number
    fn = f(xn(1), xn(2)); % save calculation    
    y = norm(fn,Inf);
    iterate =  y > tol;
    fknorms(1) = y;
    while iterate
        X(:, n) = xn;
        J_current = J(xn(1), xn(2));
        delta_x = -J_current\fn;
        xn = xn + delta_x;
        fn = f(xn(1), xn(2)); 
        y = norm(fn,Inf);
        iterate =  y > tol && n <= N;
        n = n + 1;
        fknorms(n) = y;
    end
end