map = CreateMapSize15();

startpoint = [4 4];%row column
endpoint = [4 9];%row column

disp(startpoint);
disp(endpoint);

close all;
 %Uncomment following line to run Astar
[route, numExpanded] = AStarGrid (map, startpoint, endpoint);
figure;
[route, numExpanded] = DijkstraGrid (map, startpoint, endpoint);

