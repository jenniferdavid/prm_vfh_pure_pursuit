
robot = RobSimulatorWithMyMap('MapSize50',1);
robotRadius = 1;
robot.enableLaser(true);
robot.setRobotSize(robotRadius);
robot.showTrajectory(false);

mapInflated = copy(robot.Map);
inflate(mapInflated,robotRadius);
prm = robotics.PRM(mapInflated);
prm.NumNodes = 200;
prm.ConnectionDistance = 8;
startLocation = [5 5];
endLocation = [30 40];
path = findpath(prm, startLocation, endLocation)

drive(robot, 0, 0);
delete(robot);
% Display the path
show(prm, 'Map', 'on', 'Roadmap', 'on');

PathFollowing(path);
