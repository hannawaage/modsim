clear all
clc

% Parameters
syms m1 m2 L g real
% Force
u = sym('u',[3,1]);

% Positions of point masses
pm1 = sym('pm1',[3,1]);
pm2 = sym('pm2',[3,1]);
dpm1 = sym('dpm1',[3,1]);
dpm2 = sym('dpm2',[3,1]);
ddpm1 = sym('d2pm1',[3,1]);
ddpm2 = sym('d2pm2',[3,1]);
% Generalized coordinates
q  = [pm1;pm2];
dq = [dpm1;dpm2];
ddq = [ddpm1;ddpm2];
% Algebraic variable
z = sym('z');

% Generalized forces
Q = [u; 
     0; 
     0;
     0];
% Kinetic energy (function of q and dq)
T = 0.5*m1*norm(dpm1)^2 + 0.5*m2*norm(dpm2)^2;
% Potential energy
V = m1*g*pm1(3) + m2*g*pm2(3);
% Constraint
dpm  = pm1 - pm2; % difference of positions
C = 0.5*(dpm.'*dpm - L^2);
% Lagrangian (function of q and dq)
Lag = T - V - z'*C;

% Derivatives of constrained Lagrangian
Lag_q = simplify(jacobian(Lag,q)).';
Lag_qdq = simplify(jacobian(Lag_q.',dq));
Lag_dq = simplify(jacobian(Lag,dq)).';
Lag_dqdq = simplify(jacobian(Lag_dq.',dq)); % W
C_q = simplify(jacobian(C,q)).';

% Matrices for problem 1
M = Lag_dqdq;

W_dq_q_timesdq = simplify(jacobian(Lag_dq, dq))*dq;
V_q_t = simplify(jacobian(V,q)).';
b = Q - W_dq_q_timesdq - V_q_t - C_q*z;

% Matrices for problem 2
Mimplicit = [Lag_dqdq C_q;
             C_q.' 0];
C_q_timesdq = C_q.'*dq;
c_2 = simplify(jacobian(C_q_timesdq.',q))*dq;
c = [Q - W_dq_q_timesdq - V_q_t;
     -c_2];
Mexplicit = simplify(inv(Mimplicit));
rhs = simplify(Mexplicit*c);
