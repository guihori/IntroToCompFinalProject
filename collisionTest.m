function collisionTest(partA,partB)
distance = sqrt((partA.xPos-partB.xPos)^2+(partA.yPos-partB.yPos)^2);




if(distance <= partA.radius+partB.radius)
    collision(partA,partB);
end