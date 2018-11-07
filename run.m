while true
    clf
    for i = 1:length(a)
        a(i) = particleUpdate(a(i),1);
    end
    for i = 1:length(a)
        circle(a(i).xPos,a(i).yPos,5)
    end
    drawnow
end