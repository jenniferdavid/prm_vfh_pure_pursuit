%% empty map
imageOriginal=imread('SmartHome_empty.png');
imageTransfered=imageOriginal(:,:,1);
Map = (255-imageTransfered)/255;
map = logical(Map);
startpoint = [20 5];
endpoint = [20 15];
%[route, numExpanded] = AStarGrid (map, startpoint, endpoint);
[route, numExpanded] = AStarGrid_fixed (map, startpoint, endpoint);