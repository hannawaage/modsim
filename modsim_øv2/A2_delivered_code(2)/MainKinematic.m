clear all
close all
clc

time_final = 20; %Final time

%%%%%% MODIFY. Initial state values and parameter values

R = [0 0 0;
    0 0 0;
    0 0 0];
omega = [2, 3, 4]';
parameters = omega; 

% Simulate dynamics
try
    %%%%%% MODIFY THE FUNCTION "Kinematics" TO PRODUCE SIMULATIONS OF THE SOLID ORIENTATION
    %%%%%%
    %%%%%% Hints:
    %%%%%% - "parameters" allows you to pass some parameters to the "Kinematic" function.
    %%%%%% - "state" will contain representations of the solid orientation (SO(3)).
    %%%%%% - use the "reshape" function to turn a matrix into a vector or vice-versa.

    [time,statetraj] = ode45(@(t,x)Kinematics(t, x, parameters),[0,time_final],R);

catch message
    display('Your simulation failed with the following message:')
    display(message.message)
    display(' ')

    %Assign dummy time and states if simulation failed
    time = [0,10];
    statetraj = [0,0];
end

%Below is a template for a real-time animation
ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
FS         = 15;  % Fontsize for text
SW         = 0.035; % Arrows size

time_display = 0; % initialise time_display
while time_display < time(end)

    state_animate = interp1(time,statetraj,time_display); %interpolate the simulated state at the current clock time

    %p     = [5;5;5];  % Position of the single body
    
    omega = parameters;
    [R, M] = Rotations(state_animate');
    p = state_animate(1:3)';
    
    %3D below this point
    figure(1);clf;hold on
    MakeFrame( zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame( p,R,ScaleFrame,FS,SW,'b', 'color', 'r')
    MakeArrow( p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
    DrawRectangle(p,R ,'color',[0.5,0.5,0.5]);
    FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])

    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; %get the current clock time
end
