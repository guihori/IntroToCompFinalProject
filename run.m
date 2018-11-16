
figure('Position', [100,100,600,500])


while true
    
    
    for i = 1:length(particleList)
        if particleList(i).xPos >= 100 - particleList(i).radius
            particleList(i).angle = 180 - particleList(i).angle;
        elseif particleList(i).xPos <= particleList(i).radius
            particleList(i).angle = 180 - particleList(i).angle;
        end
        if particleList(i).yPos >= 100 - particleList(i).radius
            particleList(i).angle = -1 * particleList(i).angle;
        elseif particleList(i).yPos <= particleList(i).radius
            particleList(i).angle = -1 * particleList(i).angle;
        end
        
        %update position of particles
        particleList(i) = particleUpdate(particleList(i),1);
    end
        
    
    %clear canvas
    %clf
    
    %temporary solution to fix the window size
    plot([-5,105],[-5,105]);
    
    %draw particle
    for i = 1:length(particleList)
        circle(particleList(i).xPos,particleList(i).yPos,particleList(i).radius);
    end
    
    %Test for collision of all combinations of particles 

   if(length(particleList)>1)
        for i = 1:length(particleList)-1
            for j =i+1:length(particleList)
                collisionTest(particleList(i),particleList(j));
                
                %finds time to collision, displays time if its less than 1
                timeToCollision = (-sqrt((2 * particleList(i).xPos * particleList(i).speed * cosd(particleList(i).angle)...
                    - 2 * particleList(i).xPos * particleList(j).speed * cosd(particleList(j).angle) - 2 * particleList(j).xPos...
                    * particleList(i).speed * cosd(particleList(i).angle) + 2 * particleList(j).xPos * particleList(j).speed...
                    * cosd(particleList(j).angle) + 2 * particleList(i).yPos * particleList(i).speed * sind(particleList(i).angle)...
                    - 2 * particleList(i).yPos * particleList(j).speed * sind(particleList(j).angle) - 2 * particleList(j).yPos...
                    * particleList(i).speed * sind(particleList(i).angle) + 2 * particleList(j).yPos * particleList(j).speed...
                    * sind(particleList(j).angle))^2 - 4 * (particleList(i).xPos^2 - 2 * particleList(i).xPos * particleList(j).xPos...
                    + particleList(j).xPos^2 + particleList(i).yPos^2 - 2 * particleList(i).yPos * particleList(j).yPos...
                    + particleList(j).yPos^2 - particleList(i).radius^2 - 2 * particleList(i).radius * particleList(j).radius...
                    - particleList(j).radius^2) * (-2 * particleList(i).speed * particleList(j).speed * sind(particleList(i).angle)...
                    * sind(particleList(j).angle) - 2 * particleList(i).speed * particleList(j).speed * cosd(particleList(i).angle)...
                    * cosd(particleList(j).angle) + particleList(i).speed^2 * sind(particleList(i).angle)^2 + particleList(i).speed^2 ...
                * cosd(particleList(i).angle)^2 + particleList(j).speed^2 * sind(particleList(j).angle)^2 + particleList(j).speed^2 ...
                    * cosd(particleList(j).angle)^2)) - 2 * particleList(i).xPos * particleList(i).speed * cosd(particleList(i).angle)...
                    + 2 * particleList(i).xPos * particleList(j).speed * cosd(particleList(j).angle) + 2 * particleList(j).xPos...
                    * particleList(i).speed * cosd(particleList(i).angle) - 2 * particleList(j).xPos * particleList(j).speed...
                    * cosd(particleList(j).angle) - 2 * particleList(i).yPos * particleList(i).speed * sind(particleList(i).angle)...
                    + 2 * particleList(i).yPos * particleList(j).speed * sind(particleList(j).angle) + 2 * particleList(j).yPos...
                    * particleList(i).speed * sind(particleList(i).angle) - 2 * particleList(j).yPos * particleList(j).speed...
                    * sind(particleList(j).angle))/(2 *(-2 * particleList(i).speed * particleList(j).speed * sind(particleList(i).angle)...
                    * sind(particleList(j).angle) - 2 * particleList(i).speed * particleList(j).speed * cosd(particleList(i).angle)...
                    * cosd(particleList(j).angle) + particleList(i).speed^2 * sind(particleList(i).angle)^2 + particleList(i).speed^2 ...
                    * cosd(particleList(i).angle)^2 + particleList(j).speed^2 * sind(particleList(j).angle)^2 + particleList(j).speed^2 ...
                    * cosd(particleList(j).angle)^2));
                if timeToCollision >= 0 && timeToCollision < 1 && isreal(timeToCollision)
                    disp(timeToCollision)
                end

            end
        end
    end
    
    drawnow
end
