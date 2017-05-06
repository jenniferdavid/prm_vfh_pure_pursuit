%% Minimum of |sin|
% Find the point where the $\sin(x)$ function takes its minimum in the range
% $0< x< 2\pi$.
fun = @sin;
x1 = 0;
x2 = 2*pi;
x = fminbnd(fun,x1,x2)
%%
% To display precision, this is the same as the correct value $x = 3\pi/2$.
3*pi/2