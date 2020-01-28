function [ state_dot ] = Kinematics( t, state, parameters )
    [~, M] = Rotations(state);
    state_dot = inv(M)*parameters;
end
