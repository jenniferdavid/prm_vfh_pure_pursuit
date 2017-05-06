
robot1 = RobotSimulatorWithMyMap('MapSize151',1);

robotRadius = 0.1;
robot1.enableLaser(true);
robot1.setRobotSize(robotRadius);
robot1.showTrajectory(true);

controller = robotics.PurePursuit;         %纯追踪模型方法
controller.DesiredLinearVelocity = 0.3;
controller.MaxAngularVelocity = 2;
controller.LookaheadDistance = 0.5;
controlRate = robotics.Rate(10);

mapInflated = copy(robot1.Map);
% inflate(mapInflated,1,'grid')
%inflate(mapInflated,robotRadius);
show(mapInflated);
%%
prm = robotics.PRM;
prm.Map = mapInflated; 
% prm.NumNodes = round(Size(1)*Size(2)/2);
% prm.ConnectionDistance = round(Size(1)*Size(2)/50);
prm.NumNodes = 100;
prm.ConnectionDistance = 5;
show(prm);
startLocation = [3 3];
endLocation = [12 12];
%path = findpath(prm, startLocation, endLocation)
path = [    3.0000    3.0000;
    3.6164    2.7648;
    5.6852    4.4089;
    7.9804    6.2904;
    9.7553    8.2746;
   12.6120   11.6767;
   12.0000   12.0000];
%%
% Display the path

show(prm, 'Map', 'off', 'Roadmap', 'off');

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
robot1.setRobotPose(robotCurrentPose);

distanceToGoal = norm(robotCurrentLocation - robotGoal);
goalRadius = 0.1;

%%
% Drive the robot using the controller output on the given map until it
% reaches the goal. The controller runs at 10 Hz.
reset(controlRate);
while( distanceToGoal > goalRadius )   
    % Compute the controller outputs, i.e., the inputs to the robot
    [v, omega] = step(controller, robot1.getRobotPose);
    % Simulate the robot using the controller outputs
    drive(robot1, v, omega);  
    % Extract current location information from the current pose
    robotCurrentPose = robot1.getRobotPose();     
    % Re-compute the distance to the goal
    distanceToGoal = norm(robotCurrentPose(1:2) - robotGoal);
    waitfor(controlRate);
end

drive(robot1, 0, 0);

displayEndOfDemoMessage(mfilename)
