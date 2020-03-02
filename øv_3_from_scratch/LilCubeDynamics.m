function [ state_dot ] = SatelliteDynamics( t, x, parameters )
    
% Måten state-vektoren funker på: 
% x =   [ r1    
%         r2
%         r3
%         R(1,1)  4
%         R(2,1)  5
%         R(3,1)  6
%         R(1,2)  7
%         R(2,2)  8
%         R(3,2)  9
%         R(1,3)  10
%         R(2,3)  11
%         R(3,3)  12
%         v1      13
%         v2      14
%         v3      15
%         omega1  16
%         omega2  17
%         omega3  18
%         ]
    r = x(1:3);
    m = 0.125;
    M = m + 0.1;
    r_x = [0 -r(3) r(2);
               r(3) 0 -r(1); 
               -r(2) r(1) 0];
    r_g = [0.25; 0.25; 0.25];       
    M_bc = (0.125*0.5^2)/6*eye(3) + 0.125*(r_x*r_x) - M/(M+m)*r_g;
    r_dot = x(13:15);
    
    omega = x(16:18);
    omega_x = [0 -omega(3) omega(2);
               omega(3) 0 -omega(1); 
               -omega(2) omega(1) 0];
    omega_dot = -inv(M_bc)*(omega_x*(M_bc*omega));
    
    R = [x(4:3:10)';
         x(5:3:11)';
         x(6:3:12)'];
    R_dot = omega_x*R;
    R_dot_vec = [R_dot(1:3, 1);
         R_dot(1:3, 2);
         R_dot(1:3, 3)];
    v_dot = -r./((sqrt(r(1)^2+r(2)^2+r(3)^2))^3);% -r.*parameters(1)*parameters(2)/((sqrt(r(1)^2+r(2)^2+r(3)^2))^3);
    
    state_dot = [r_dot;
                 R_dot_vec;
                 v_dot;
                 omega_dot];
  
end
