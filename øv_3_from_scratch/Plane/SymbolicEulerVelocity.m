clear all
close all
clc

syms phi psi theta real
syms dphi dpsi dtheta real

A = [phi;theta;psi];
dA = [dphi;dtheta;dpsi];


R{1} = [1       0        0;
        0 cos(A(1)) -sin(A(1));
        0 sin(A(1))  cos(A(1))];

R{2} = [cos(A(2))  0  sin(A(2));
           0       1      0;
        -sin(A(2)) 0  cos(A(2))];

R{3} = [cos(A(3))  -sin(A(3))     0;
        sin(A(3))   cos(A(3))     0;
            0           0         1];
        
Rot = simplify(R{3}*R{2}*R{1}); %PlaneDemo1
%Rot = simplify(R{1}*R{2}*R{3});
%Rot = simplify(R{1}*R{3}*R{2});

dRot = 0;
for k = 1:3
    simplify(diff(Rot,A(k))*Rot.')
    dRot = dRot + diff(Rot,A(k))*dA(k);
end

OmegaX = simple(dRot*Rot.');

Omega = [OmegaX(3,2);
         OmegaX(1,3);
         OmegaX(2,1)];
     
     
%omega_in_a = M*dA     
M = jacobian(Omega,dA)     
simplify(det(M))     

