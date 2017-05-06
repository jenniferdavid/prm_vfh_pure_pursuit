robot = RobotSimulatorWithMyMap('MapSize151',1);
robotRadius = 0.1;
robot.enableLaser(true);
robot.setRobotSize(robotRadius);
robot.showTrajectory(true);

controller = robotics.PurePursuit;
controller.DesiredLinearVelocity = 0.3;
controller.MaxAngularVelocity = 2;
controller.LookaheadDistance = 0.5;
controlRate = robotics.Rate(10);

mapInflated = copy(robot.Map);
%inflate(mapInflated,robotRadius);
show(mapInflated);

prm = robotics.PRM;
prm.Map = mapInflated; 
prm.NumNodes = 100;
prm.ConnectionDistance = 5;
show(prm);

startLocation = [3 3];
endLocation = [12 12];
%path = findpath(prm, startLocation, endLocation)
path = [ 3.0000 3.0000;3.6164 2.7648;5.6852 4.4089;7.9804    6.2904;...
        9.7553    8.2746;12.6120   11.6767; 12.0000   12.0000];
show(prm, 'Map', 'off', 'Roadmap', 'off');

release(controller);
controller.Waypoints = path;

robotCurrentLocation = path(1,:);
robotGoal = path(end,:);
initialOrientation = 0;
robotCurrentPose = [robotCurrentLocation initialOrientation];
robot.setRobotPose(robotCurrentPose);
%norm矢量和矩阵规范,就是求出了当前位置距离终点的距离
distanceToGoal = norm(robotCurrentLocation - robotGoal);
goalRadius = 0.1;

% calculate a steering direction based on input laser scan data.
vfh = robotics.VectorFieldHistogram;
ranges = 10*ones(1, 500);
ranges(1, 225:275) = 1.0;
angles = linspace(-pi, pi, 500);
targetDir = 0;

reset(controlRate);
while( distanceToGoal > goalRadius )   
    % Compute the controller outputs, i.e., the inputs to the robot
    [v, omega] = step(controller, robot.getRobotPose);
    % Compute obstacle-free steering direction
    steeringDir = step(vfh, ranges, angles, targetDir)
    % Simulate the robot using the controller outputs
    drive(robot, v, omega);  
    % Extract current location information from the current pose
    robotCurrentPose = robot.getRobotPose();   
    % Re-compute the distance to the goal，1:2的意思是矩阵的前两个元素，没有角度
    distanceToGoal = norm(robotCurrentPose(1:2) - robotGoal);
    waitfor(controlRate);
end
%让机器人停下来

drive(robot, 0, 0);
delete(robot);

displayEndOfDemoMessage(mfilename);