function isValid = overlapTest(newParticle,particleList)
%particles collide if distance is <= sum of the 2 particles' radius\
    x1 = newParticle.xPos;
    y1 = newParticle.yPos;
    isValid = 1;
    
    if length(particleList) ~= 1
        for i = 2:length(particleList)
            x2 = particleList(i).xPos;
            y2 = particleList(i).yPos;

            distance = sqrt((x1-x2)^2+(y1-y2)^2);

            if distance - ( newParticle.radius+particleList(i).radius) <= 0.0000000000001
                isValid = 0;
                return
            end
        end
    end
