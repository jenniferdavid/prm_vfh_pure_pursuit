function [x,y,tmp] = f_moveLeft(x,y,X,Y,Map)
if(x-1>0)
    left = Map(x-1,y);
    if(left==0)
        x=x-1;
        y=y;
        tmp=true;
    else
        tmp=false;
    end
end