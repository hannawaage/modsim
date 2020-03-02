clear all
%close all
clc

% Måten state-vektoren funker på: (ingen posisjon/fart nødvendig)
% x = [
%         R(1,1)
%         R(2,1)
%         R(3,1)
%         R(1,2)
%         R(2,2)
%         R(3,2)
%         R(1,3)
%         R(2,3)
%         R(3,3)
%         omega1
%         omega2
%         omega3
%         ]

g = 9.81;
L = 2; 
m = 1;
parameters = [g, L, m];
% r_0 = [24454248; 24454248 ;24454248];
% R_0 = eye(3);
% v_0 = -r_0.*parameters(1)*parameters(2)/((sqrt(r_0(1)^2+r_0(2)^2+r_0(3)^2))^3);
% omega_0 = 0.001*[1000; 1000; 1000];

r_0 = [3; 3 ;3];
R_0 = eye(3);
%v_0 = -r_0./((sqrt(r_0(1)^2+r_0(2)^2+r_0(3)^2))^3);
w = 0.5;
omega_0 = w*[1, 1, 1]';
       
R_0_vec = [R_0(1:3, 1);
         R_0(1:3, 2);
         R_0(1:3, 3)];
state = [R_0_vec;
         omega_0];
p = R_0*[0;0;L];

% "parameters" allows you to pass some parameters to the "SatelliteDynamics" function

time_final = 120; %Final time

% Simulate satellite dynamics
[time,statetraj] = ode45(@(t,x)topspinnerdynamics(t, x, parameters),[0,time_final],state);

% Here below is a template for a real-time animation
tic; % resets Matlab clock
time_display = 0; % time displayed
while time_display < time(end)
    
    time_animate = toc; % get the current clock time
    % Interpolate the simulation at the current clock time
    state_animate = interp1(time, statetraj, time_animate);
    
    state_animate = state_animate';
    
    R = [state_animate(1:3:7)'; 
         state_animate(2:3:8)';
         state_animate(3:3:9)'];
    p = R*[0;0;L];
    %p = r_0;
    omega = state_animate(10:12);
    state_animate = state_animate';
    
    figure(1);clf;hold on
    ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
    FS         = 15;  % Fontsize for text
    SW         = 0.035; % Arrows size
    MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'b')
    Cylinder(zeros(3,1),p,0.1, 'color', [.5,0,.1]);
    MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
    Cylinder(p,p+R*[0;0;0.25],1,'FaceColor','r','facealpha',0.25,'FaceLighting','gouraud','SpecularStrength',1,'Diffusestrength',0.5,'AmbientStrength',0.7,'SpecularExponent',5);
    FormatPicture([0;0;2],0.25*[73.8380   21.0967   30.1493])



    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; % get the current clock time
end
