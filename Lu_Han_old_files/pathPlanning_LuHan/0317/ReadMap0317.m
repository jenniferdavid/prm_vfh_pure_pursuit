%%
%创建地图
Map = CreateMap();
% AA=imread('map3.png');
% A=AA(:,:,1);
% Map = (255-A)/255;
map = robotics.BinaryOccupancyGrid(Map); 
robotRadius = 1;
inflate(map,robotRadius);
show(map);
%%
[row, col]=find(Map==0);
sumzeroes=size(row,1);

%可以求数组value里0的个数
random = randperm(sumzeroes);      
%%
r1=row(random(1));
c1=col(random(2));
r2=row(random(3));
c2=col(random(4));
startpoint = [ r1 c1];
endpoint = [r2 c2];
%%
prm = robotics.PRM;
prm.Map = map;                             
prm.NumNodes = 300;
prm.ConnectionDistance = 10;
%startLocation = [620 200];
%endLocation = [1049 200];
%path = findpath(prm, startLocation, endLocation); 
path = findpath(prm, startpoint, endpoint); 
show(prm);

