AA=imread('map3.png');
A=AA(:,:,1);
Map = (255-A)/255;
map = robotics.BinaryOccupancyGrid(Map,1);
robotRadius = 5;
%inflate(map,robotRadius);
OBSTACLE=10;

%%
randompoint=false;
Xrange=size(Map,2); %cloumn ,x                 
Yrange=size(Map,1); %row    ,y    

obs_num=0;
while (obs_num<OBSTACLE)
    randomobsx = randperm(Xrange);            
    randomobsy = randperm(Yrange); 
    %returns an array of occupancy values based on a [rows cols]input array of grid positions, ij
    % x = column, y = row
    obstacle=getOccupancy(map,[randomobsy(1) randomobsx(1) ],'grid');%row,column
    if(obstacle==0)
        x=randomobsx(1):randomobsx(1)+round(sum(sum(A==255))/10000);
        y=Yrange-randomobsy(1):Yrange-randomobsy(1)+round(sum(sum(A==255))/10000);
        [X,Y] = meshgrid(x,y);
        %[x,y] = meshgrid(2:5);
        setOccupancy(map,[X(:) Y(:)],1);
 
        obstaclepoint = [randomobsx(1) Yrange-randomobsy(1)];       %x,y 不是row cloumn
        disp('obstaclepoint'); disp(obstaclepoint);
        obs_num=obs_num+1;
    end
end

%%
while (randompoint==false)
    randomx = randperm(Xrange);            
    randomy = randperm(Yrange); 
    %returns an array of occupancy values based on a [rows cols]input array of grid positions, ij
    % x = column, y = row
    start=getOccupancy(map,[randomy(1) randomx(1) ],'grid');%row,cloumn
    goal=getOccupancy(map,[randomy(2) randomx(2) ],'grid'); %row,cloumn
    if(start==0 && goal==0);
        randompoint=true;
    end
end

%%
startpoint = [randomx(1) Yrange-randomy(1)];       %x,y 不是row cloumn
disp('startpoint'); disp(startpoint);
endpoint = [randomx(2) Yrange-randomy(2)];         %x,y 不是row cloumn
disp('endpoint');disp(endpoint);
show(map);
prm = robotics.PRM;
prm.Map = map;                                
prm.NumNodes = round(sum(sum(A==255))/300);
prm.ConnectionDistance = (668*1040/sum(sum(A==255)))*10;
%startLocation = [620 200];
%endLocation = [1049 200];
path = findpath(prm, startpoint, endpoint); 
show(prm);
hold on;
plot(randomx(1), Yrange-randomy(1),'gs',...
    'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','r');
plot(randomx(2), Yrange-randomy(2),'gs',...
    'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','m');
