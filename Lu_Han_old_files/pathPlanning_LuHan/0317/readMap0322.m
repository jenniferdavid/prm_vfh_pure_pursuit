AA=imread('map3.png');
A=AA(:,:,1);
Map = (255-A)/255;
map = robotics.BinaryOccupancyGrid(Map,1);
robotRadius = 5;
inflate(map,robotRadius);

%%
randompoint=false;
Xrange=size(Map,2); %cloumn ,x         
Yrange=size(Map,1); %row    ,y    
while (randompoint==false)
    randomx = randperm(Xrange);            
    randomy = randperm(Yrange); 
    %returns an array of occupancy values based on a [rows cols]input array of grid positions, ij
    start=getOccupancy(map,[randomy(1) randomx(1) ],'grid');%row,cloumn
    goal=getOccupancy(map,[randomy(2) randomx(2) ],'grid'); %row,cloumn
    if(start==0 && goal==0);
        randompoint=true;
    end
end

startpoint = [randomx(1) Yrange-randomy(1)];disp(startpoint);  %x,y 不是row cloumn
endpoint = [randomx(2) Yrange-randomy(2)];disp(endpoint);      %x,y 不是row cloumn
prm = robotics.PRM;
prm.Map = map;                                
prm.NumNodes = round(sum(sum(A==255))/300);
prm.ConnectionDistance = (668*1040/sum(sum(A==255)))*10;
%startLocation = [620 200];
%endLocation = [1049 200];
path = findpath(prm, startpoint, endpoint); 
show(prm);
