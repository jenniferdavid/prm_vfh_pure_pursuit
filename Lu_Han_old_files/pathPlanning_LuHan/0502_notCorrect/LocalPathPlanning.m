function PathFollowing(path)

robot = RobSimulatorWithMyMap('MapSize502',1); 
% The size of example map is 12-by-12, here I use 50-by-50, 
% so extands all values to 4 times
robotRadius = 1;
robot.enableLaser(true);
robot.setRobotSize(robotRadius);
% show path robot has ran 机器人走过的路线
robot.showTrajectory(true);
controller = robotics.PurePursuit;         
controller.DesiredLinearVelocity = 1;
controller.MaxAngularVelocity = 10; %radians/second
controller.LookaheadDistance = 5;
controlRate = robotics.Rate(10);
%show(prm, 'Map', 'on', 'Roadmap', 'on')
release(controller);
controller.Waypoints = path;
% Set current location and the goal of the robot as defined by the path
robotCurrentLocation = path(1,:);
robotGoal = path(end,:);
initialOrientation = 0;
robotCurrentPose = [robotCurrentLocation initialOrientation];
robot.setRobotPose(robotCurrentPose);
distanceToGoal = norm(robotCurrentLocation - robotGoal);
goalRadius = 0.5;


%%
reset(controlRate);
while( distanceToGoal > goalRadius )   
    % Compute the controller outputs, i.e., the inputs to the robot
    [v, omega] = step(controller, robot.getRobotPose);
    [ranges, ~] = getRangeData(robot);
    drive(robot, v, omega);  
    robotCurrentPose = robot.getRobotPose(); 
    distanceToGoal = norm(robotCurrentPose(1:2) - robotGoal);
    waitfor(controlRate);
    if(ranges(11)<5.0)
        path = GlobalPathPlanning(robotCurrentLocation,robotGoal);
        controller.Waypoints = path;
    end
  
end %while

drive(robot, 0, 0);
delete(robot);
 