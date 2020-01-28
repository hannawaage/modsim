function result = w_quarantine(t, y, a,  b, d, bd, i, r, n, dq, qi, qz)
result = [(b - d)*y(1) - bd*y(1)^2 - i*y(1)*y(3);
    i*y(1)*y(3) - (a + d  + qi)*y(2);
    r*y(4) - n*y(1)*y(3) + a*y(2) - qz*y(3);
    d*y(1) + n*y(1)*y(3) - r*y(4) + d*y(2) + dq*y(5);
    qi*y(2) + qz*y(3) - dq*y(5)
    ];