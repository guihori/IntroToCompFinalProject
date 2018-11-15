r = 5; %radius of circle
figure('Position', [100,100,600,500])


for q = 1:1000 
    
    
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
    
    drawnow
end