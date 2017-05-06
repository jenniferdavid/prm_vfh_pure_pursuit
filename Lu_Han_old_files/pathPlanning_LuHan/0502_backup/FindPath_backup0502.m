
robot = RobSimulatorWithMyMap('MapSize15',1);
robotRadius = 0.4;
robot.enableLaser(true);
robot.setRobotSize(robotRadius);
robot.showTrajectory(false);

mapInflated = copy(robot.Map);
%inflate(mapInflated,robotRadius);
prm = robotics.PRM(mapInflated);
prm.NumNodes = 50;
prm.ConnectionDistance = 5;
startLocation = [3.0 3.0];
endLocation = [12.0 12.0];
path = findpath(prm, startLocation, endLocation)
drive(robot, 0, 0);
delete(robot);
% Display the path
show(prm, 'Map', 'on', 'Roadmap', 'on')

PathFollowing(path);
