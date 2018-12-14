function [xunit, yunit] = createCircle(x,y,r) 
%plots 101 points that will be used to draw a circle

%Inputs:
%x --> x coordinate of the center of the circle
%y --> y coordinate of the center of the circle
%r --> Radius of the circle

%Outputs:
%xunit, yunit --> two arrays containing 101 coordinates of the circle

%creates 101 degrees
th = 0:pi/50:2*pi;
%find the x and y coordinates based on the degree
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;