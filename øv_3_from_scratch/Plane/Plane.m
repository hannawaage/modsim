function Plane( O,L,Thickness,Chord,Rattitude, FA )

    Ptail = [-L/3;0;0];
    R1 = [1 0 0;
          0 0 -1;
          0 1 0];
    calage_Tail = -5*pi/180;
    Rtail = [cos(calage_Tail) sin(calage_Tail)  0;
            -sin(calage_Tail) cos(calage_Tail)  0;
                    0               0           1];

    %Cylinder1(O,O+Rattitude*[-10;0;0],0.1,100,'facealpha', FA, 'color', [0.1 0.1 0.1]);

    Cylinder1(O,O+Rattitude*(Ptail+[-Chord/5;0;0]),0.1,100,'facealpha', FA, 'color', [0.1 0.1 0.1]);
    Cylinder1(O+Rattitude*(Ptail+[-Chord/5;0;0]),O,0.1,100,'facealpha', FA, 'color', [0.1 0.1 0.1]);
    
    Wing1(O,L,Thickness,Chord,Rattitude,eye(3),'NACAProfile','facealpha', FA);
    Wing2(O,Ptail+[0;0;L/12],L/6,Thickness,Chord/2,Rattitude,Rtail,'NACAProfile','facealpha', FA);
    Wing2(O,Ptail+[0;0;L/24],L/12,Thickness,Chord/2,Rattitude,R1,'NACATail','facealpha', FA);


end

