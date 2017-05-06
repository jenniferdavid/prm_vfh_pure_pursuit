%% Plot Graph of Nodes Using Asterisks
% Plot half of a "Bucky ball" carbon molecule, placing asterisks at each
% node.

% Copyright 2015 The MathWorks, Inc.

k = 1:30;
[B,XY] = bucky;
gplot(B(k,k),XY(k,:),'-*')
axis square
