function [Rot,M] = Rotations2(in1)
%ROTATIONS2
%    [ROT,M] = ROTATIONS2(IN1)

%    This function was generated by the Symbolic Math Toolbox version 6.1.
%    26-Jan-2020 19:33:13

phi = in1(1,:);
psi = in1(3,:);
theta = in1(2,:);
t2 = cos(theta);
t3 = cos(phi);
t4 = sin(theta);
t5 = sin(phi);
t6 = sin(psi);
t7 = cos(psi);
t8 = t2.*t7;
Rot = reshape([t8,t6,-t4.*t7,t4.*t5-t2.*t3.*t6,t3.*t7,t2.*t5+t3.*t4.*t6,t3.*t4+t2.*t5.*t6,-t5.*t7,t2.*t3-t4.*t5.*t6],[3, 3]);
if nargout > 1
    M = reshape([t8,t6,-t4.*t7,0.0,1.0,0.0,t4,0.0,t2],[3, 3]);
end
