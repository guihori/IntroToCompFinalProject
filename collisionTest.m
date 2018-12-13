function booleanOut = collisionTest(partA,partB)
%defaults the particle to its original value if there is not a collision

%measures distance from particleA and particleB
distance = sqrt((partA.xPos-partB.xPos)^2+(partA.yPos-partB.yPos)^2);

%particles collide if distance is <= sum of the 2 particles' radius\
if(distance - ( partA.radius+partB.radius) <= 0.0000000000001)
    booleanOut = true;
else
    booleanOut = false;
end
