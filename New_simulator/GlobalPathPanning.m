clear all; close all;
%% small smart home map
imageOriginal=imread('SmartHome_small.png');
imageTransfered=imageOriginal(:,:,1);
Map = logical((255-imageTransfered)/255);
MapInflated = MapInflate(Map, 2);
       
startpoint = [55 70];
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
L = size(S_path);
for i=1:L(2)
    image(imageOriginal);plot(PathX,PathY, 'r-', 'LineWidth',4);plot(x,y,'k.-', 'LineWidth',1);
    axis image;
    pos = [x(i)-1.5,y(i)-1.5,3,3];
	rectangle('Position',pos,'Curvature',[1 1],'FaceColor',[1 0 0]);
    drawnow;
end




