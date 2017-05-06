
Map = CreateMapSize50();
map = imresize(Map,0.25);

startpoint = [ 10 5];
endpoint = [7 10];

disp(startpoint);
disp(endpoint);

close all;
 %Uncomment following line to run Astar
%[route, numExpanded] = DijkstraGrid (Map, startpoint, endpoint*2);
[route, numExpanded] = AStarGrid (map, startpoint, endpoint);


