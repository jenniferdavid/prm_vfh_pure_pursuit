%
% TestScript for Assignment 1
%

%% Define a small map
map = false(10);

% Add an obstacle
map (1:5, 6) = true;

start_coords = [6, 2];
dest_coords  = [8, 9];
 
%%
close all;
 %Uncomment following line to run Astar
[route, numExpanded] = AStarGrid_fixed (map, start_coords, dest_coords);
%[route, numExpanded] = AStarGrid_backup (map, start_coords, dest_coords);

