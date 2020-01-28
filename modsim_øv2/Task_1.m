%% R1)
R = sym('R', [3,3]);
R(1, 2) = 1;
R(2, 1) = 1;

R(1,1) = 0;
R(3,1) = 0;
R(2, 2) = 0;
R(3, 2) = 0;

RT = transpose(R);
RI = inv(R);

eqns = [RT*R == eye(3), det(RT) == 1];

S = solve(eqns);
solR1 = [S.R1_3, S.R2_3, S.R3_3];
solR1

%% R2)
R = sym('R', [3,3]);
R(1, 1) = 5/13;
R(3, 1) = 12/13;

R(2,1) = 0;
R(1,2) = 0;
R(3, 2) = 0;

RT = transpose(R);
RI = inv(R);

eqns = [RT*R == eye(3), det(RT) == 1];

S = solve(eqns);
solR2 = [S.R1_3, S.R2_3, S.R3_3];
solR2