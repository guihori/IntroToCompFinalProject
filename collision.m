function [finalParticle1, finalParticle2] = collision(particle1, particle2)

%The output structures are assigned the same properties as the input
%structures in order to preserve any properties of the particles unaffected
%by the collision, such as mass and radius.
finalParticle1 = particle1;
finalParticle2 = particle2;

%The mass of each particle is assigned to a variable with a simpler name in
%order to keep later calculations simple and easy to understand.
m1 = particle1.mass;
m2 = particle2.mass;

%The velocities and positions of the two particles are converted into
%vector form.
v1 = [particle1.speed*cosd(particle1.angle), particle1.speed*sind(particle1.angle)];
v2 = [particle2.speed*cosd(particle2.angle), particle2.speed*sind(particle2.angle)];

r1 = [particle1.xPos, particle1.yPos];
r2 = [particle2.xPos, particle2.yPos];

%The magnitudes of the differences between the particles' positions are
%calculated, each to be used in the calculation of the final velocity for
%each particle.
r1r2diff = r1 - r2;
r2r1diff = r2 - r1;

r1r2mag = sqrt(r1r2diff(1)^2 + r1r2diff(2)^2);
r2r1mag = sqrt(r2r1diff(1)^2 + r2r1diff(2)^2);

%The final velocity vectors of each particle are calculated, following 
%the rules of an elastic collision.
v1f = v1 - ((((2*m2)/(m1+m2)) * ((dot((v1 - v2), (r1 - r2))) / (r1r2mag^2))) * (r1-r2));
v2f = v2 - ((((2*m1)/(m1+m2)) * ((dot((v2 - v1), (r2 - r1))) / (r2r1mag^2))) * (r2-r1));

%The components of the final velocity vectors are then separated into
%simpler variables in order to simplify further calculations.
x1 = v1f(1);
y1 = v1f(2);
x2 = v2f(1);
y2 = v2f(2);

%The magnitudes of the velocity vectors for each particle are calculcated
%here.
v1fMag = sqrt(x1^2 + y1^2);
v2fMag = sqrt(x2^2 + y2^2);

%The direction of velocity for each particle is calculated here. Since the
%inverse tangent function only gives a reference angle, the following
%conditional statements are used to determine the actual angle on a
%360-degree scale.
if x1 > 0 && y1 == 0
    a1 = 0;
    
elseif x1 > 0 && y1 > 0
    a1 = atand(y1/x1);
    
elseif x1 == 0 && y1 > 0
    a1 = 90;
    
elseif x1 < 0 && y1 > 0
    a1 = 180 - abs(atand(y1/x1));
    
elseif x1 < 0 && y1 == 0
    a1 = 180;
    
elseif x1 < 0 && y1 < 0
    a1 = 180 + abs(atand(y1/x1));
    
elseif x1 == 0 && y1 < 0
    a1 = 270;
    
elseif x1 > 0 && y1 < 0
    a1 = 360 - abs(atand(y1/x1));
    
end


if x2 > 0 && y2 == 0
    a2 = 0;
    
elseif x2 > 0 && y2 > 0
    a2 = atand(y2/x2);
    
elseif x2 == 0 && y2 > 0
    a2 = 90;
    
elseif x2 < 0 && y2 > 0
    a2 = 180 - abs(atand(y2/x2));
    
elseif x2 < 0 && y2 == 0
    a2 = 180;
    
elseif x2 < 0 && y2 < 0
    a2 = 180 + abs(atand(y2/x2));
    
elseif x2 == 0 && y2 < 0
    a2 = 270;
    
elseif x2 > 0 && y2 < 0
    a2 = 360 - abs(atand(y2/x2));
    
end

%The final speeds and angles are assigned to their corresponding variables
%inside the output structures.
finalParticle1.speed = v1fMag;
finalParticle2.speed = v2fMag;
finalParticle1.angle = a1;
finalParticle2.angle = a2;