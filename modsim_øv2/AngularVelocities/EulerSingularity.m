clear all
close all
clc

% Body rotation

FS = 40;

V = 5*ones(3,1);


SW = 0.07;

ScaleFrame = 5;

roll_end  = 45*2*pi; %Roll
pitch_end = pi/2; %Pitch
yaw_end   = 45*pi/180; %Yaw

AnglesSteps = [     0       ,   0       , 0;
                30*pi/180,20*pi/180,10*pi/180;
                -33*pi/180,pi/2,22*pi/180];


roll = 0;
pitch = 0;
yaw = 0;

A = eye(3);

Nsteps = [30, 30, 30, 100, 30, 30, 30, 100, 30, 30, 30];

Preview = true;Rac = eye(3);
for RotCase = 1:11

    for i = 1:Nsteps(RotCase)+1

        switch RotCase
            % Show 1st rotations 
            % Show 1st rotations 
            case 1
                axisRot = [1;0;0];
                roll = AnglesSteps(1,1) + 5*sin(2*pi*(i-1)/Nsteps(RotCase))*pi/180;     
                pitch = AnglesSteps(1,2);yaw = AnglesSteps(1,3);  
                A10   = AnglesSteps(1,1);A20 = AnglesSteps(1,2);A30 = AnglesSteps(1,3);
                Angle = '\phi';
            case 2
                axisRot = [0;1;0];
                pitch = AnglesSteps(1,2) + 5*sin(2*pi*(i-1)/Nsteps(RotCase))*pi/180;
                roll = AnglesSteps(1,1);yaw = AnglesSteps(1,3); 
                A10   = AnglesSteps(1,1);A20 = AnglesSteps(1,2);A30 = AnglesSteps(1,3);
                 Angle = '\theta';
            case 3
                axisRot = [0;0;1];
                yaw = AnglesSteps(1,3) + 5*sin(2*pi*(i-1)/Nsteps(RotCase))*pi/180;
                roll = AnglesSteps(1,1);pitch = AnglesSteps(1,2); 
                A10   = AnglesSteps(1,1);A20 = AnglesSteps(1,2);A30 = AnglesSteps(1,3);
                Angle = '\psi';
            % Rotate to mid position
            case 4
                axisRot = [];
                r1 = (Nsteps(RotCase) - i + 1)/Nsteps(RotCase);r2 = (i-1)/Nsteps(RotCase);
                roll  = AnglesSteps(1,1)*r1 + AnglesSteps(2,1)*r2;
                pitch = AnglesSteps(1,2)*r1 + AnglesSteps(2,2)*r2;
                yaw   = AnglesSteps(1,3)*r1 + AnglesSteps(2,3)*r2;
                
            % Show 2nd rotations 
            case 5
                axisRot = [1;0;0];
                roll = AnglesSteps(2,1) + 5*sin(2*pi*(i-1)/Nsteps(RotCase))*pi/180;     
                pitch = AnglesSteps(2,2);yaw = AnglesSteps(2,3);  
                A10   = AnglesSteps(2,1);A20 = AnglesSteps(2,2);A30 = AnglesSteps(2,3);
                 Angle = '\phi';
            case 6
                axisRot = [0;1;0];
                pitch = AnglesSteps(2,2) + 5*sin(2*pi*(i-1)/Nsteps(RotCase))*pi/180;
                roll = AnglesSteps(2,1);yaw = AnglesSteps(2,3); 
                A10   = AnglesSteps(2,1);A20 = AnglesSteps(2,2);A30 = AnglesSteps(2,3);
                Angle = '\theta';
            case 7
                axisRot = [0;0;1];
                yaw = AnglesSteps(2,3) + 5*sin(2*pi*(i-1)/Nsteps(RotCase))*pi/180;
                roll = AnglesSteps(2,1);pitch = AnglesSteps(2,2); 
                A10   = AnglesSteps(2,1);A20 = AnglesSteps(2,2);A30 = AnglesSteps(2,3);
                Angle = '\psi';

                
            % Rotate to final position
            case 8
                axisRot = [];
                r1 = (Nsteps(RotCase) - i + 1)/Nsteps(RotCase);r2 = (i-1)/Nsteps(RotCase);
                roll  = AnglesSteps(2,1)*r1 + AnglesSteps(3,1)*r2;
                pitch = AnglesSteps(2,2)*r1 + AnglesSteps(3,2)*r2;
                yaw   = AnglesSteps(2,3)*r1 + AnglesSteps(3,3)*r2;

            % Show 3nd rotations 
            case 9
                axisRot = [1;0;0];
                roll = AnglesSteps(3,1) + 5*sin(2*pi*(i-1)/Nsteps(RotCase))*pi/180;     
                pitch = AnglesSteps(3,2);yaw = AnglesSteps(3,3);  
                A10   = AnglesSteps(3,1);A20 = AnglesSteps(3,2);A30 = AnglesSteps(3,3);
                Angle = '\phi';
                
            case 10
                axisRot = [0;1;0];
                pitch = AnglesSteps(3,2) + 5*sin(2*pi*(i-1)/Nsteps(RotCase))*pi/180;
                roll = AnglesSteps(3,1);yaw = AnglesSteps(3,3); 
                A10   = AnglesSteps(3,1);A20 = AnglesSteps(3,2);A30 = AnglesSteps(3,3);
                Angle = '\theta';
            case 11
                axisRot = [0;0;1];
                yaw = AnglesSteps(3,3) + 5*sin(2*pi*(i-1)/Nsteps(RotCase))*pi/180;
                roll = AnglesSteps(3,1);pitch = AnglesSteps(3,2); 
                A10   = AnglesSteps(3,1);A20 = AnglesSteps(3,2);A30 = AnglesSteps(3,3);
                Angle = '\psi';
                
        end

        R{1} = [1       0        0;
                0 cos(roll) -sin(roll);
                0 sin(roll)  cos(roll)];

        R{2} = [cos(pitch) 0  sin(pitch);
                   0       1      0;
               -sin(pitch) 0  cos(pitch)];

        R{3} = [cos(yaw)  -sin(yaw)     0;
                sin(yaw)   cos(yaw)     0;
                    0           0       1];



        Rac = R{1}*R{2}*R{3};

        A1 = roll;A2 = pitch;A3 = yaw;
          
        M = [ 1,       0,          sin(A20);
              0, cos(A10), -cos(A20)*sin(A10);
              0, sin(A10),  cos(A10)*cos(A20)];  
          
          
        M2 = [ 1,       0,          sin(A2);
              0, cos(A1), -cos(A2)*sin(A1);
              0, sin(A1),  cos(A1)*cos(A2)];    
                
        figure(1);clf;hold on
        MakeFrame( zeros(3,1),eye(3),ScaleFrame,FS,0.8*SW,'a','facealpha', 0.5, 'color', 'k')
        MakeFrame( zeros(3,1),Rac,ScaleFrame,FS,0.8*SW,'b','facealpha', 0.5, 'color', 'b')

        if length(axisRot) > 0
            LogRotAxis{RotCase} = M*axisRot;
            CircArrow([0;0;0],LogRotAxis{RotCase},1,0.1,1,'facealpha', 0.5, 'color', [0,0.5,0]); 
            if not(sum(LogRotAxis{RotCase})==1)
                MakeArrow( [0;0;0],LogRotAxis{RotCase},ScaleFrame,FS,0.5*SW,'','facealpha', 0.5, 'color', [0,0.5,0])
            end
        end
        
        

        
        RacV = Rac*V;


        DrawCube( zeros(3,1), Rac, 4*eye(3), 'c' ,0.1 )


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

        if not(RotCase == 4) && not(RotCase == 8) && i < Nsteps(RotCase)+1
            text(0,-ScaleFrame,1.25*ScaleFrame,['Move $$',Angle,'$$, axis ',int2str(find(axisRot))],'verticalalignment','bottom','horizontalalignment','center','fontsize',FS,'interpreter','latex')
        end

        %text(0,-ScaleFrame,-1.25*ScaleFrame,['$$\phi=$$',num2str(180*roll/pi, '%+.2f'),'\\ $$\theta=$$',num2str(180*pitch/pi, '%+.2f'),'\n $$\psi=$$',num2str(180*yaw/pi, '%+.2f')],'verticalalignment','bottom','horizontalalignment','center','fontsize',FS,'interpreter','latex')
        text(0,-1.5*ScaleFrame,-1.5*ScaleFrame,{['$$\phi=$$',num2str(180*roll/pi, '%+.2f'),'$$^\circ$$'],['$$\theta=$$',num2str(180*pitch/pi, '%+.2f'),'$$^\circ$$'],['$$\psi=$$',num2str(180*yaw/pi, '%+.2f'),'$$^\circ$$'],['det$$(M)=',num2str(det(M2), '%+.2f'),'$$']},'verticalalignment','bottom','horizontalalignment','center','fontsize',FS,'interpreter','latex')
        
        camtarget([1.4273         0    0.4806])
        campos([103.2845   23.6747   39.7107])
        camva(8)


        if Preview
            drawnow
            pause
            Preview = false;
        end
        
        if RotCase == 3 && i == Nsteps(RotCase)+1
            for rot = 1:3
                CircArrow([0;0;0],LogRotAxis{rot},1,0.1,1,'facealpha', 0.5, 'color', [0,0.5,0]); 
                MakeArrow( [0;0;0],LogRotAxis{rot},ScaleFrame,FS,0.8*SW,'','facealpha', 0.5, 'color', [0,0.5,0])
            end
            pause
        end
        
        if RotCase == 7 && i == Nsteps(RotCase)+1
            for rot = 5:7
                CircArrow([0;0;0],LogRotAxis{rot},1,0.1,1,'facealpha', 0.5, 'color', [0,0.5,0]); 
                MakeArrow( [0;0;0],LogRotAxis{rot},ScaleFrame,FS,0.8*SW,'','facealpha', 0.5, 'color', [0,0.5,0])
            end
            text(0,-ScaleFrame,1.25*ScaleFrame,['Press a key'],'verticalalignment','bottom','horizontalalignment','center','fontsize',FS,'interpreter','latex')
            pause
        end
        
        if RotCase == 8 && i == Nsteps(RotCase)+1
            text(0,-ScaleFrame,1.25*ScaleFrame,['Press a key'],'verticalalignment','bottom','horizontalalignment','center','fontsize',FS,'interpreter','latex')
            pause
        end
        
        if RotCase == 11 && i == Nsteps(RotCase)+1
            for rot = 9:11
                if rot == 11
                    shift = .7;
                else
                    shift = 0;
                end
                CircArrow([0;0;0]+shift*LogRotAxis{rot},(1+shift)*LogRotAxis{rot},1,0.1,1,'facealpha', 0.5, 'color', [0,0.5,0]); 
                MakeArrow( [0;0;0],LogRotAxis{rot},ScaleFrame,FS,0.8*SW,'','facealpha', 0.5, 'color', [0,0.5,0])
            end
            text(0,-ScaleFrame,1.25*ScaleFrame,['Press a key'],'verticalalignment','bottom','horizontalalignment','center','fontsize',FS,'interpreter','latex')
            pause
            fac  = [ 1 2 3 4];
            vert = [ 0,0,0;  %1
                     LogRotAxis{9}.';  %2
                     LogRotAxis{9}.' + LogRotAxis{10}.';  %3
                     LogRotAxis{10}.'];  %4
            p = patch('faces',fac,'vertices',ScaleFrame*vert);
            set(p,'FaceColor','r','edgecolor','k','facealpha',.5,'FaceLighting','gouraud','SpecularStrength',1,'Diffusestrength',0.5,'AmbientStrength',0.7,'SpecularExponent',5)

        end

        if i > 1
           drawnow
        end
        
        

    end
    
    for i = 1:3
        Rlog{i} = R{i};
    end
end





