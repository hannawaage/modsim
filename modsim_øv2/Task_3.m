
% Shepperd?s method is an algorithm for calculating the angle-axis representation of a rotation matrix
% (see section 6.7 in the book).
% (b) Implement a Matlab function that calculates the rotation angle ? and the rotation axis k for an
% arbitrary rotation matrix R. Add the Matlab script to your answer.
% Moreover, find the rotation axis and rotation angle for each of the rotation matrices in part 1.a.
% Are the obtained results reasonable? Explain.


R1 = [0 1 0;
      1 0 0; 
      0 0 -1];
R2 = [5/13 0 -12/13;
      0 1 0;
      12/13 0 5/13];
  
  [t1, k1] = Shepperd(R1);
  [t2, k2] = Shepperd(R2);
  
 

%% Shepperd
function [theta, k] = Shepperd(R)
    z_i = zeros(4);
    ind_vec = [1 2 3 4];
    T = trace(R);
    r00 = T;
    a = R(1,1);
    b = R(2,2);
    c = R(3,3);
    A = [r00, a, b, c];
    [rii, ind] = max(A) ; 
    z_i(ind) = sqrt(1 + 2*rii- T);
    for i = 1:4
        if(i ~= ind)
            if(ind == 1)
                switch(i)
                    case(i == 2)
                        z_i(i) = 1/z_i(ind)*(R(3,2) - R(2, 3));
                    case(i == 3)
                        z_i(i) = 1/z_i(ind)*(R(1,3) - R(3, 1));
                    case(i == 4)
                        z_i(i) = 1/z_i(ind)*(R(2,1) - R(1, 2));
                end
            else
                switch(i)
                    case(i == 1)
                        rem = ind_vec; 
                        rem(rem == 1) = [];
                        rem(rem == ind) = [];
                        a = rem(1) - 1; 
                        b = rem(2) - 1; 
                        z_i(i) = 1/z_i(ind)*(R(a, b) - R(b, a));
                    case(i == 2)
                        z_i(i) = 1/z_i(ind)*(R(i, ind) - R(ind, i));
                    case(i == 3)
                        z_i(i) = 1/z_i(ind)*(R(i, ind) - R(ind, i));
                    case(i == 4)
                        z_i(i) = 1/z_i(ind)*(R(i, ind) - R(ind, i));
                end
            end
        end
    end

     e = [z_i(2)/2; z_i(3)/2; z_i(4)/2];
     theta = 2*acos(z_i(1)/2);
     k = 1/(sin(theta/2))*e;
end

