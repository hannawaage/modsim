function x = ERKTemplate(ButcherArray, f, T, x0, delta_t)
    % Returns the iterations of an ERK method
    % ButcherArray: Struct with the ERK's Butcher array
    % f: Function handle
    %    Vector field of ODE, i.e., x_dot = f(t,x)
    % T: Vector of time points, 1 x Nt
    % x0: Initial state, Nx x 1
    % x: ERK iterations, Nx x Nt
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Define variables
    % Allocate space for iterations (x) and k1,k2,...,kNstage
    % It is recommended to allocate a matrix K for all kj, i.e.
    Nx = size(x0, 1);
    Nt = size(T, 2);
    Nstage = size(ButcherArray.A, 2);
    K = zeros(Nx, Nstage);
    %delta_t = 0.4;%T(2) - T(1);
    x = zeros(Nx, Nt);
    %u = zeros(Nu, Nt);
    aMat = ButcherArray.A;
    bVec = ButcherArray.b;
    cVec = ButcherArray.c;
    %
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %x_k = x0; % initial iteration
    x(:, 1) = x0;
    % Loop over time points
    for nt=2:Nt
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Update variables
        x_k = x(:, nt-1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Loop that calculates k1,k2,...,kNstage
        K(:, 1) = f(nt, x_k);
        for nstage=2:Nstage
            leSum = 0;
            for j = 1:Nstage
                if aMat(nstage, j) ~= 0
                    leSum = leSum + aMat(nstage, j)*K(:, j);
                end
            end
            K(:, nstage) = f(nt, x_k + delta_t*leSum);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Calculate and save next iteration value x_t
        xSum = 0;
        for i = 1:Nstage 
            if bVec(i) ~= 0
                xSum = xSum + bVec(i)*K(:, i);
            end
        end
        x(:, nt) = x_k + delta_t*xSum;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end