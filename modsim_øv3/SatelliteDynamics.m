function [ state_dot ] = SatelliteDynamics( t, x, parameters )
    x = [x(1:6:end)';
         x(2:4) x(8:10) x(14:16);
         x(5:6:end)';
         x(6:6:end)';
        ];
    M_bc = (0.125*0.5^2)/6*eye(3);
    r = x(1, :)';
    r_dot = x(5, :)'; 
    omega = x(6, :)';
    omega_x = [0 -omega(3) omega(2);
               omega(3) 0 -omega(1); 
               -omega(2) omega(1) 0];
    R = x(2:4, :);
    R_dot = omega_x*R;
    v_dot = -r.*parameters(1)*parameters(2)/((sqrt(r(1)^2+r(2)^2+r(3)^2))^3);
    omega_dot = -inv(M_bc)*(omega_x*(M_bc*omega));
    state_dot = [r_dot(1);
                 R_dot(1:3, 1);
                 v_dot(1);
                 omega_dot(1);
                 r_dot(2);
                 R_dot(1:3, 2);
                 v_dot(2);
                 omega_dot(2);
                 r_dot(3);
                 R_dot(1:3, 3);
                 v_dot(3);
                 omega_dot(3);
                 ];

end
