clear all
%close all
clc

% Måten state-vektoren funker på: 
% x = [ r1
%         r2 
%         r2
%         R(1,1)
%         R(2,1)
%         R(3,1)
%         R(1,2)
%         R(2,2)
%         R(3,2)
%         R(1,3)
%         R(2,3)
%         R(3,3)
%         v1
%         v2
%         v3
%         omega1
%         omega2
%         omega3
%         ]

G = 6.67408*10^(-11);
earth_mass = 5.972*10^(24);
parameters = [G, earth_mass];
% r_0 = [24454248; 24454248 ;24454248];
% R_0 = eye(3);
% v_0 = -r_0.*parameters(1)*parameters(2)/((sqrt(r_0(1)^2+r_0(2)^2+r_0(3)^2))^3);
% omega_0 = 0.001*[1000; 1000; 1000];
r_0 = [3; 3 ;3];
R_0 = eye(3);
v_0 = -r_0./((sqrt(r_0(1)^2+r_0(2)^2+r_0(3)^2))^3);
omega_0 = 0.0005*[1000; 1000; 1000];
       
R_0_vec = [R_0(1:3, 1);
         R_0(1:3, 2);
         R_0(1:3, 3)];
state = [r_0; 
         R_0_vec;
         v_0;
         omega_0];

% "parameters" allows you to pass some parameters to the "SatelliteDynamics" function

time_final = 120; %Final time

% Simulate satellite dynamics
[time,statetraj] = ode45(@(t,x)SatelliteDynamics(t, x, parameters),[0,time_final],state);

% Here below is a template for a real-time animation
tic; % resets Matlab clock
time_display = 0; % time displayed
while time_display < time(end)
    
    time_animate = toc; % get the current clock time
    % Interpolate the simulation at the current clock time
    state_animate = interp1(time, statetraj, time_animate);
    
    state_animate = state_animate';
    p = state_animate(1:3);
    R = [state_animate(4:3:10)'; 
         state_animate(5:3:11)';
         state_animate(6:3:12)'];
    omega = state_animate(16:18);
    state_animate = state_animate';
     
    figure(1);clf;hold on
    ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
    FS         = 15;  % Fontsize for text
    SW         = 0.035; % Arrows size
    MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'r')
    MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
    DrawRectangle(p,R ,'color',[0.5,0.5,0.5]);
    %FormatPicture()
    FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])


    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; % get the current clock time
end
