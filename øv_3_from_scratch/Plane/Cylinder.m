function [fac,vert]=Cylinder(P1,P2,R,N, varargin)
% 
% P1 - center of the first base of cylinder
% P2 - center of the second base of cylinder
% R - radius of cylinder
% N - number of sectors of the base of cylinder

propertyNames = {'edgeColor','FaceLighting','SpecularStrength','Diffusestrength','AmbientStrength','SpecularExponent'};
propertyValues = {'none','gouraud',1,0.5,0.7,5};    
%% evaluate property specifications
for argno = 1:2:nargin-4
    switch varargin{argno}
        case 'color'
            propertyNames = {propertyNames{:},'facecolor'};
            propertyValues = {propertyValues{:},varargin{argno+1}};
        otherwise
            propertyNames = {propertyNames{:},varargin{argno}};
            propertyValues = {propertyValues{:},varargin{argno+1}};
    end
    
end 

if nargin<4
   N=100;
end

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
r=[R;R];
x=r*cos(alf);
y=r*sin(alf);
z=[0;H]*ones(1,N+1);

xyz1=E*[x(1,:);y(1,:);z(1,:)];
xyz2=E*[x(2,:);y(2,:);z(2,:)];
xe=P1(1)*ones(2,N+1)+[xyz1(1,:);xyz2(1,:)];
ye=P1(2)*ones(2,N+1)+[xyz1(2,:);xyz2(2,:)];
ze=P1(3)*ones(2,N+1)+[xyz1(3,:);xyz2(3,:)];
[fac,vert] = surf2patch(xe,ye,ze);



h{1} = patch('faces',fac,'vertices',vert);
for i = 1:2
    h{i+1} = patch('faces',[1:N],'vertices',[xe(i,:).',ye(i,:).',ze(i,:).']);
end

for propno = 1:numel(propertyNames)
    try
        for i = 1:length(h)
            set(h{i},propertyNames{propno},propertyValues{propno});
            if i > 1
                set(h{i},'edgecolor','k');
            end
        end
    catch
        disp(lasterr)
    end
end

%keyboard

% shading interp
% camlight
% grid on
% hold on
% axis equal
% 
% X1=xe(1,:); Y1=ye(1,:); Z1=ze(1,:);
% fill3(X1,Y1,Z1,Z1)
% 
% X2=xe(2,:); Y2=ye(2,:); Z2=ze(2,:);
% fill3(X2,Y2,Z2,Z2)
% 
% X=xe; Y=ye; Z=ze;

%------------------------------------------------
