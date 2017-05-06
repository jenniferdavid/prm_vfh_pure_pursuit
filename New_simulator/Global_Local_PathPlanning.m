clear all; close all;
%% small smart home map
imageOriginal=imread('SmartHome_small.png');
imageTransfered=imageOriginal(:,:,1);
Map = logical((255-imageTransfered)/255);
MapInflated = MapInflate(Map, 2);
       
startpoint = [30 30];
endpoint = [80 60];

figure(1); subplot(2,1,1);
[route,numExpanded] = AStarGrid(MapInflated, startpoint, endpoint);
% AStarGrid(Map, startpoint, endpoint);
%%
[PathY , PathX] = ind2sub(size(Map),route);
subplot(2,1,2);
image(imageOriginal); hold on; plot(PathX,PathY, 'r-', 'LineWidth',4) %
axis image;

S_path = Spline_Smooth(PathX, PathY, 0.1);
x = S_path(1,:);
y = S_path(2,:);
plot(x,y,'k.-', 'LineWidth',1);
%%
Obj1_pos = [50, 10;50,45;60,50]';
t = 0:2;tq = min(t):0.05:max(t);
x_Obj1 = interp1(t,Obj1_pos(2,:),tq,'spline');
y_Obj1 = interp1(t,Obj1_pos(1,:),tq,'spline');
plot(x_Obj1,y_Obj1,'g.-', 'LineWidth',1);
%%

L = size(S_path); c = [0,0]; 
theta = -pi/2:0.1:pi/2; rho = 5*ones(1,length(theta)); [xx,yy] = pol2cart(theta,rho);
rho2 = 15*ones(1,length(theta)); [xx2,yy2] = pol2cart(theta,rho2);
i = 2; k =2; Robot_Pos = startpoint; Sl = 1;
while sqrt((Robot_Pos(1)-endpoint(1))^2+(Robot_Pos(2)-endpoint(2))^2)> 0.3

    tic
    image(imageOriginal);plot(PathX,PathY, 'r-', 'LineWidth',4);plot(x,y,'k.-', 'LineWidth',1);
    axis image;
    
    pos_Obj1 = [x_Obj1(k)-1.5,y_Obj1(k)-1.5,3,3];
	rectangle('Position',pos_Obj1,'Curvature',[1 1],'FaceColor',[0 0 1]);
    
    heading(i) = atan(abs(y(i)-y(i-1))/abs(x(i)-x(i-1)));
    [th,rh] =cart2pol(abs(x(i)-x_Obj1(k)),abs(y(i)-y_Obj1(k)));
    Infront = heading(i)-th;
    
    if (sqrt((x(i)-x_Obj1(k))^2+(y(i)-y_Obj1(k))^2) > 15) || (Infront<0) 
        
        pos = [x(i)-1.5,y(i)-1.5,3,3];
        rectangle('Position',pos,'Curvature',[1 1],'FaceColor',[1 0 0]);
        heading(i) = atan(abs(y(i)-y(i-1))/abs(x(i)-x(i-1)));
        theta = (-pi/2)+heading(i):0.1:pi/2+heading(i); rho = 5*ones(1,length(theta)); [xx,yy] = pol2cart(theta,rho);
        rho2 = 15*ones(1,length(theta)); [xx2,yy2] = pol2cart(theta,rho2);
        for j=1:length(rho)
            plot([x(i), x(i)+xx2(j)],[y(i),y(i)+yy2(j)], 'g'); hold on;
            plot([x(i), x(i)+xx(j)],[y(i),y(i)+yy(j)], 'b'); hold on;
        end
        i = i+1;
        Sl = 1;
    else
        if Sl ~=4 
            m(1) = (x(i+1)-x(i))/4;
            m(2) = (y(i+1)-y(i))/4;
        end
        
        
        Slow_x = x(i)+Sl*m(1);
        Slow_y = y(i)+Sl*m(2);
        
        pos = [Slow_x-1.5,Slow_y-1.5,3,3];
        rectangle('Position',pos,'Curvature',[1 1],'FaceColor',[1 0 0]);
        heading(i) = atan(abs(Slow_y-y(i-1))/abs((Slow_x)-x(i-1)));
        theta = (-pi/2)+heading(i):0.1:pi/2+heading(i); rho = 5*ones(1,length(theta)); [xx,yy] = pol2cart(theta,rho);
        rho2 = 15*ones(1,length(theta)); [xx2,yy2] = pol2cart(theta,rho2);
        for j=1:length(rho)
            plot([Slow_x, Slow_x+xx2(j)],[Slow_y,Slow_y+yy2(j)], 'r'); hold on;
            plot([Slow_x, Slow_x+xx(j)],[Slow_y,Slow_y+yy(j)], 'b'); hold on;
        end
        [th,rh] =cart2pol(abs(Slow_x-x_Obj1(k)),abs(Slow_y-y_Obj1(k)));
        Infront = heading(i)-th;
        if Sl<4
            Sl = Sl+1;
        else
            i = i+1;
            Sl = 1;
        end
       
    end
    
    

    
    
%     if mod(i,2) ~=0
%         c(1) = toc;
%     else
%         c(2) = toc;
%     end
%     delta_t(i) = abs(c(2)-c(1));
%     dx(i) = sqrt((x(i)-x(i-1))^2+(y(i)-y(i-1))^2);
%     pause((dx(i)/10)-delta_t(i));
%     dt = toc;
%     Speed(i) = dx(i)/dt;
    Robot_Pos = [x(i) y(i)];
    if k<length(x_Obj1)
        k = k+1;
    end
    drawnow;
end

disp('End')

