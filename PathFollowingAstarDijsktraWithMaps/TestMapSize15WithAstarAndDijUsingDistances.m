
map = CreateMapSize15();

startpoint = [3 3];%row column
endpoint = [7 9];%row column

disp(startpoint);
disp(endpoint);

close all;
 %Uncomment following line to run Astar
[path, route, numExpanded] = AStarGrid (map, startpoint, endpoint);
%[route, numExpanded] = DijkstraGrid (map, startpoint, endpoint);

