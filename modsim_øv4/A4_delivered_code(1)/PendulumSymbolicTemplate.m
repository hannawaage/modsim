clear all
clc

% Parameters
syms m M g L F real
% L = 1;
% Variables
syms x  theta1  theta2 real
syms dx dtheta1 dtheta2 real

% Define symbolic variable q for the generalized coordinates
% x, theta1 and theta2
q = [x; 
     theta1;
     theta2];
% Define symbolic variable dq for the derivatives 
% of the generalized coordinates
dq = [dx;
      dtheta1; 
      dtheta2];
% Write the expressions for the positions of the masses
p{1} = [x + sin(theta1);
       -L*cos(theta1)];
p{2} = p{1} + [sin(theta2); 
             -L*cos(theta2)];
      
% Kinetic energy of the cart
T = 0.5*m*dx^2;
% For loop that adds the kinetic energies of the masses
for k = 1:length(p)
    dp{k} = jacobian(p{k},q)*dq; % velocity of mass k
    T = T + 0.5*M*transpose(dp{k})*dp{k}; % add kinetic energy of mass k
end
T = simplify(T);

% Potential energy of the cart
V = 0; 
% For loop that adds the potential energies of the masses
V = V -M*g*L*cos(theta1);
V = V - M*g*L*(cos(theta1) + cos(theta2));
% for k = 1:length(p)
%     V = V + -M*g*L*cos(theta{k}); % add potential energy of mass k
% end
V = simplify(V);

% Generalized forces
Q = [-10*x-dx; 
    0;
    0];
% Q = [F(1); %-10*x - dx; 
%     0;
%     0; 
%     F(2); 
%     0; 
%     0];

% Lagrangian
Lag = T - V;

Lag_q = simplify(jacobian(Lag,q)).';
Lag_qdq = simplify(jacobian(Lag_q.',dq));
Lag_dq = simplify(jacobian(Lag,dq)).';
Lag_dqdq = simplify(jacobian(Lag_dq.',dq));

% The equations have the form W*q_dotdot = RHS, with
W = Lag_dqdq;
RHS = Q + simplify(Lag_q - Lag_qdq*dq);

state = [q;dq];
param = [m;M;L;g];

PendulumPosition = matlabFunction(p{1},p{2}, 'file','PendulumPosition','vars',{state, param});
PendulumODEMatrices = matlabFunction(W,RHS, 'file','PendulumODEMatrices','vars',{state, F, param});
