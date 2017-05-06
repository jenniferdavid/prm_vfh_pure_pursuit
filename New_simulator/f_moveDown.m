function [x,y,tmp] = f_moveDown(x,y,X,Y,Map)
if(y-1>0)
    down = Map(x,y-1);
    if(down==0)
        x=x;
        y=y-1;
        tmp=true;
    else
        tmp=false;
    end
end