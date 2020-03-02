clear all
close all
clc

scale = [0.1;1];
FS = 20;
FA = [1,0.2];
EC = {'none','none'};

tf = 10;
m = 1;
g = 9.81;

M = eye(2);
param = [m;g];

%Simulate trajectories
x0 = 1;
y0 = 1;
z0 = Bowlz(x0,y0,M)-0.5*0;

q0  = [ x0; y0; z0];

[gradC] = BowlgraC(q0,M);

Omega = [-1;-0.5;0.2];
dq0 = cross(gradC/norm(gradC),Omega) - 0*norm(Omega)*gradC/norm(gradC);

state0 = [q0;dq0];

[C,dC] = BowlCC(state0,param,M); %Check consistency


DynBowl_swap = @(t,x)DynBowl(t,x,param,M);
opt = odeset('RelTol',1e-6,'AbsTol',1e-6);
[tsim,xsim] = ode45(DynBowl_swap,[0,tf],state0,opt);

for k = 1:length(xsim)
    [Csim(k),dCsim(k)] = BowlCC(xsim(k,1:6).',param,M); %Check consistency
end

%% Create Objects

%Sphere
[X,Y,Z] = sphere(20);
[fac{1},vert{1},c] = surf2patch(X,Y,Z);



%Bowl
xgrid = max(abs(xsim(:,1)));
ygrid = max(abs(xsim(:,2)));
grid = max(xgrid,ygrid);
[xmesh,ymesh] = meshgrid(linspace(-grid,grid,100),linspace(-grid,grid,100));

zmesh = Bowlz(xmesh,ymesh,M);
[fac{2}, vert{2}, Col] = surf2patch(xmesh,ymesh,zmesh,[0.5,0.5,0.5]);

Col = {[0.7,0.2,0.2],'b'};
   
tic
t_disp = 0;fig = 1;
 while t_disp < tf
    
    x_disp = interp1(tsim,xsim,t_disp);
    
    pos{1} = ones(length(vert{1}),1)*x_disp(1:3);        
    pos{2} = zeros(size(vert{2}));

    
    figure(fig);clf;hold on
    for k = 1:2
        h{k} = patch('faces',fac{k},'vertices',scale(k)*vert{k}+pos{k});
        set(h{k},'FaceColor',Col{k},'edgecolor',EC{k},'facealpha',FA(k),'FaceLighting','gouraud','SpecularStrength',1,'Diffusestrength',0.5,'AmbientStrength',0.7,'SpecularExponent',5)
    end

    plot3(xsim(:,1),xsim(:,2),xsim(:,3),'color','k')
    
    light('Position',[1 3 2]);
    light('Position',[-3 0 3]);
    axis equal
    set(gca,'visible','off');
    set(gca,'xtick',[],'ytick',[],'ztick',[]);

    axis equal
    view([-10,28])
    campos([-4.0462  -22.9473   13.3535])
    camtarget( [0 0 1])
    camva(7.5)

    drawnow
        
    if t_disp == 0
        pause
        tic
    end
    
    t_disp = toc;
   
 end

 

%


