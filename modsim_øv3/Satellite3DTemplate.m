clear all
%close all
clc



% "parameters" allows you to pass some parameters to the "SatelliteDynamics" function

r = [24454248;24454248;24454248];   % Position of the satellite
omega = [1;2;3];  % Omega

k = random('norm',0,1,[3,1]); % Random axis of rotation / angle
R = expm([   0,      -k(3),  +k(2);
             +k(3),     0,   -k(1);
             -k(2), +k(1),    0]);      % Rotation matrix describing the satellite orientation

% Define your initial state, e.g. as:
position = r;
orientation = R; 
G = 6.67408*10^(-11);
earth_mass = 5.972*10^(24);
velocity = r.*G*earth_mass/((sqrt(r(1)^2+r(2)^2+r(3)^2))^3);
omega = [1;2;3];
state = [position';
         orientation;
         velocity';
         omega'];
parameters = [G, earth_mass];
         
time_final = 120; %Final time

% Simulate satellite dynamics
t = linspace(0, 120);
x = state;
[time,statetraj] = ode45(@(t,x)SatelliteDynamics(t, x, parameters),[0,time_final],state);

% Here below is a template for a real-time animation
tic; % resets Matlab clock
time_display = 0; % time displayed
while time_display < time(end)
    time_animate = toc; % get the current clock time
    % Interpolate the simulation at the current clock time
    state_animate = interp1(time,statetraj,time_animate);

    figure(1);clf;hold on
    ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
    FS         = 15;  % Fontsize for text
    SW         = 0.035; % Arrows size
    
    p = [statetraj(state_animate, 1); 
        statetraj(state_animate, 7); 
        statetraj(state_animate, 13)];
    R = [statetraj(state_animate, 2:4); 
        statetraj(state_animate, ); 
        statetraj(state_animate, 13)];
        
    
    MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'r')
    MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
    DrawRectangle(p,R ,'color',[0.5,0.5,0.5]);
    FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])
    % Use the example from "Satellite3DExample.m" to display your satellite

    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; % get the current clock time
end
