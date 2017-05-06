%%
%´´½¨µØÍ¼
%LogicalMap = CreateLogicalMap();
LogicalMap = CreateLogicalMap(10,10);
map = robotics.BinaryOccupancyGrid(LogicalMap,2);
robotRadius = 0.001;
inflate(map,robotRadius);
show(map);
%%
prm = robotics.PRM
prm.Map = map;
prm.NumNodes = 50;
prm.ConnectionDistance = 5;
startLocation = [2 1];
endLocation = [12 10];
path = findpath(prm, startLocation, endLocation);
show(prm)

