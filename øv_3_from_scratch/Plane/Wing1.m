function [facPart,vertPart]=Wing1(P,L,Thickness,Chord,R1,R2,NACAName,varargin)
% 
% P1 - center of the first base of cylinder
% P2 - center of the second base of cylinder
% R - radius of cylinder
% N - number of sectors of the base of cylinder

propertyNames = {'edgeColor'};
propertyValues = {'none'};    
%% evaluate property specifications
for argno = 1:2:nargin-7
    switch varargin{argno}
        case 'color'
            propertyNames = {propertyNames{:},'facecolor'};
            propertyValues = {propertyValues{:},varargin{argno+1}};
        otherwise
            propertyNames = {propertyNames{:},varargin{argno}};
            propertyValues = {propertyValues{:},varargin{argno+1}};
    end
    
end 

load(NACAName)


E = [-1 0 0; 
     0 0 -1;
     0 1  0];

E = E*R2;

N = size(NACA,1);

ymean = mean(NACA(:,2));
x = Chord*(ones(2,1)*NACA(:,1).' - 0.5*ones(2,N));
y = Thickness*([1;1]*NACA(:,2).' - ymean*ones(2,N));
z =[-L/2;L/2]*ones(1,N);

%Wing
xyz1=E*[x(1,:);y(1,:);z(1,:)];
xyz2=E*[x(2,:);y(2,:);z(2,:)];
xe=[xyz1(1,:);xyz2(1,:)];
ye=[xyz1(2,:);xyz2(2,:)];
ze=[xyz1(3,:);xyz2(3,:)];
[facPart{1},vertPart{1}] = surf2patch(xe,ye,ze);


%Wind tip 1
x = Chord*(NACA(:,1).' - 0.5);
ymean = mean(NACA(:,2));
y = Thickness*(NACA(:,2).' - ymean);

xyz=E*[x;y;L*ones(1,N)/2];

xe=xyz(1,:);
ye=xyz(2,:);
ze=xyz(3,:);

vertPart{2} = [xe.' ye.' ze.'];
facPart{2}  = [1:1:N];

%[facPart{2},vertPart{2}] = surf2patch(xe,ye,ze);

%Wind tip 2
xyz=E*[x;y;-L*ones(1,N)/2];

xe=xyz(1,:);
ye=xyz(2,:);
ze=xyz(3,:);

vertPart{3} = [xe.' ye.' ze.'];
facPart{3}  = [1:1:N];

cfacWing = facPart;
cvertWing = vertPart;

%Draw
for k = 1:3
    cvertWing{k} = (R1*cvertWing{k}.').' + ones(size(cvertWing{k},1),1)*P.';
end
Col = {[0.3 0.3 0.7],[0.0 0.0 0.0],[0.0 0.0 0.0]};
for k = 1:3
    hwing{k} = patch('faces',cfacWing{k},'vertices',cvertWing{k},'FaceColor',Col{k},'edgecolor','none');
end