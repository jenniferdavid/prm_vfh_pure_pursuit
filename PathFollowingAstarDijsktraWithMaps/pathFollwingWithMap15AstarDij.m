%% Using the path following controller along with PRM
% If the desired set of waypoints are computed by a path planner, the path
% following controller can be used in the same fashion.

% Start Robot Simulator with a simple map
robot = RobotSimulatorWithMyMaps('MapSize15',1);
robotRadius = 0.1;
robot.enableLaser(false);
robot.setRobotSize(robotRadius);
robot.showTrajectory(true);
%%
controller = robotics.PurePursuit;
controller.DesiredLinearVelocity = 0.3;
controller.MaxAngularVelocity = 2;
controller.LookaheadDistance = 0.5;
controlRate = robotics.Rate(10);

mapInflated = copy(robot.Map);%binaryoccupancyGrid
%inflate(mapInflated,robotRadius);
allMaps = load('Maps.mat');
originalMap = getOccupancy(mapInflated,allMaps.array15x15,'grid');%map is 225x1
midMap=zeros(15,15);%N-by-N array
for i=1:15
    for j=1:15
      midMap((i-1)*15+j)=originalMap((i-1)*15+j);       
    end
end
startLocation = [3 3];
endLocation = [7 9];
finalMap=midMap.';
% show(finalMap);
% figure;
[~, route, numExpanded] = AStarGrid (finalMap, startLocation, endLocation);

[n,pathlength]=size(route);
path=zeros(pathlength,2);
for i=1:pathlength
    if(route(i)~=0)
        path(i)=fix(route(i)/15)+1; 
        path(pathlength+i)=mod(route(i),15);
    end
end
disp('path for robot');disp(path);
%%
% You defined a path following controller above which you can re-use
% for computing the control commands of a robot on this map. To
% re-use the controller and redefine the waypoints while keeping the other
% information the same, use the |<docid:robotics_ref.buopqdc-1 release>| function.
release(controller);
controller.Waypoints = path;

%%
% Set current location and the goal of the robot as defined by the path
robotCurrentLocation = path(1,:);
robotGoal = path(end,:);
initialOrientation = 0;
robotCurrentPose = [robotCurrentLocation initialOrientation];
robot.setRobotPose(robotCurrentPose);

distanceToGoal = norm(robotCurrentLocation - robotGoal);
goalRadius = 0.1;

%%
% Drive the robot using the controller output on the given map until it
% reaches the goal. The controller runs at 10 Hz.
reset(controlRate);
while( distanceToGoal > goalRadius ) 
    % Compute the controller outputs, i.e., the inputs to the robot
    %disp(robot.getRobotPose);
    [v, omega] = step(controller, robot.getRobotPose);
    % Simulate the robot using the controller outputs
    drive(robot, v, omega);  
    % Extract current location information from the current pose
    robotCurrentPose = robot.getRobotPose(); 
    % Re-compute the distance to the goal
    distanceToGoal = norm(robotCurrentPose(1:2) - robotGoal);
    waitfor(controlRate);
end

drive(robot, 0, 0);
disp('wozaizheli');

%% Next Steps
%
% * Refer to the Path Planning example: <docid:robotics_examples.example-PathPlanningExample>
% * Refer to the Mapping example:
% <docid:robotics_examples.example-MapUpdateUsingSensorDataExample>

displayEndOfDemoMessage(mfilename);
disp('conglaimeiyou');
