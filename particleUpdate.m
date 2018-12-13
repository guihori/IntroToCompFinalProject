function newParticle =  particleUpdate(oldParticle,timeElapsed)
    newParticle = oldParticle;
    newParticle.xPos = oldParticle.xPos + oldParticle.speed * cosd(oldParticle.angle) * timeElapsed;
    newParticle.yPos = oldParticle.yPos + oldParticle.speed * sind(oldParticle.angle) * timeElapsed;