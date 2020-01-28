function result = wo_quarantine(t, y, a, b, d, bd, i, r, n)
result = [(b - d)*y(1) - bd*y(1)^2 - i*y(1)*y(3);
    i*y(1)*y(3) - (a + d)*y(2);
    r*y(4) - n*y(1)*y(3) + a*y(2);
    d*y(1) + n*y(1)*y(3) - r*y(4) + d*y(2)
    ];