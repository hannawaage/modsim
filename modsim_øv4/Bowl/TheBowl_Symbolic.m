clear all
clc

syms m g z real

q  = sym('p',[3,1]);
dq = sym('dp',[3,1]);

T = 0.5*m*dq.'*dq;
V = m*g*[0 0 1]*q;

M = sym('M',[2,2]);
M(2,1) = M(1,2); %Make M symmetric

C = q(3) - 0.5*q(1:2).'*M*q(1:2); %Parabolic constraint

z = 0.5*q(1:2).'*M*q(1:2); %Constraint in explicit form, for plotting purposes

Lag = T - V - z.'*C;

W     = simplify(jacobian(jacobian(Lag,dq),dq));
Lag_q = jacobian(Lag,q).';
V_q   = jacobian(V,q).';

gradC = simplify(jacobian(C,q).');
dC    = gradC.'*dq;

Nc = length(C);

Mat = [W,               gradC;
       gradC.',  zeros(Nc,Nc) ];
RHS = [-V_q; -jacobian(dC,q)*dq];

state = [q;dq];
param = [m; g];

syms t real %supporting variable
matlabFunction(Mat,RHS, 'file','BowlFile','vars',{t,state,param,M});
matlabFunction(C,dC, 'file','BowlCC','vars',{state,param,M});

matlabFunction(gradC, 'file','BowlgraC','vars',{q,M});

matlabFunction(z, 'file','Bowlz','vars',{q(1),q(2),M});





