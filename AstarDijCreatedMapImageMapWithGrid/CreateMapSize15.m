
function map = CreateMapSize15
%´´½¨µØÍ¼
map=ones(15,15);
obstacle1=[0 0 0 1 0 0 0;       %7*7
           0 0 1 1 1 0 0;
           0 1 1 1 1 1 0;
           1 1 1 1 1 1 1;
           0 1 1 1 1 1 0;
           0 0 1 1 1 0 0;
           0 0 0 1 0 0 0];
obstacle2=ones(2,2);
subMap=zeros(13,13);
subMap(1:7,2:8)=obstacle1;
subMap(8:9,9:10)=obstacle2;
subMap(4:5,6:7)=obstacle2;
map(2:14,2:14)=subMap;
map = logical(map);

