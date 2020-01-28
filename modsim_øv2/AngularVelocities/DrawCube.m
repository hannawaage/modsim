function DrawCube( pos, R, D, Col, FA )

    %% Body:
    vert       = [  -1, -1, -1;  %1
                     1, -1, -1;  %2
                     1,  1, -1;  %3
                    -1,  1, -1;  %4
                    -1, -1,  1;  %5
                     1, -1,  1;  %6
                     1,  1,  1;  %7
                    -1,  1,  1]; %8

    fac       = [ 1 2 3 4;
                  5 6 7 8;
                  1 4 8 5;
                  1 2 6 5;
                  2 3 7 6;
                  3 4 8 7];

    p = patch('faces',fac,'vertices',vert*D*R.' + ones(8,1)*pos.');
    set(p,'FaceColor',Col,'edgecolor','k','facealpha',FA,'FaceLighting','gouraud','SpecularStrength',1,'Diffusestrength',0.5,'AmbientStrength',0.7,'SpecularExponent',5)


end

