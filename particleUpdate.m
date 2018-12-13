function newParticle =  particleUpdate(oldParticle,timeElapsed)
    %This function moves the particle by giving the new x and y
    %coordinates.
    
    newParticle = oldParticle;
    newParticle.xPos = oldParticle.xPos + oldParticle.speed * cosd(oldParticle.angle) * timeElapsed;
    newParticle.yPos = oldParticle.yPos + oldParticle.speed * sind(oldParticle.angle) * timeElapsed;