function [finalParticle1, finalParticle2] = collision(particle1, particle2)

%All variables to be used in the following equations are assigned from the input structures.
finalParticle1 = particle1;
finalParticle2 = particle2;

m1 = particle1.mass;
m2 = particle2.mass;

v1 = particle1.speed;
v2 = particle2.speed;

a1i = particle1.angle;
a2i = particle2.angle;

x1 = particle1.xPos;
y1 = particle1.yPos;
x2 = particle2.xPos;
y2 = particle2.yPos;


%Contact angle of the two particles upon collision
dx = x2 - x1;
dy = y2 - y1;

if dx == 0
    
    phi = 90;
    
else
    
    phi = atand(dy/dx);
    
end


%Final component velocities of the particles after elastic collision
v1fx = (((v1 * cosd(a1i - phi) * (m1 - m2)) + (2 * m2 * v2 * cosd(a2i - phi))) / (m1 + m2)) * cosd(phi) + (v1 * sind(a1i - phi) * sind(phi));
v1fy = (((v1 * cosd(a1i - phi) * (m1 - m2)) + (2 * m2 * v2 * cosd(a2i - phi))) / (m1 + m2)) * sind(phi) + (v1 * sind(a1i - phi) * cosd(phi));

v2fx = (((v2 * cosd(a2i - phi) * (m2 - m1)) + (2 * m1 * v1 * cosd(a1i - phi))) / (m2 + m1)) * cosd(phi) + (v2 * sind(a2i - phi) * sind(phi));
v2fy = (((v2 * cosd(a2i - phi) * (m2 - m1)) + (2 * m1 * v1 * cosd(a1i - phi))) / (m2 + m1)) * sind(phi) + (v2 * sind(a2i - phi) * cosd(phi));


%Magnitude of velocity of each particle
v1f = sqrt((v1fx^2) + (v1fy^2));
v2f = sqrt((v2fx^2) + (v2fy^2));


%Direction of velocity for each particle
if v1fx < 0
          
    a1 = 180 + atand(v1fy/v1fx);

elseif v1fx > 0 && v1fy >= 0

    a1 = atand(v1fy/v1fx);

elseif v1fx > 0 && v1fy < 0

    a1 = 360 + atand(v1fy/v1fx);

elseif v1fx == 0 && v1fy == 0

    a1 = 0;

elseif v1fx == 0 && v1fy >= 0

    a1 = 90;

else

    a1 = 270;

end


if v2fx < 0
          
    a2 = 180 + atand(v2fy/v2fx);

elseif v2fx > 0 && v2fy >= 0

    a2 = atand(v2fy/v2fx);

elseif v2fx > 0 && v2fy < 0

    a2 = 360 + atand(v2fy/v2fx);

elseif v2fx == 0 && v2fy == 0

    a2 = 0;

elseif v2fx == 0 && v2fy >= 0

    a2 = 90;

else

    a2 = 270;

end

%The final speeds and angles are assigned to the output variables.
finalParticle1.speed = v1f;
finalParticle2.speed = v2f;
finalParticle1.angle = a1;
finalParticle2.angle = a2;
