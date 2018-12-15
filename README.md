# IntroToCompFinalProject

Particle Simulator: Elastic Collisions in Two Dimensions

The purpose of this project is to simulate elastic collisions between particles in a closed two-dimensional environment.

---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

Goal List
- [x] Create structures for particles
- [x] Display the particles on a plot
- [x] Update particles through an update method
- [x] Create bounds for our field
- [x] Implement physics for the collision between two particles
- [x] Create a full GUI for the simulation
- [x] Create one click button to create new particles
- [x] Create one click button to remove particles

---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

Explanation on how to find the time it takes until two particles collide:

Each particle has the following properties: x-coordinate, y-coordinate, speed, angle (degrees), radius

-

currentparticle1:	x1(Known)	y1(Known)	s1(Known)	a1(Known)	r1(Known)

currentparticle2:	x2(Known)	y2(Known)	s2(Known)	a2(Known)	r2(Known)

finalparticle1:		Fx1(Unknown)	Fy1(Unknown)

finalparticle2:		Fx2(Unknown)	Fy2(Unknown)

time:			t(Unknown)

-

hit happens at:
sqrt( (Fx1-Fx2)^2 + (Fy1-Fy2)^2 ) = r1 + r2


final position:
x1 + cos(a1) * s1 * t = Fx1

y1 + sin(a1) * s1 * t = Fy1

x2 + cos(a2) * s2 * t = Fx2

y2 + sin(a2) * s2 * t = Fy2


substitute the values:
sqrt( ( x1 + cos(a1) * s1 * t - (x2 + cos(a2) * s2 * t) )^2 + (y1 + sin(a1) * s1 * t - (y2 + sin(a2) * s2 * t) )^2 ) = r1 + r2


solve for t:
t = (-sqrt((2 x1 s1 cos(a1) - 2 x1 s2 cos(a2) - 2 x2 s1 cos(a1) + 2 x2 s2 cos(a2) + 2 y1 s1 sin(a1) - 2 y1 s2 sin(a2) - 2 y2 s1 sin(a1) + 2 y2 s2 sin(a2))^2 - 4 (x1^2 - 2 x1 x2 + x2^2 + y1^2 - 2 y1 y2 + y2^2 - r1^2 - 2 r1 r2 - r2^2) (-2 s1 s2 sin(a1) sin(a2) - 2 s1 s2 cos(a1) cos(a2) + s1^2 sin^2(a1) + s1^2 cos^2(a1) + s2^2 sin^2(a2) + s2^2 cos^2(a2))) - 2 x1 s1 cos(a1) + 2 x1 s2 cos(a2) + 2 x2 s1 cos(a1) - 2 x2 s2 cos(a2) - 2 y1 s1 sin(a1) + 2 y1 s2 sin(a2) + 2 y2 s1 sin(a1) - 2 y2 s2 sin(a2))/(2 (-2 s1 s2 sin(a1) sin(a2) - 2 s1 s2 cos(a1) cos(a2) + s1^2 sin^2(a1) + s1^2 cos^2(a1) + s2^2 sin^2(a2) + s2^2 cos^2(a2)))
t = (sqrt((2 x1 s1 cos(a1) - 2 x1 s2 cos(a2) - 2 x2 s1 cos(a1) + 2 x2 s2 cos(a2) + 2 y1 s1 sin(a1) - 2 y1 s2 sin(a2) - 2 y2 s1 sin(a1) + 2 y2 s2 sin(a2))^2 - 4 (x1^2 - 2 x1 x2 + x2^2 + y1^2 - 2 y1 y2 + y2^2 - r1^2 - 2 r1 r2 - r2^2) (-2 s1 s2 sin(a1) sin(a2) - 2 s1 s2 cos(a1) cos(a2) + s1^2 sin^2(a1) + s1^2 cos^2(a1) + s2^2 sin^2(a2) + s2^2 cos^2(a2))) - 2 x1 s1 cos(a1) + 2 x1 s2 cos(a2) + 2 x2 s1 cos(a1) - 2 x2 s2 cos(a2) - 2 y1 s1 sin(a1) + 2 y1 s2 sin(a2) + 2 y2 s1 sin(a1) - 2 y2 s2 sin(a2))/(2 (-2 s1 s2 sin(a1) sin(a2) - 2 s1 s2 cos(a1) cos(a2) + s1^2 sin^2(a1) + s1^2 cos^2(a1) + s2^2 sin^2(a2) + s2^2 cos^2(a2)))

Because time can only be positive, we only care about the positive solution.
