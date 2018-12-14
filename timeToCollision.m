function time = timeToCollision (particle1,particle2,typeOfCollision,lower,upper)
%Finds time for a particle to hit another particle or wall

%Inputs:
%particle1 --> A particle structure
%particle2 --> A particle structure. Only required for particle particle
%              collisions
%typeOfCollision --> Describes if the collision happens between another
%                    particle or wall
%                    true --> Particle particle collision
%                    false --> Particle wall collision
%lower --> The lower bounds of the simulation. Only required for particle
%          wall collisions
%upper --> The upper bounds of the simulation. Only required for particle
%          wall collisions

%Outputs:
%time --> Time until the particle collides with the other particle or wall.
%         Warning: time can be evaluated to imaginary numbers if collision
%         between two particles never happen. 

%Particle particle collisions
if typeOfCollision
    %Formula for finding the time until two particles hit each other.
    %Read readme file for explanation
    time = (-sqrt((2 * particle1.xPos * particle1.speed * cosd(particle1.angle)...
            - 2 * particle1.xPos * particle2.speed * cosd(particle2.angle) - 2 * particle2.xPos...
            * particle1.speed * cosd(particle1.angle) + 2 * particle2.xPos * particle2.speed...
            * cosd(particle2.angle) + 2 * particle1.yPos * particle1.speed * sind(particle1.angle)...
            - 2 * particle1.yPos * particle2.speed * sind(particle2.angle) - 2 * particle2.yPos...
            * particle1.speed * sind(particle1.angle) + 2 * particle2.yPos * particle2.speed...
            * sind(particle2.angle))^2 - 4 * (particle1.xPos^2 - 2 * particle1.xPos * particle2.xPos...
            + particle2.xPos^2 + particle1.yPos^2 - 2 * particle1.yPos * particle2.yPos...
            + particle2.yPos^2 - particle1.radius^2 - 2 * particle1.radius * particle2.radius...
            - particle2.radius^2) * (-2 * particle1.speed * particle2.speed * sind(particle1.angle)...
            * sind(particle2.angle) - 2 * particle1.speed * particle2.speed * cosd(particle1.angle)...
            * cosd(particle2.angle) + particle1.speed^2 * sind(particle1.angle)^2 + particle1.speed^2 ...
            * cosd(particle1.angle)^2 + particle2.speed^2 * sind(particle2.angle)^2 + particle2.speed^2 ...
            * cosd(particle2.angle)^2)) - 2 * particle1.xPos * particle1.speed * cosd(particle1.angle)...
            + 2 * particle1.xPos * particle2.speed * cosd(particle2.angle) + 2 * particle2.xPos...
            * particle1.speed * cosd(particle1.angle) - 2 * particle2.xPos * particle2.speed...
            * cosd(particle2.angle) - 2 * particle1.yPos * particle1.speed * sind(particle1.angle)...
            + 2 * particle1.yPos * particle2.speed * sind(particle2.angle) + 2 * particle2.yPos...
            * particle1.speed * sind(particle1.angle) - 2 * particle2.yPos * particle2.speed...
            * sind(particle2.angle))/(2 *(-2 * particle1.speed * particle2.speed * sind(particle1.angle)...
            * sind(particle2.angle) - 2 * particle1.speed * particle2.speed * cosd(particle1.angle)...
            * cosd(particle2.angle) + particle1.speed^2 * sind(particle1.angle)^2 + particle1.speed^2 ...
            * cosd(particle1.angle)^2 + particle2.speed^2 * sind(particle2.angle)^2 + particle2.speed^2 ...
            * cosd(particle2.angle)^2));
    
else
    time = 1;
    
    %time to hit left wall. x = 0
    time1 = (lower + particle1.radius - particle1.xPos) / (cosd(particle1.angle) * particle1.speed);
    %time to hit right wall. x = 100
    time2 = (upper - particle1.radius - particle1.xPos) / (cosd(particle1.angle) * particle1.speed);
    %time to hit bottom wall. y = 0
    time3 = (lower +particle1.radius - particle1.yPos) / (sind(particle1.angle) * particle1.speed);
    %time to hit top wall. y = 100
    time4 = (upper - particle1.radius - particle1.yPos) / (sind(particle1.angle) * particle1.speed);
    
    
    %picks the smallest time that is greater than 0
    if time1 > 0
        time = time1;
    end
    if time2 > 0 && time2 < time
        time = time2;
    end
    if time3 > 0 && time3 < time
        time = time3;
    end
    if time4 > 0 && time4 < time
        time = time4;
    end
        
end