
%Map = CreateMapSize50();
map = imresize(Map,0.25);

startpoint = [ 12 4]/4;
endpoint = [28 16]/4;

disp(startpoint);
disp(endpoint);

close all;
 %Uncomment following line to run Astar
[route, numExpanded] = AStarGrid (map, startpoint, endpoint);
[route, numExpanded] = DijkstraGrid (map, startpoint, endpoint);


