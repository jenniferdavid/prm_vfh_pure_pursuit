function PathFollowing(path)
    
    robot = RobSimulatorWithMyMap('MapSize151',1); 
    controller = robotics.PurePursuit;         
    controller.DesiredLinearVelocity = 0.3;
    controller.MaxAngularVelocity = 2;
    controller.LookaheadDistance = 0.5;
    controlRate = robotics.Rate(10);
    
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
    delete(robot);
 