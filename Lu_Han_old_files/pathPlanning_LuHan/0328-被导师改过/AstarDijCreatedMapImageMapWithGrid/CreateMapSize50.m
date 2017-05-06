
function map = CreateMapSize50
%´´½¨µØÍ¼
map=ones(50,50);
obstacle1=[0 0 0 1 0 0 0;       %7*7
           0 0 1 1 1 0 0;
           0 1 1 1 1 1 0;
           1 1 1 1 1 1 1;
           0 1 1 1 1 1 0;
           0 0 1 1 1 0 0;
           0 0 0 1 0 0 0];
obstacle2=ones(5,5);
obstacle3=ones(15,15);
subMap=zeros(46,46);
subMap(1:7,2:8)=obstacle1;
subMap(20:26,9:15)=obstacle1;
subMap(40:44,15:19)=obstacle2;
subMap(15:29,20:34)=obstacle3;
map(3:48,3:48)=subMap;
map = logical(map);

