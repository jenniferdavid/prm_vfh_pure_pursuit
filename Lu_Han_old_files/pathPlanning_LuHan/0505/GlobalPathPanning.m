
%% small smart home map
imageOriginal=imread('SmartHome_small.png');
imageTransfered=imageOriginal(:,:,1);
Map = logical((255-imageTransfered)/255);
MapInflated = Map;
robotRadius = 1;
[X Y] = size(Map);
for i = robotRadius+1:X-robotRadius
    for j = robotRadius+1:Y-robotRadius
        if(Map(i,j)==1)
            if(Map(i+1,j+1)==0)
                MapInflated(i+1,j+1)=1;
            elseif(Map(i+1,j-1)==0)
                MapInflated(i+1,j-1)=1;
            elseif(Map(i-1,j+1)==0)
                MapInflated(i-1,j+1)=1;
            elseif(Map(i-1,j-1)==0)
                MapInflated(i-1,j-1)=1;
            end
        end
    end
end
                
startpoint = [60 60];
endpoint = [80 60];
AStarGrid(Map, startpoint, endpoint);
figure
AStarGrid(MapInflated, startpoint, endpoint);

