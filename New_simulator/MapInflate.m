function MapInflated = MapInflate(Map, robotRadius)
    MapInflated = Map;
    [X Y] = size(Map);
    for k=1:robotRadius
        for i = robotRadius+1:X-robotRadius
            for j = robotRadius+1:Y-robotRadius
                if(Map(i,j)==1)
                    if(Map(i+k,j+k)==0)
                        MapInflated(i+k,j+k)=1;
                    end
                    if(Map(i+k,j-k)==0)
                        MapInflated(i+k,j-k)=1;
                    end
                    if(Map(i-k,j+k)==0)
                        MapInflated(i-k,j+k)=1;
                    end
                    if(Map(i-k,j-k)==0)
                        MapInflated(i-k,j-k)=1;
                    end
                end
            end
        end
    end
end