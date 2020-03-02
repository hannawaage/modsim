clear all
close all
clc

ScaleFrame = 10;

roll = 0*pi/180; %Roll
pitch = 0*pi/180; %Pitch
yaw  = 0*pi/180; %Yaw


R{1} = [1       0        0;
        0 cos(roll) -sin(roll);
        0 sin(roll)  cos(roll)];
    
R{2} = [cos(pitch) 0 -sin(pitch);
           0       1      0;
        sin(pitch) 0  cos(pitch)];
    
R{3} = [cos(yaw)  -sin(yaw)     0;
        sin(yaw)   cos(yaw)     0;
            0           0       1];
        
Rac = R{3}*R{2}*R{1};

vinf = 30;rho = 1.2;
w1 = 0;

w3 = -5;

alpha0 = -8*pi/180;

Thickness = 2;
Chord = 2;

L = 30;AR = 10;
A = 5;
O = 10*ones(3,1);

Scale = 5e-3;

Shift = [0];
for k = 1:1
    alpha{k} = alpha0 + Shift(k)*w1/vinf;
    CL{k} = -2*pi*alpha{k}*(AR/(2+AR));
    CD{k} = 6*CL{k}^2/pi/AR;
    
    v{k} = vinf - Shift(k)*w3/vinf;
    
    R{k}        = [cos(alpha{k}) 0  -sin(alpha{k});
                     0       1      0;
                    sin(alpha{k}) 0  cos(alpha{k})];

    
    

    PP{k} = Rac*[Chord/5;Shift(k);0];

    Velocity{k} = Rac*R{k}*[6;0;0];
    Lift{k} =  Rac*0.5*Scale*rho*A*CL{k}*R{k}*[0;0;v{k}^2];
    Drag{k} = -Rac*0.5*Scale*rho*A*CD{k}*R{k}*[v{k}^2;0;0];
    RAF{k}  = (Lift{k}+Drag{k});

end

    
    

for i = 1:1
    alphas = linspace(0,alpha{i},100);  
    for k = 1:length(alphas)
        RAoA    = [cos(alphas(k)) 0  -sin(alphas(k));
                     0       1      0;
                  sin(alphas(k)) 0  cos(alphas(k))];
        AoA{i}(:,k) = PP{i}+Rac*RAoA*[5;0;0];
    end
end
FS = 25;
SW = 0.07;

AoALabel = {'$$\alpha_\mathrm{Left}$$','$$\alpha_\mathrm{Right}$$'};



fig = figure(1);hold on
Plane(O,L,Thickness,Chord,Rac, 0.5 )
MakeFrame( O,Rac,ScaleFrame,FS,SW,'b','facealpha', 1, 'color', 'r')
MakeFrame( zeros(3,1),eye(3),ScaleFrame,FS,SW,'a','facealpha', 1, 'color', 'b')



% for k = 1:1
%     plot3(AoA{k}(1,:),AoA{k}(2,:),AoA{k}(3,:),'linewidth',3,'color','k')
%     text(AoA{k}(1,1)+0.25,AoA{k}(2,1),AoA{k}(3,1),AoALabel{k},'horizontalalignment','left','verticalalignment','bottom','fontsize',20,'interpreter','latex')
%     OPP = O+PP{k};
%     %mArrow3(OPP,Lift{k}+PP{k}, 'facealpha', 0.5, 'color', 'blue', 'stemWidth', SW);
%     %mArrow3(OPP,Drag{k}+PP{k}, 'facealpha', 0.5, 'color', 'red', 'stemWidth', SW);
%     mArrow3(OPP,Velocity{k}+PP{k}, 'facealpha', 0.5, 'color', 'g', 'stemWidth', SW);
%     %mArrow3(OPP,RAF{k}+PP{k}, 'facealpha', 0.5, 'color', [0.2,0.2,0.2], 'stemWidth', SW);
% 
%     %Cylinder1(Lift{k}+PP{k},RAF{k}+PP{k},0.025,100,'facealpha', 0.5, 'color', 0.9*[1 1 1]);
%     %Cylinder1(Drag{k}+PP{k},RAF{k}+PP{k},0.025,100,'facealpha', 0.5, 'color', 0.9*[1 1 1]);
%     %Cylinder1(PP{k},PP{k}+[6;0;0],0.03,100,'facealpha', 0.5, 'color', 0.5*[1 1 1]);
%     
% end


% Cylinder1(O,O+Rac*[0;0;cos(roll)*L/4],0.1,100,'facealpha', 0.5, 'color', 0.3*[1 1 1]);
% Cylinder1(O,O+[0;0;L/4],0.07,100,'facealpha', 0.5, 'color', 0.3*[1 1 1]);
% 
% Cylinder1(O,O+Rac*[L/4;0;0],0.1,100,'facealpha', 0.5, 'color', 0.3*[1 1 1]);
% CircArrow(O,O+Rac*[0;0;cos(roll)*L/4],1.5,0.15,-1,'facealpha', 0.5, 'color', 'g'); 
% 
% CircArrow(O,O+Rac*[L/4;0;0],1.5,0.15,1,'facealpha', 0.5, 'color', 'red'); 
% CircArrow(O,O+[0;0;L/4],1.5,0.15,-1,'facealpha', 0.5, 'color', 'c'); 
% 
% Cylinder1(O+[0;0;L/4],O+Rac*[0;0;cos(roll)*L/4],0.025,100,'facealpha', 0.5, 'color', 0.9*[1 1 1]);
% 
% 
% mg = -[0;0;RAF{1}(3)];
% mArrow3(OPP,mg, 'facealpha', 0.5, 'color', [0.2,0.2,0.2], 'stemWidth', SW);
% Cylinder1(OPP,OPP+[0;0;10],0.025,100,'facealpha', 0.5, 'color', 0.0*[1 1 1]);


set(gca,'visible','off');
set(gca,'xtick',[],'ytick',[],'ztick',[]);

% Add lights
DL = L;
light('Position',DL*Rac*[1;0;1]);
light('Position',DL*Rac*[1;0;-1]);
light('Position',DL*Rac*[1;0;0]);
light('Position',DL*[0;0;1]);
hold off
axis equal

ViewAngleTable = linspace(0,2*pi,360);
for k = 1:length(ViewAngleTable)
    ViewAngle = ViewAngleTable(k);
    Rview = [cos(ViewAngle)  -sin(ViewAngle)     0;
             sin(ViewAngle)   cos(ViewAngle)     0;
                 0           0       1];
    campos(Rview*[234.7837;-131.0211;   63.6795])
    camtarget([6.0605   12.3067    7.7540])
    camva(6)
    drawnow
end