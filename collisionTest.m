function collisionTest(partA,partB)
%measures distance from particleA and particleB
distance = sqrt((partA.xPos-partB.xPos)^2+(partA.yPos-partB.yPos)^2);
%particles collide if distance is <= sum of the 2 particles' radius
if(distance <= partA.radius+partB.radius)
    collision(partA,partB);
end
