function PathFollowing(path)

robot = RobSimulatorWithMyMap('MapSize502',1); 
robotRadius = 1;
robot.enableLaser(true);
robot.setRobotSize(robotRadius);
% show path robot has ran 机器人走过的路线
robot.showTrajectory(true);
controller = robotics.PurePursuit;         
controller.DesiredLinearVelocity = 0.3;
controller.MaxAngularVelocity = 2;
controller.LookaheadDistance = 0.5;
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
goalRadius = 0.1;

vfh = robotics.VectorFieldHistogram;
targetDir = 0;
%%
% Drive the robot using the controller output on the given map until it
% reaches the goal. The controller runs at 10 Hz.
reset(controlRate);
while( distanceToGoal > goalRadius )   
    % Compute the controller outputs, i.e., the inputs to the robot
    [v, omega] = step(controller, robot.getRobotPose);
    [ranges, angles] = getRangeData(robot);
    value = countObstacles(ranges);
    while( value > 10)    
         ranges = double(ranges);
         angles = double(angles);	
        % Call VFH object to computer steering direction
        steerDir = vfh(ranges, angles, targetDir)   
        % Calculate velocities
        if ~isnan(steerDir) % If steering direction is valid
            v = 0.2;
            % why the caculated omega is always 0   ????????
            omega = exampleHelperComputeAngularVelocity(steerDir, 1)
        else % Stop and search for valid direction
            v = 0.0;
            omega = 0.5;
        end
        drive(robot, v, omega);
        robotCurrentPose = robot.getRobotPose();
        distanceToGoal = norm(robotCurrentPose(1:2) - robotGoal);
        if(distanceToGoal < goalRadius)
            break;
        end
        waitfor(controlRate);  
        [ranges, angles] = getRangeData(robot); 
        value = countObstacles(ranges);
    end    %while
    % Simulate the robot using the controller outputs
    drive(robot, v, omega);  
    % Extract current location information from the current pose
    robotCurrentPose = robot.getRobotPose();     
    % Re-compute the distance to the goal
    distanceToGoal = norm(robotCurrentPose(1:2) - robotGoal);
    waitfor(controlRate);
    
end %while

drive(robot, 0, 0);
%delete(robot);
 