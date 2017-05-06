imageOriginal=imread('map.png');
imageTransfered=imageOriginal(:,:,1);

Map = (255-imageTransfered)/255;
map = logical(Map);
startpoint = [400 420];
endpoint = [450 480];
 
% Map = (255-imageTransfered)/255;
% map = imresize(Map,0.25);
% startpoint = [320 320]./4;
% endpoint = [480 880]./4;

[route, numExpanded] = AStarGrid (map, startpoint, endpoint);
%[route, numExpanded] = DijkstraGrid (map, startpoint, endpoint);

