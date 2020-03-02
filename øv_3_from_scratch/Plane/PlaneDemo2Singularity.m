clear all
close all
clc

ScaleFrame = 10;


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
for k = 1:101
    
    phi = 0*pi/180; %Roll
    psi = (k-1)*pi/2/100; %Pitch
    theta  = 0*pi/180; %Yaw


    [Rac,M] = Rotations2([phi;theta;psi]);



    fig = figure(1);clf;hold on
    Plane(O,L,Thickness,Chord,Rac, 1 )
    MakeFrame( O,Rac,ScaleFrame,FS,SW,'b','facealpha', 1, 'color', 'r')
    MakeFrame( zeros(3,1),eye(3),ScaleFrame,FS,SW,'a','facealpha', 1, 'color', 'b')

    for i = 1:3
        MakeArrow( O, M(:,i),0.8*ScaleFrame,FS,1.2*SW,'','facealpha', 0.5, 'color', Col{i})
        CircArrow( O, O + 0.5*ScaleFrame*M(:,i),1,0.2,1,'facealpha', 0.5, 'color', Col{i}); 
    end


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

    text(0.*ScaleFrame,2.*ScaleFrame,-1.*ScaleFrame,{['$$\phi=$$',num2str(180*phi/pi, '%+.2f'),'$$^\circ$$'],['$$\theta=$$',num2str(180*theta/pi, '%+.2f'),'$$^\circ$$'],['$$\psi=$$',num2str(180*psi/pi, '%+.2f'),'$$^\circ$$'],['det($$M$$) = ',num2str(det(M), '%+.2f')]},'verticalalignment','bottom','horizontalalignment','center','fontsize',FS,'interpreter','latex')
    text(0.*ScaleFrame,0.*ScaleFrame,+2.2*ScaleFrame,'$$R_b^a = R_2(\theta)R_3(\psi)R_1(\phi)$$','verticalalignment','bottom','horizontalalignment','left','fontsize',FS,'interpreter','latex')

    campos([234.7837;-131.0211;   63.6795])
    camtarget([6.0605   12.3067    7.7540])
    camva(6)
    drawnow
    if k == 1
        pause
    end

end

           
            
   