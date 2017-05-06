%% map1
imageOriginal=imread('map1.png');
imageTransfered=imageOriginal(:,:,1);
Map = (255-imageTransfered)/255;
map = logical(Map);
startpoint = [100 200];
endpoint = [100 250];
[route, numExpanded] = AStarGrid_fixed (map, startpoint, endpoint);

%% map2
imageOriginal=imread('map2.png');
imageTransfered=imageOriginal(:,:,1);
Map = (255-imageTransfered)/255;
map = logical(Map);
startpoint = [300 300];
endpoint = [300 400];
[route, numExpanded] = AStarGrid_fixed (map, startpoint, endpoint);

%% map3
imageOriginal=imread('map3.png');
imageTransfered=imageOriginal(:,:,1);
Map = (255-imageTransfered)/255;
map = logical(Map);
startpoint = [500 300];
endpoint = [500 400];
[route, numExpanded] = AStarGrid_fixed (map, startpoint, endpoint);

%% map4
imageOriginal=imread('map4.png');
imageTransfered=imageOriginal(:,:,1);
Map = (255-imageTransfered)/255;
map = logical(Map);
startpoint = [200 100];
endpoint = [200 200];
[route, numExpanded] = AStarGrid_fixed (map, startpoint, endpoint);

%% small smart home map
imageOriginal=imread('SmartHome_small.png');
imageTransfered=imageOriginal(:,:,1);
Map = (255-imageTransfered)/255;
map = logical(Map);
startpoint = [50 20];
endpoint = [50 40];
[route, numExpanded] = AStarGrid_fixed (map, startpoint, endpoint);

%% middle smart home map 
imageOriginal=imread('SmartHome_middle.png');
imageTransfered=imageOriginal(:,:,1);
Map = (255-imageTransfered)/255;
map = logical(Map);
startpoint = [80 90];
endpoint = [100 160];
[route, numExpanded] = AStarGrid_fixed (map, startpoint, endpoint);

%% entire map
imageOriginal=imread('SmartHome_entire.png');
imageTransfered=imageOriginal(:,:,1);
Map = (255-imageTransfered)/255;
map = logical(Map);
startpoint = [320 320];
endpoint = [320 318];
[route, numExpanded] = AStarGrid_fixed (map, startpoint, endpoint);

%% piece map
imageOriginal=imread('SmartHome_piece.png');
imageTransfered=imageOriginal(:,:,1);
Map = (255-imageTransfered)/255;
map = logical(Map);
startpoint = [30 20];
endpoint = [80 120];
[route, numExpanded] = AStarGrid_fixed (map, startpoint, endpoint);

%% empty map
imageOriginal=imread('SmartHome_empty.png');
imageTransfered=imageOriginal(:,:,1);
Map = (255-imageTransfered)/255;
map = logical(Map);
startpoint = [20 5];
endpoint = [20 15];
[route, numExpanded] = AStarGrid_fixed (map, startpoint, endpoint);

%%
% Map = (255-imageTransfered)/255;
% map = imresize(Map,0.25);
% startpoint = [320 320]./4;
% endpoint = [480 880]./4;
