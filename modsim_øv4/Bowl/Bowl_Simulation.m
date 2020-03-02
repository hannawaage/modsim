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
z0 = Bowlz(x0,y0,M)-0.*0.5;

q0  = [ x0; y0; z0];

[gradC] = BowlgraC(q0,M);

Omega = [-1;-0.5;0.2];
dq0 = cross(gradC/norm(gradC),Omega) - 0.*norm(Omega)*gradC/norm(gradC);

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
[X,Y,Z] = sphere(30);
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
    %[gradC] = BowlgraC(x_disp(1:3).',M);
    
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
    hold off
    axis equal
    set(gca,'visible','off');
    set(gca,'xtick',[],'ytick',[],'ztick',[]);

    axis equal



    if t_disp == 0

        line(x_disp(1)+[0,gradC(1)],x_disp(2)+[0,gradC(2)],x_disp(3)+[0,gradC(3)],'color','b','linewidth',2)
        line(x_disp(1)+[0,x_disp(4)],x_disp(2)+[0,x_disp(5)],x_disp(3)+[0,x_disp(6)],'color','r','linewidth',2)

        text(0,0,-0.75,['$$C(q(0)) = ',num2str(C),'$$'],'interpreter','latex','fontsize',FS,'horizontalalignment','center')
        text(0,0,-1.4,['$$\dot C(q(0),\dot q(0)) = \left.\frac{\partial C}{\partial q}\right|_{q(0)}\dot q(0)=',num2str(dC),'$$'],'interpreter','latex','fontsize',FS,'horizontalalignment','center')
        text(x_disp(1)+gradC(1),x_disp(2)+gradC(2),x_disp(3)+gradC(3),['$$\frac{\partial C}{\partial q}^T$$'],'interpreter','latex','fontsize',FS,'horizontalalignment','right','verticalalignment','bottom','color','b')
        text(x_disp(1)+x_disp(4),x_disp(2)+x_disp(5),x_disp(3)+x_disp(6),['$$\dot q$$'],'interpreter','latex','fontsize',FS,'horizontalalignment','left','verticalalignment','top','color','r')

        view([75,32])
        

        figure(10);clf
        subplot(2,1,1)
        plot(tsim,Csim,'k');set(gca,'fontsize',FS)
        xlabel('$$t$$','interpreter','latex','fontsize',FS)
        ylabel('$$C(q(t))$$','interpreter','latex','fontsize',FS)
        subplot(2,1,2)
        plot(tsim,dCsim,'k');set(gca,'fontsize',FS)
        xlabel('$$t$$','interpreter','latex','fontsize',FS)
        ylabel('$$\dot C(q(t))$$','interpreter','latex','fontsize',FS)
        
        pause
        CamPos = campos;
        CamTarget = camtarget;
        CamVa     = camva;
        drawnow

        fig = 2;
        tic

    else
        %line(x_disp(1)+[0,gradC(1)],x_disp(2)+[0,gradC(2)],x_disp(3)+[0,gradC(3)],'color','b','linewidth',2)
        campos(CamPos)
        camtarget(CamTarget)
        camva(CamVa)
        
        drawnow
        
    end
    t_disp = toc;
   
 end

 

%


