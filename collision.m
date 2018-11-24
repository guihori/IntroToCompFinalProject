function [finalParticle1, finalParticle2] = collision(particle1, particle2)

finalParticle1 = particle1;
finalParticle2 = particle2;

m1 = particle1.mass;
m2 = particle2.mass;

%Initial component velocities of the particles
v1ix = particle1.speed * cosd(particle1.angle);
v1iy = particle1.speed * sind(particle1.angle);
v2ix = particle2.speed * cosd(particle2.angle);
v2iy = particle2.speed * sind(particle2.angle);

%Final component velocities of the particles after elastic collision
v1fx = ( ( (m1 - m2) / (m1 + m2) ) * v1ix ) + ( ( (2 * m2) / (m1 + m2) ) * v2ix );
v1fy = ( ( (m1 - m2) / (m1 + m2) ) * v1iy ) + ( ( (2 * m2) / (m1 + m2) ) * v2iy );

v2fx = ( ( (2 * m1) / (m1 + m2) ) * v1ix ) + ( ( (m2 - m1) / (m1 + m2) ) * v2ix );
v2fy = ( ( (2 * m1) / (m1 + m2) ) * v1iy ) + ( ( (m2 - m1) / (m1 + m2) ) * v2iy );

%Magnitude of velocity of each particle
v1 = sqrt( (v1fx^2) + (v1fy^2) );
v2 = sqrt( (v2fx^2) + (v2fy^2) );

%Direction of velocity for each particle as a reference angle
a1 = atand(v1fy / v1fx);
a2 = atand(v2fy / v2fx);

%Reference angles are added to quadrantal angles based on the directions of the velocity components
%in order to find the full angle measured from the positive x-axis.
if v1fx >= 0 && v1fy >= 0
    a1 = 0 + a1;
elseif v1fx <= 0 && v1fy >= 0
    a1 = 180 + a1;
elseif v1fx <= 0 && v1fy <= 0
    a1 = 180 + a1;
elseif v1fx >= 0 && v1fy <= 0
    a1 = 360 + a1;
end

if v2fx >= 0 && v2fy >= 0
    a2 = 0 + a2;
elseif v2fx <= 0 && v2fy >= 0
    a2 = 180 + a2;
elseif v2fx <= 0 && v2fy <= 0
    a2 = 180 + a2;
elseif v2fx >= 0 && v2fy <= 0
    a2 = 360 + a2;
end

%The final speeds and angles are assigned to the output variables.
finalParticle1.speed = v1;
finalParticle2.speed = v2;
finalParticle1.angle = a1;
finalParticle2.angle = a2;
