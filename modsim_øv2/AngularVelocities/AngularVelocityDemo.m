clear all
close all
clc

% Frame rotation

FS = 40;

SW = 0.07;

ScaleFrame = 5;

theta_end = 2*pi;

Nsteps = 1e2;
theta = 0;

A = eye(3);


p = [1;-1;1];   
   
Oa = [1;1;1];
dt = 0.01;


Otable = {[0;0;1],[0;1;1],[1;1;1]};
       
Rab = eye(3);
for rotcase = 1:3

    Oa  = Otable{rotcase};
    
    OaX = [   0,   -Oa(3),  +Oa(2);
            +Oa(3),   0,    -Oa(1);
            -Oa(2), +Oa(1),    0];

    
   
    for i = 1:Nsteps+1

            dRab = OaX*Rab;
            
            figure(1);clf;hold on
            MakeFrame( zeros(3,1),eye(3),ScaleFrame,FS,0.8*SW,'','facealpha', 0.5, 'color', 'k')
            MakeFrame( zeros(3,1),Rab,ScaleFrame,FS,0.8*SW,'','facealpha', 0.5, 'color', 'b')

 
            h{1} = mArrow3(zeros(3,1),sqrt(3)*ScaleFrame*Oa, 'stemWidth', 2*SW); 
            set(h{1}, 'facecolor', [0.1,0.5,0.1],'facealpha', 0.5);

            %h{2} = mArrow3(zeros(3,1),ScaleFrame*Rab*p, 'stemWidth', 2*SW); 
            %set(h{2}, 'facecolor', [0.5,0.1,0.1],'facealpha', 0.5);



            DrawCube( zeros(3,1), Rab, 5*eye(3), 'c' ,0.1 )


            text(ScaleFrame*Oa(1),ScaleFrame*Oa(2),ScaleFrame*Oa(3),'$$\omega^a$$','color',[0.1,0.5,0.1],'verticalalignment','bottom','horizontalalignment','right','fontsize',FS,'interpreter','latex','interpreter','latex')

            text(0,0,ScaleFrame,'a','color','k','verticalalignment','bottom','horizontalalignment','right','fontsize',FS,'interpreter','latex')
            set(gca,'visible','off');
            set(gca,'xtick',[],'ytick',[],'ztick',[]);

            % Add lights
            DL = 30;
            light('Position',DL*[1;0;1]);
            light('Position',DL*[1;0;-1]);
            light('Position',DL*[1;0;0]);
            light('Position',DL*[0;0;1]);
            hold off
            axis equal

            text(0,1.5*ScaleFrame,-1.5*ScaleFrame,['$$\omega^a = \left [\begin {array}{c} ',num2str(Oa(1), '%+.2f'),'\\\noalign{\medskip}',num2str(Oa(2), '%+.2f'),'\\\noalign{\medskip}',num2str(Oa(3), '%+.2f'),'\end {array}\right ] $$'],'verticalalignment','bottom','horizontalalignment','center','fontsize',FS,'interpreter','latex','color',[0.1,0.5,0.1])

            camtarget([1.4273         0    0.4806])
            campos([103.2845   23.6747   39.7107])
            camva(8)



            Textpos = ScaleFrame*Rab*[0;0;1];
            text(Textpos(1),Textpos(2),Textpos(3),'b','color','b','verticalalignment','bottom','horizontalalignment','left','fontsize',FS,'interpreter','latex')



            drawnow

            Rab = Rab*expm(dt*OaX); % Symplectic
            %Rab = Rab + dt*dRab;   % Euler (accumalates error over time)
    end
end





