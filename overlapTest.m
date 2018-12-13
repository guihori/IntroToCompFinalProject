function isValid = overlapTest(newParticle,particleList)
%particles collide if distance is <= sum of the 2 particles' radius\
    x1 = newParticle.xPos;
    y1 = newParticle.yPos;
    isValid = 1;
    
    %The first particle is a dummy particle which does not count, so if the
    %length is 1, the particle will fit, otherwise it must check against
    %every other particle.
    if length(particleList) ~= 1
        for i = 2:length(particleList)
            x2 = particleList(i).xPos;
            y2 = particleList(i).yPos;

            distance = sqrt((x1-x2)^2+(y1-y2)^2);
            
            %Because we are dealing with decimals, this error bound is to
            %prevent clipping when the numbers are very close but not
            %exactly equal.
            if distance - (newParticle.radius+particleList(i).radius) <= 0.0000000000001
                isValid = 0;
                return
            end
        end
    end
