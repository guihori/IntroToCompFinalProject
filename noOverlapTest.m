function output = noOverlapTest(y,particleList)
particle = createParticle(3*rand(1,1), rand(1,1)*360, y(2) + (100-2 * y(2)) * rand(1,1) , y(2) + (100-2 * y(2)) * rand(1,1) , y(2),y(1));
%particles collide if distance is <= sum of the 2 particles' radius\

for i = 1: length(particleList)
    distance = sqrt((particle.xPos-particleList(i).xPos)^2+(particle.yPos-particleList(i).yPos)^2);

    if(distance - ( particle.radius+particleList(i).radius) <= 0.0000000000001)
       output  = 0;
       print('Error: overlap of particles occured');
    
    end
end
output = 1;