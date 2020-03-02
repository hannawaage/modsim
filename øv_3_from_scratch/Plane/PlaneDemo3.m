clear all
close all
clc

ScaleFrame = 10;

phi = 0;theta = 0;psi = 0;
Rac = eye(3);

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

FS = 25;
SW = 0.07;

Col = {'c','r','g'};

dt = .1;
cN = [50,50,50,13/dt];
phi = 0; 
theta = 0; 
psi  = 0; 

for c = 1:4

    if c == 4
        pause
    end
    for k = 1:cN(c)

        fig = figure(1);clf; hold on
        switch c
            case 2
                phi = 20*sin(2*pi*k/50)*pi/180; 
                %CircArrow(O,O+0.5*ScaleFrame*Rac*[1;0;0],1.5,0.15,1,'facealpha', 0.5, 'color', 'c'); 
            case 1
                theta = 20*sin(2*pi*k/50)*pi/180; 
                %CircArrow(O,O+0.5*ScaleFrame*Rac*[0;1;0],1.5,0.15,1,'facealpha', 0.5, 'color', 'red'); 
            case 3
                psi = 20*sin(2*pi*k/50)*pi/180; 
                %CircArrow(O,O+0.5*ScaleFrame*Rac*[0;0;1],1.5,0.15,1,'facealpha', 0.5, 'color', 'g'); 
            case 4
                phi = phi - 0.2*dt*(phi - 30*pi/180); 
                theta = 0*5*sin(2*pi*(k-1)/cN(c)-1)*pi/180; 
                psi = psi - dt*9.81*tan(phi)/10; 

        end
        [Rac,M] = Rotations3([phi;theta;psi]);

        for i = 1:3
            MakeArrow( O, M(:,i),0.8*ScaleFrame,FS,1.2*SW,'','facealpha', 0.5, 'color', Col{i})
            CircArrow( O, O + 0.5*ScaleFrame*M(:,i),1,0.2,1,'facealpha', 0.5, 'color', Col{i}); 
        end

        Plane(O,L,Thickness,Chord,Rac, 0.5 )
        MakeFrame( O,Rac,ScaleFrame,FS,SW,'b','facealpha', 1, 'color', 'r')
        MakeFrame( zeros(3,1),eye(3),ScaleFrame,FS,SW,'a','facealpha', 1, 'color', 'b')

        set(gca,'visible','off');
        set(gca,'xtick',[],'ytick',[],'ztick',[]);
        text(0.*ScaleFrame,2.*ScaleFrame,-1.*ScaleFrame,{['$$\phi=$$',num2str(180*phi/pi, '%+.2f'),'$$^\circ$$'],['$$\theta=$$',num2str(180*theta/pi, '%+.2f'),'$$^\circ$$'],['$$\psi=$$',num2str(180*psi/pi, '%+.2f'),'$$^\circ$$']},'verticalalignment','bottom','horizontalalignment','center','fontsize',FS,'interpreter','latex')
        text(0.*ScaleFrame,0.*ScaleFrame,+2.2*ScaleFrame,'$$R_b^a = R_3(\psi)R_1(\phi)R_2(\theta)$$','verticalalignment','bottom','horizontalalignment','left','fontsize',FS,'interpreter','latex')
            
        % Add lights
        DL = L;
        light('Position',DL*Rac*[1;0;1]);
        light('Position',DL*Rac*[1;0;-1]);
        light('Position',DL*Rac*[1;0;0]);
        light('Position',DL*[0;0;1]);
        hold off
        axis equal
        campos([234.7837;-131.0211;   63.6795])
        camtarget([6.0605   12.3067    7.7540])
        camva(6)
        drawnow
        if c == 1 && k == 1
            pause
        end
    end
end