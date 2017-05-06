function [x,y,tmp] = f_moveRight(x,y,X,Y,Map)
if(x+1<X)
    right = Map(x+1,y);
    if(right==0)
        x=x+1;
        y=y;
        tmp=true;
    else
        tmp=false;
    end
end