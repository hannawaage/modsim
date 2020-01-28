- Run "AngularVelocityDemo.m" to visualize the effect of a given angular velocity "omega" on the orientation of a solid, and the rotation matrix "Rab" that represents that orientation.

- Run "EulerVelocityIllustration.m" to visualize how changes in the Euler angles impact the orientation of a solid. In particular, one can observe that a small variation of the 3 Euler angles does not (necessarily) result in a small rotation around the 3 axis of either frame a or b, but in something more subtle. As a result, since omega yields variations dphi, dtheta, dphi (in time), the components of omega are not simply dphi, dtheta, dphi.  


- Run "EulerSingularity.m" to visualize what happens when the transformation omega <--> dphi, dtheta, dphi becomes singular (det(M) = 0). This happens when theta = 90deg, which sends the third axis of frame b on the first axis of frame a. As a result, a small rotation around phi is equivalent to a small rotation around psi. We are then rotating twice around the same axis. In terms of angular velocities, it means that while omega can be anything (it is a physical quantity), time-derivatives of the Euler angle can only compose to angular velocities in a plane (red surface at the end of the animation)

- Run "SymbolicEulerVelocityDemo.m" to do automatically the tedious work that allows one to relate omega to dphi, dtheta, dphi. 