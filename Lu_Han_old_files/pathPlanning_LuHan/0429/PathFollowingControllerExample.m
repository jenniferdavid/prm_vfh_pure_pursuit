%% Path Following for a Differential Drive Robot
%% Introduction
% This example demonstrates how to control a robot to follow a desired path
% using a Robot Simulator. The example uses the Pure Pursuit path following
% controller to drive a simulated robot along a predetermined path. A desired path is a
% set of waypoints defined explicitly or computed using a path planner (refer to
% <docid:robotics_examples.example-PathPlanningExample>). The Pure Pursuit
% path following controller for a simulated differential drive robot is created and
% computes the control commands to follow a given path. The computed control commands are
% used to drive the simulated robot along the desired trajectory to
% follow the desired path based on the Pure Pursuit controller.

% Copyright 2014-2015 The MathWorks, Inc.
%%
robotRadius = 0.4;
robot = ExampleHelperRobotSimulator('simpleMap',2);
robot.enableLaser(false);
robot.setRobotSize(robotRadius);
robot.showTrajectory(true);

mapInflated = copy(robot.Map);
inflate(mapInflated,robotRadius);
prm = robotics.PRM(mapInflated);
prm.NumNodes = 100;
prm.ConnectionDistance = 10;

%%
% Find a path between the start and end location. Note that the |path| will
% be different due to the probabilistic nature of the PRM algorithm.
startLocation = [2.0 1.0];
endLocation = [12.0 10.0];
path = findpath(prm, startLocation, endLocation)

%%
% Display the path
show(prm, 'Map', 'off', 'Roadmap', 'off');

%%
release(controller);
controller = robotics.PurePursuit
controller.Waypoints = path;
controller.DesiredLinearVelocity = 0.3;
controller.MaxAngularVelocity = 2;
controller.LookaheadDistance = 0.5;

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

%%
% The simulated robot has reached the goal location using the path following
% controller along the desired path. Stop the robot. 
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
