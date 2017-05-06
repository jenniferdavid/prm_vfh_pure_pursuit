
 function [path, route,numExpanded] = AStarGrid (input_map, start_coords, dest_coords)
% Run A* algorithm on a grid.
% Inputs : 
%   input_map : a logical array where the freespace cells are false or 0 and
%   the obstacles are true or 1
%   start_coords and dest_coords : Coordinates of the start and end cell
%   respectively, the first entry is the row and the second the column.
% Output :
%    route : An array containing the linear indices of the cells along the
%    shortest route from start to dest or an empty array if there is no
%    route. This is a single dimensional vector
%    numExpanded: Remember to also return the total number of nodes
%    expanded during your search. Do not count the goal node as an expanded node. 

% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

cmap = [1 1 1; ...
    0 0 0; ...
    1 0 0; ...
    0 0 1; ...
    0 1 0; ...
    1 1 0; ...
    0.5 0.5 0.5];

colormap(cmap);

% variable to control if the map is being visualized on every
% iteration
drawMapEveryTime = true;

[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;   % Mark free cells
map(~~input_map)  = 2;   % Mark obstacle cells

% Generate linear indices of start and dest nodes
% disp(size(map));
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;

% meshgrid will `replicate grid vectors' nrows and ncols to produce
% a full grid
% type `help meshgrid' in the Matlab command prompt for more information
parent = zeros(nrows,ncols);
% 
[X, Y] = meshgrid (1:ncols, 1:nrows);

xd = dest_coords(1);
yd = dest_coords(2);

% Evaluate Heuristic function, H, for each grid cell启发式函数
% Manhattan distance曼哈顿距离 value from current to destination
H = abs(X - xd) + abs(Y - yd);
H = H';
% Initialize cost arrays
f = Inf(nrows,ncols);
g = Inf(nrows,ncols);

g(start_node) = 0;          %value from start to current
f(start_node) = H(start_node);

% keep track of the number of nodes that are expanded
numExpanded = 0;

% Main Loop

while true
    
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
    
    % make drawMapEveryTime = true if you want to see how the 
    % nodes are expanded on the grid. 
    if (drawMapEveryTime)
        image(1.5, 1.5, map);%column start,row start
        grid on;
        axis image;
        drawnow;
    end
    
    % Find the node with the minimum f value
    [min_f, current] = min(f(:));            
    if ((current == dest_node) || isinf(min_f))
        break;
    end;
    
    % Update input_map
    map(current) = 3;
    f(current) = Inf; % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [row, column] = ind2sub(size(f), current);
    
    % *********************************************************************
    % ALL YOUR CODE BETWEEN THESE LINES OF STARS
    % Visit all of the neighbors around the current node and update the
    % entries in the map, f, g and parent arrays

    %? Whether the node is part of an obstacle
	%If the node is in freespace,
    %? Whether or not it has been visited
    %? Is currently on the list of nodes being considered.

    %上--up
    if(row<nrows+1 && row-1>0 && column>0 && column<ncols+1)
        node=sub2ind(size(map), row-1, column);
        colorup=map(node);
        if(colorup==6)
            g(node)= g(current)+1;
            f(node) =g(node)+ H(node);
            numExpanded = numExpanded+1;
            %当前点的上一个点的父亲是当前点
            parent(nrows*(column-1)+row-1)=nrows*(column-1)+row;
            break;
        %没有走过，且不是障碍物，2=obstacle,3=visited
        elseif(f(node)==Inf && colorup~=2 && colorup~=3)
            g(node)= g(current)+1;
            f(node) =g(node)+ H(node);
            map(node)=4;%on list
            numExpanded = numExpanded+1;   
            %当前点的上一个点的父亲是当前点
            parent(nrows*(column-1)+row-1)=nrows*(column-1)+row;
        end
    end
    %下--dowm
    if(row+1<nrows+1 && row>0 && column>0 && column<ncols+1)
        node=sub2ind(size(map), row+1, column);
        colordown=map(node);
        if(colordown==6)
            g(node)= g(current)+1;
            f(node) =g(node)+ H(node);
            numExpanded = numExpanded+1;   
            %当前点的下一个点的父亲是当前点
            parent(nrows*(column-1)+row+1)=nrows*(column-1)+row;
            break;
        %没有走过，且不是障碍物，2=obstacle,3=visited
        elseif(f(node)==Inf && colordown~=2 && colordown~=3)
            g(node)= g(current)+1;
            f(node) =g(node)+ H(node);
            map(node)=4;%on list
            numExpanded = numExpanded+1;   
            %当前点的下一个点的父亲是当前点
            parent(nrows*(column-1)+row+1)=nrows*(column-1)+row;
        end
    end
    %左--left
    if(row<nrows+1 && row>0 && column-1>0 && column<ncols+1)
        node=sub2ind(size(map), row, column-1);
        colorleft=map(node);
        if(colorleft==6)
            g(node)= g(current)+1;
            f(node) =g(node)+ H(node);
            numExpanded = numExpanded+1;   
            %当前点的右一个点的父亲是当前点
            parent(nrows*(column-1-1)+row)=nrows*(column-1)+row;
            break;
        %没有走过，且不是障碍物，2=obstacle,3=visited
        elseif(f(node)==Inf && colorleft~=2 && colorleft~=3)
            g(node)= g(current)+1;
            f(node) =g(node)+ H(node);
            map(node)=4;%on list
            numExpanded = numExpanded+1;   
            %当前点的右一个点的父亲是当前点
            parent(nrows*(column-1-1)+row)=nrows*(column-1)+row;
        end
    end
    %右--right
    if(row<nrows+1 && row>0 && column>0 && column+1<ncols+1)
        node=sub2ind(size(map), row, column+1);
        colorright=map(node);
        if(colorright==6)
            g(node)= g(current)+1;
            f(node) =g(node)+ H(node);
            numExpanded = numExpanded+1;   
            %当前点的左一个点的父亲是当前点
            parent(nrows*(column-1+1)+row)=nrows*(column-1)+row;
            break;
        %没有走过，且不是障碍物，2=obstacle,3=visited
        elseif(f(node)==Inf && colorright~=2 && colorright~=3)
            g(node)= g(current)+1;
            f(node) =g(node)+ H(node);
            map(node)=4;%on list
            numExpanded = numExpanded+1;   
            %当前点的左一个点的父亲是当前点
            parent(nrows*(column-1+1)+row)=nrows*(column-1)+row;
        end
    end
    
    %*********************************************************************
end

disp('parent');disp(parent);

%% Construct route from start to dest by following the parent links
if (isinf(f(dest_node)))
	route = [];
else
    route = [dest_node];
    parent(start_node)=0;
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end

    % Snippet of code used to visualize the map and the path
    for k = 2:length(route) - 1        
        map(route(k)) = 7;
        pause(0.1);
        image(1.5,1.5, map);%column start,row start
        grid on;
        axis image;
    end
end
% disp('route');disp(route);
[n,pathlength]=size(route);
path=zeros(pathlength,2);
for i=1:pathlength
    if(route(i)~=0)
        path(i)=mod(route(i),nrows);
        path(pathlength+i)=fix(route(i)/nrows)+1;
    end
end

% disp('path'); disp(path);
end
