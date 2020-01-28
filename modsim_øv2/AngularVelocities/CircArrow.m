function [fac,vert]=CircArrow(P1,P2,R1,R2,hand, varargin)
% 
% P1 - base of the axis arrow
% P2 - end of the axis arrow (where the circular arrow is)
% R1 - radius of the arrow
% R2 - radius of cylinder


propertyNames = {'edgeColor'};
propertyValues = {'none'};    
%% evaluate property specifications
for argno = 1:2:nargin-5
    switch varargin{argno}
        case 'color'
            propertyNames = {propertyNames{:},'facecolor'};
            propertyValues = {propertyValues{:},varargin{argno+1}};
        otherwise
            propertyNames = {propertyNames{:},varargin{argno}};
            propertyValues = {propertyValues{:},varargin{argno+1}};
    end
    
end 


Ncirc = 20;
N=20;

P1=P1(:);
P2=P2(:);
P12=P2-P1;
A=[0 0 1;1 0 0;0 1 0]';
B=[];
z1=P12/norm(P12);
if z1==A(:,1)
   B=A;
else
   x1=cross(A(:,1),z1);
   x1=x1(:)/norm(x1);
   y1=cross(z1,x1);
   y1=y1(:)/norm(y1);
   B=[z1 x1 y1];
end

E=B*A^(-1);

H=norm(P12);

alf=linspace(0,2*pi,N+1);

%% Core
X = [R1 + R2*cos(alf);
         zeros(1,N+1);
          R2*sin(alf)];

switch hand
    case 1
        beta = linspace(0,2*pi*3/4,Ncirc);
    case -1
        beta = linspace(2*pi*3/4,0,Ncirc);
end

xe = [];
ye = [];
ze = [];
for k = 1:Ncirc
 
    Rz = [cos(beta(k)) -sin(beta(k)) 0;
          sin(beta(k))  cos(beta(k)) 0;
              0             0        1];
    AllX = E*Rz*X;
    xe = [xe;AllX(1,:)+P2(1)];
    ye = [ye;AllX(2,:)+P2(2)];
    ze = [ze;AllX(3,:)+P2(3)];
end

%% Cone
X = [R1 + 2*R2*cos(alf);
         zeros(1,N+1);
          2*R2*sin(alf)];
AllX = E*Rz*X;
xe = [xe;AllX(1,:)+P2(1)];
ye = [ye;AllX(2,:)+P2(2)];
ze = [ze;AllX(3,:)+P2(3)];

X = [R1 + 0*cos(alf);
       hand*5*R2*ones(1,N+1);
          0*sin(alf)];
AllX = E*Rz*X;  
xe = [xe;AllX(1,:)+P2(1)];
ye = [ye;AllX(2,:)+P2(2)];
ze = [ze;AllX(3,:)+P2(3)];

[fac,vert] = surf2patch(xe,ye,ze);

h = patch('faces',fac,'vertices',vert);

for propno = 1:numel(propertyNames)
    try
        set(h,propertyNames{propno},propertyValues{propno});
    catch
        disp(lasterr)
    end
end
