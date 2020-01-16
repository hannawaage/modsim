tspan = [0 5];
y0 = 1;
[t,y] = ode45(@(t,y) y*y, tspan, y0);
figure(1);
subplot(1,2,1);
plot(t,y','-o');

y0 = 0;
[t,y1] = ode45(@(t,y) sqrt(abs(y)), tspan, y0);
subplot(1,2,2); 
plot(t,y1','-o');


