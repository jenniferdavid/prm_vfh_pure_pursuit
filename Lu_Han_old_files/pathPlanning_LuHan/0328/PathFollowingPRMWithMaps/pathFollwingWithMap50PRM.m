
% Using the path following controller along with PRM
robot = RobotSimulatorWithMyMaps('MapSize50',1);

Size=robot.Map.GridSize;
disp(Size(1));disp(Size(2));

robotRadius = 1;
robot.enableLaser(true);
robot.setRobotSize(robotRadius);
robot.showTrajectory(true);

controller = robotics.PurePursuit;
controller.DesiredLinearVelocity = 2*robotRadius;
controller.MaxAngularVelocity = 2;
controller.LookaheadDistance = 2*robotRadius;
controlRate = robotics.Rate(10);

mapInflated = copy(robot.Map);
inflate(mapInflated,robotRadius);

prm = robotics.PRM;
prm.Map = mapInflated; 
prm.NumNodes = 200;
prm.ConnectionDistance = 10;
show(prm);
% startLocation = [200 400];
% endLocation = [520 500];
startLocation = [5 5];
endLocation = [45 45];
path = findpath(prm, startLocation, endLocation)

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
robot.setRobotPose(robotCurrentPose);

distanceToGoal = norm(robotCurrentLocation - robotGoal);
goalRadius = 0.1;

%%
% Drive the robot using the controller output on the given map until it
% reaches the goal. The controller runs at 10 Hz.
reset(controlRate);
while( distanceToGoal > goalRadius )   
    % Compute the controller outputs, i.e., the inputs to the robot
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

%%
% <<path_completed_path_part2.png>>
%
%%
% Close Simulation.
delete(robot);
%% Next Steps
%
% * Refer to the Path Planning example: <docid:robotics_examples.example-PathPlanningExample>
% * Refer to the Mapping example:
% <docid:robotics_examples.example-MapUpdateUsingSensorDataExample>

displayEndOfDemoMessage(mfilename)
