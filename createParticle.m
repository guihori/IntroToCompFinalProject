function particle = createParticle(speed,angle,xPos,yPos,r,m)
%Creates a particle structure with the inputs as fields

%Inputs:
%speed --> A double representing the speed of the particle
%angle --> A double representing the angle in degrees.
%xPos --> A double representing the x position of the particle
%yPos --> A double representing the y position of the particle
%r --> A double representing the radius of the particle
%m --> A double representing the mass of the particle

%Outputs:
%particle --> A particle structure


particle.speed = speed;

particle.angle = angle;

particle.xPos = xPos;

particle.yPos = yPos;

particle.radius = r;

particle.mass = m;
