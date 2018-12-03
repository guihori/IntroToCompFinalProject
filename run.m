
figure('Position', [100,100,600,500])

%nextTimeStep is used to prevent particles from clipping. Instead of
%updating the position of the particles by a full tick every time, we look
%for the specific time for when two particles are going to colide and we
%update the simulation by a fraction of a tick so that the two particles
%are just touching each other.
%Although this decreases the performance, the ammount is negligible and
%will allow us to achieve a more accurate simulation
nextTimeStep = 1;

totalTimeElapsed = 0,


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
        particleList(i) = particleUpdate(particleList(i),nextTimeStep);
    end
    
    totalTimeElapsed = totalTimeElapsed + nextTimeStep,
    nextTimeStep = 1;

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
                [particleList(i), particleList(j)] = collisionTest(particleList(i),particleList(j));

                
                [tTCol, colWithinASecond] = timeToCollision(particleList(i),particleList(j),"particleParticle");
                if colWithinASecond && tTCol < nextTimeStep
                    nextTimeStep = tTCol;
                end
            end
            [tTCol, colWithinASecond] = timeToCollision(particleList(i),0,"particleWall");
            if colWithinASecond && tTCol < nextTimeStep
                    nextTimeStep = tTCol;
            end
        end
   end
    
    drawnow
end
