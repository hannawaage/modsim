 function [ state_dot ] = topspinnerdynamics( t, x, parameters )
    M_bc = 1/4*eye(3);
    M_bc(3,3) = 2;
% Måten state-vektoren funker på: 
% x =   [ R(1,1)   1
%         R(2,1)  2
%         R(3,1)  3
%         R(1,2)  4
%         R(2,2)  5
%         R(3,2)  6
%         R(1,3)  7
%         R(2,3)  8
%         R(3,3)  9
%         omega1  10
%         omega2  11
%         omega3  12
%         ]
    g = parameters(1);
    L = parameters(2);
    m = parameters(3);
    
    omega = x(10:12);
    omega_x = [0 -omega(3) omega(2);
               omega(3) 0 -omega(1); 
               -omega(2) omega(1) 0];
    
    
    R = [x(1:3:7)';
         x(2:3:8)';
         x(3:3:9)'];
    r_cross_F = - L*[0;0;1]'*m*g*R.'*[0;0;1];
     
    omega_dot = -inv(M_bc)*(omega_x*(M_bc*omega + r_cross_F));

    R_dot = omega_x*R;
    R_dot_vec = [R_dot(1:3, 1);
         R_dot(1:3, 2);
         R_dot(1:3, 3)];
    
    state_dot = [ R_dot_vec;
                 omega_dot];
  
end
