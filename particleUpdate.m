function newParticle =  particleUpdate(oldParticle,timeElapsed)
%This function moves the particle by giving the new x and y coordinates.

%Inputs:
%oldParticle --> A particle structure
%timeElapsed --> A double representing how much time the simulation will
%                proceed

%Outputs:
%newParticle --> An updated particle structure


newParticle = oldParticle;
newParticle.xPos = oldParticle.xPos + oldParticle.speed * cosd(oldParticle.angle) * timeElapsed;
newParticle.yPos = oldParticle.yPos + oldParticle.speed * sind(oldParticle.angle) * timeElapsed;