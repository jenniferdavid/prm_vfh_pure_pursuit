function S_path= Spline_Smooth(PathX, PathY, n)

k = 1;
for i=1:20:length(PathX)
   x(k) = PathX(i);
   y(k) = PathY(i);
   k = k+1;
end
% plot(x,y,'k-', 'LineWidth',2)
t = 0:length(x)-1;
tq = min(t):n:max(t);
xq = interp1(t,x,tq,'spline');
yq = interp1(t,y,tq,'spline');

S_path =[xq;yq];