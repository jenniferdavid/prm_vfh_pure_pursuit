function [x,y,tmp] = f_moveUp(x,y,X,Y,Map)
if(y+1<Y)
    up = Map(x,y+1);
    if(up==0)
        x=x;
        y=y+1;
        tmp=true;
    else
        tmp=false;
    end
end