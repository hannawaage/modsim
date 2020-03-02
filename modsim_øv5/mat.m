a = 2*pi/3;
b = 4*pi/3; 
R1 = eye(3); 
R2 = R1;
R3 = R1; 
R2(1, 1) = cos(a);
R2(1, 2) = -sin(a);
R2(2, 1) = cos(a);
R2(2, 2) = sin(a);
R3(1, 1) = cos(b);
R3(1, 2) = -sin(b);
R3(2, 1) = cos(b);
R3(2, 2) = sin(b);
p = [0; 
     0; 
     0];
  figure(1);clf;hold on
    ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
    FS         = 15;  % Fontsize for text
    SW         = 0.035; % Arrows size
%MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'b')
MakeFrame(p,R1,ScaleFrame,FS,SW,'one', 'color', 'r')
MakeFrame(p,R2,ScaleFrame,FS,SW,'two', 'color', 'b')
MakeFrame(p,R3,ScaleFrame,FS,SW,'three', 'color', 'g')
FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])
