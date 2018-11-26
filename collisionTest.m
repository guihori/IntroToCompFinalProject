function [finalPartA, finalPartB] = collisionTest(partA,partB)
%defaults the particle to its original value if there is not a collision
finalPartA = partA;
finalPartB = partB;

%measures distance from particleA and particleB
distance = sqrt((partA.xPos-partB.xPos)^2+(partA.yPos-partB.yPos)^2);
%particles collide if distance is <= sum of the 2 particles' radius
if(distance <= partA.radius+partB.radius)
    [finalPartA, finalPartB] = collision(partA,partB);
end
