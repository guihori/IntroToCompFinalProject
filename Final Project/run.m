function handles.particleList = run(handles.particleList) 


%nextTimeStep is used to prevent particles from clipping. Instead of
%updating the position of the particles by a full tick every time, we look
%for the specific time for when two particles are going to colide and we
%update the simulation by a fraction of a tick so that the two particles
%are just touching each other.
%Although this decreases the performance, the ammount is negligible and
%will allow us to achieve a more accurate simulation
nextTimeStep = 1;

    %Updates particles after bouncing off wall/border.
    for i = 1:length(handles.particleList)
        if handles.particleList(i).xPos >= 100 - handles.particleList(i).radius
            handles.particleList(i).angle = 180 - handles.particleList(i).angle;
        elseif handles.particleList(i).xPos <= handles.particleList(i).radius
            handles.particleList(i).angle = 180 - handles.particleList(i).angle;
        end
        if handles.particleList(i).yPos >= 100 - handles.particleList(i).radius
            handles.particleList(i).angle = -1 * handles.particleList(i).angle;
        elseif handles.particleList(i).yPos <= handles.particleList(i).radius
            handles.particleList(i).angle = -1 * handles.particleList(i).angle;
        end

        %update position of particles
        handles.particleList(i) = particleUpdate(handles.particleList(i),nextTimeStep);
    end
    
    nextTimeStep = 1;

    %Test for collision of all combinations of particles 
    if(length(handles.particleList)>1)
        for i = 1:length(handles.particleList)-1
            for j =i+1:length(handles.particleList)
                [handles.particleList(i), handles.particleList(j)] = collisionTest(handles.particleList(i),handles.particleList(j));

                
                [tTCol, colWithinASecond] = timeToCollision(handles.particleList(i),handles.particleList(j),"particleParticle");
                if colWithinASecond && tTCol < nextTimeStep
                    nextTimeStep = tTCol;
                end
            end
            [tTCol, colWithinASecond] = timeToCollision(handles.particleList(i),0,"particleWall");
            if colWithinASecond && tTCol < nextTimeStep
                    nextTimeStep = tTCol;
            end
        end
    end
end