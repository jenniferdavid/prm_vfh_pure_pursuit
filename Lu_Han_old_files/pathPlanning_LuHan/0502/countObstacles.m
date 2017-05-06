% caculate the possibality of obstacles
function [countObstacles]=countObstacles(ranges)
    countObstacles=0;
    middleValue = ranges(11);
    if (fix(middleValue) < 5)
        countObstacles = countObstacles + 5;
    end
    
    valueLeft1 = ranges(10);
    valueRight1 = ranges(12);
    if(fix(valueLeft1) < 5 )
        countObstacles = countObstacles + 4;
        if(fix(valueRight1)<5)
            countObstacles = countObstacles + 4;
        else
            countObstacles = countObstacles -3;
        end
    end
    if(fix(valueRight1) < 5 )
        countObstacles = countObstacles + 4;
        if(fix(valueLeft1)<5)
            countObstacles = countObstacles + 4;
        else
            countObstacles = countObstacles -3;
        end
    end
    
    valueLeft2 = ranges(9);
    valueRight2 = ranges(13);
    if(fix(valueLeft2) < 5)
        countObstacles = countObstacles + 3;
        if(fix(valueRight2)<5)
            countObstacles = countObstacles + 3;
        else
            countObstacles = countObstacles -2;
        end
    end
    if(fix(valueRight2) < 5)
        countObstacles = countObstacles + 3;
        if(fix(valueLeft2)<5)
            countObstacles = countObstacles + 3;
        else
            countObstacles = countObstacles -2;
        end
    end
    
    valueLeft3 = ranges(8);
    valueRight3 = ranges(14);
    if(fix(valueLeft3) < 5)
        countObstacles = countObstacles + 2;
        if(fix(valueRight3)<5)
            countObstacles = countObstacles + 2;
        else
            countObstacles = countObstacles -1;
        end
    end
    if(fix(valueRight3) < 5)
        countObstacles = countObstacles + 2;
        if(fix(valueLeft3)<5)
            countObstacles = countObstacles + 2;
        else
            countObstacles = countObstacles -1;
        end
    end
    
    valueLeft4 = ranges(7);
    valueRight4 = ranges(15);
    if(fix(valueLeft4) < 5)
        countObstacles = countObstacles + 1;
        if(fix(valueRight4)<5)
            countObstacles = countObstacles + 1;
        end
    end
    if(fix(valueRight4) < 5)
        countObstacles = countObstacles + 1;
        if(fix(valueLeft4)<5)
            countObstacles = countObstacles + 1;
        end
    end
    % disp countObstacles
    countObstacles
end
