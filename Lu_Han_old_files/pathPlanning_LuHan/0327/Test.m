
map = CreateMap0327();

startpoint = [ 3 3];
endpoint = [47 23];

disp(startpoint);
disp(endpoint);

close all;
 %Uncomment following line to run Astar
%[route, numExpanded] = AStarGrid (map, startpoint, endpoint);
[route, numExpanded] = DijkstraGrid (map, startpoint, endpoint);

