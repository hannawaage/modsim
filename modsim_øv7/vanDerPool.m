function x_dot = vanDerPool(t, x)
    u = 5; nx = 1; ny = 1;
    x_t = x(1:nx);
    y_t = x((nx+1):(nx+ny));
    dx = y_t;
    dy = u*(1-x_t^2)*y_t - x_t;
    x_dot = [dx; dy];
end

