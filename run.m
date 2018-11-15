
figure('Position', [100,100,600,500])


while true
    
    
    for i = 1:length(particleList)
        if particleList(i).xPos >= 100 - r
            particleList(i).angle = 180 - particleList(i).angle;
        elseif particleList(i).xPos <= r
            particleList(i).angle = 180 - particleList(i).angle;
        end
        if particleList(i).yPos >= 100 - r
            particleList(i).angle = -1 * particleList(i).angle;
        elseif particleList(i).yPos <= r
            particleList(i).angle = -1 * particleList(i).angle;
        end
        
        %update position of particles
        particleList(i) = particleUpdate(particleList(i),1);
    end
        
    
    %clear canvas
    %clf
    
    %temporary solution to fix the window size
    plot([-5,105],[-5,105])
    
    %draw particle
    for i = 1:length(particleList)
        circle(particleList(i).xPos,particleList(i).yPos,r)
    end
    
    %Test for collision of all combos of particles 

   if(length(particleList)>1)
        for i = 1:length(particleList)-1
            for j =i+1:length(particleList)
                collisionTest(particleList(i),particleList(j));
            end
        end
    end
    
    drawnow
end
