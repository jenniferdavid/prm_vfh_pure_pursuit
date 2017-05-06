
%% Using the Path Following Controller Along with PRM
% If the desired set of waypoints are computed by a path planner, the path
% following controller can be used in the same fashion.
% Start Robot Simulator with a simple map
robot = ExampleHelperRobotSimulator('simpleMap',1);
robot.enableLaser(true);
robot.setRobotSize(robotRadius);
robot.showTrajectory(true);
robotRadius = 0.4;
robot.setRobotPose(robotCurrentPose);

controller.DesiredLinearVelocity = 0.3;
controller.MaxAngularVelocity = 2;
controller.LookaheadDistance = 0.5;

%%
% You can compute the |path| using the PRM path planning algorithm. See
% <docid:robotics_examples.example-PathPlanningExample> for details.

mapInflated = copy(robot.Map);
inflate(mapInflated,robotRadius);
prm = robotics.PRM(mapInflated);
prm.NumNodes = 100;
prm.ConnectionDistance = 10;

%%
% Find a path between the start and end location. Note that the |path| will
% be different due to the probabilistic nature of the PRM algorithm.
startLocation = [4.0 2.0];
endLocation = [24.0 20.0];
path = findpath(prm, startLocation, endLocation)

% Display the path
show(prm, 'Map', 'on', 'Roadmap', 'on')

release(controller);
controller.Waypoints = path;

robotCurrentLocation = path(1,:);
robotGoal = path(end,:);
initialOrientation = 0;
robotCurrentPose = [robotCurrentLocation initialOrientation];
robot.setRobotPose(robotCurrentPose);
distanceToGoal = norm(robotCurrentLocation - robotGoal);
goalRadius = 0.1;
reset(controlRate);
while( distanceToGoal > goalRadius )   
    % Compute the controller outputs, i.e., the inputs to the robot
    [v, omega] = controller(robot.getRobotPose);   
    % Simulate the robot using the controller outputs
    drive(robot, v, omega);   
    % Extract current location information from the current pose
    robotCurrentPose = robot.getRobotPose;   
    % Re-compute the distance to the goal
    distanceToGoal = norm(robotCurrentPose(1:2) - robotGoal);  
    waitfor(controlRate);
end

%%
% The simulated robot has reached the goal location using the path following
% controller along the desired path. Stop the robot.
drive(robot, 0, 0);
delete(robot);
%% See Also
displayEndOfDemoMessage(mfilename)
