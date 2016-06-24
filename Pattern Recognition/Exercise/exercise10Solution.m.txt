function exercise10Solution()
% last point added as noise point
points=[1 1.7;2.2 1.4; 2.1 2.3; 0.7 2.2; 2.6 2.9; 1.5 4];

length = size(points,1);
distances = zeros(length);
for i=1:length
    for j=1:length
        distances(i,j) = sqrt((points(i,1)-points(j,1)).^2 + (points(i,2)-points(j,2))^2);
    end
end

distances

radius = 1.5;
minPts = 2;

figure;
plot(points(:,1),points(:,2), 'r.', 'LineWidth', 70);

hold on;
for i=1:length
    neighbours = sum(distances(i,:)<=radius) - 1;
    
    [x,y] = CreateCircle(points(i,:), radius);
    if (neighbours >= minPts)
        plot(x,y, 'g', 'LineWidth', 5);
    else
        plot(x,y, 'b', 'LineWidth', 5);
    end
end
xlim([-1, 6]);
ylim([-1, 6]);
axis('square');


function [x, y] = CreateCircle(center, radius)
    l = linspace(0, 2*pi, 100);
    x = radius.*cos(l) + center(1);
    y = radius.*sin(l) + center(2);
end

end
