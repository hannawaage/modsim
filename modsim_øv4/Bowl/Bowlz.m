function z = Bowlz(p1,p2,in3)
%BOWLZ
%    Z = BOWLZ(P1,P2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 6.1.
%    24-Dec-2017 15:00:48

M1_1 = in3(1);
M1_2 = in3(2);
M2_2 = in3(4);
z = p1.*(M1_1.*p1.*(1.0./2.0)+M1_2.*p2.*(1.0./2.0))+p2.*(M1_2.*p1.*(1.0./2.0)+M2_2.*p2.*(1.0./2.0));
