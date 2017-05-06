Map = CreateMapSize50();
startpoint = [25 10];
endpoint = [28 40];

% map = imresize(Map,0.25);
% startpoint = [ 12 4]/4;
% endpoint = [28 16]/4;

disp(startpoint);
disp(endpoint);
close all;
[route, numExpanded] = AStarGrid (Map, startpoint, endpoint);
%figure;
%[route, numExpanded] = DijkstraGrid (Map, startpoint, endpoint);
