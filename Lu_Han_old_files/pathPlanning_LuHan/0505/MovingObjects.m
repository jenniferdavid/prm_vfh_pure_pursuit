
%% small smart home map
imageOriginal=imread('SmartHome_small.png');
imageTransfered=imageOriginal(:,:,1);
Map = logical((255-imageTransfered)/255);
MapInflated = Map;
robotRadius = 1;
[X Y] = size(Map);

randomx = randperm(X);
randomy = randperm(Y);
for i=2:min(X,Y)
    if((randomx(i)+1<X)&&(randomx(i)-1>0)&&(randomy(i)+1<Y)&&(randomy(i)-1>0))
        middle = Map(randomx(i),randomy(i));
        left = Map(randomx(i)-1,randomy(i));
        right = Map(randomx(i)+1,randomy(i));
        up = Map(randomx(i),randomy(i)-1);
        down = Map(randomx(i),randomy(i)+1);
        if((middle==0)&&(left==0)&&(right==0)&&(up==0)&&(down==0))
            x = randomx(i);
            y = randomy(i);
        end
    end
end

while true
    move = randperm(4);
    [~,~,tmpLeft] = f_moveLeft(x,y,X,Y,Map);
    [~,~,tmpRight] = f_moveRight(x,y,X,Y,Map);
    [~,~,tmpUp] = f_moveUp(x,y,X,Y,Map);
    [~,~,tmpDown] = f_moveDown(x,y,X,Y,Map);
    if(move(1)==1 && tmpLeft==true)
        [x,y] = f_moveLeft(x,y,X,Y,Map);
    elseif(move(1)==2 && tmpRight==true)
        [x,y] = f_moveRight(x,y,X,Y,Map);
    elseif(move(1)==3 && tmpUp==true)
        [x,y] = f_moveUp(x,y,X,Y,Map);
    elseif(move(1)==4 && tmpDown==true)
        [x,y] = f_moveDown(x,y,X,Y,Map);
    end
    pos = [x,y,2,2];
	rectangle('Position',pos,'Curvature',[1 1],'FaceColor',[1 0 0]);
    drawnow;
    axis equal;
end
        