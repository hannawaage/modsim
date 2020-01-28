function [ state_dot ] = Kinematics( t, state, p )
    omega_c = [0 -p(3) p(2);
               p(3) 0 -p(1);
               -p(2) p(1) 0];
    dR = reshape(state, 3, 3)*omega_c;
    state_dot = reshape(dR, 9, 1);
end
