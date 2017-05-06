%% Obstacle Avoidance with TurtleBot and VFH
% This example shows how to use a TurtleBot(R) with Vector Field Histograms 
% (VFH) to perform obstacle avoidance when driving a robot in an environment. 
% The robot wanders by driving forward until obstacles get in the way. 
% The <docid:robotics_ref.buv7g7y> class 
% computes steering directions to avoid objects while trying to drive forwards.
%%
% *Optional:* If you do not already have a TurtleBot (simulated or real)
% set up, install a virtual machine with the Gazebo simulator and TurtleBot
% package. See
% <docid:robotics_examples.example-GettingStartedWithGazeboExample> to
% install and set up a TurtleBot in Gazebo.

%%
% Connect to the TurtleBot using the IP address obstained from setup.
rosinit('192.168.154.131')

%%
% Create a publisher and subscriber to share information with the VFH
% class. The subscriber recceives the laser scan data from the robot. The
% publisher sends velocity commands to the robto.
%
% The topics used are for the simulated TurtleBot. Adjust the topic names
% for your specific robot.
laserSub = rossubscriber('/scan');
[velPub, velMsg] = rospublisher('/mobile_base/commands/velocity');

%%
% Set up VFH object for obstacle avoidance. Specify algorithm properties for 
% robot specifications. Set target direction to |0| in order to drive straight.

vfh = robotics.VectorFieldHistogram;
vfh.DistanceLimits = [0.05 1];
vfh.RobotRadius = 0.1;
vfh.MinTurningRadius = 0.2;
vfh.SafetyDistance = 0.1;

targetDir = 0;

%%
% Set up a Rate object using <docid:robotics_ref.bu31fh7-1>, which can
% track the timing of your loop. This object can be used to control the rate the
% loop operates as well.
rate = robotics.Rate(10);

%%
% Create a loop that collects data, calculates steering direction, and drives 
% the robot. Set a loop time of 30 seconds.
%
% Use the ROS subscriber to collect laser scan data. Calculate 
% the steering direction with the VFH object based on the input laser scan 
% data. Convert the steering direction to a desired linear and an angular 
% velocity. If a steering direction is not found, the robot stops and searches 
% by rotating in place. 
% 
% Drive the robot by sending a message containing the 
% angular velocity and the desired linear velocity using the ROS publisher.

while rate.TotalElapsedTime < 30

	% Get laser scan data
	laserScan = receive(laserSub);
	ranges = double(laserScan.Ranges);
	angles = double(laserScan.readScanAngles);
	
	% Call VFH object to computer steering direction
	steerDir = vfh(ranges, angles, targetDir);  
    
	% Calculate velocities
	if ~isnan(steerDir) % If steering direction is valid
		desiredV = 0.2;
		w = exampleHelperComputeAngularVelocity(steerDir, 1);
	else % Stop and search for valid direction
		desiredV = 0.0;
		w = 0.5;
	end

	% Assign and send velocity commands
	velMsg.Linear.X = desiredV;
	velMsg.Angular.Z = w;
	velPub.send(velMsg);
end

%%
% This code shows how you can use the Robotics System Toolbox(TM) algorithms
% to control robots and react to dynamic changes in their environment.
% Currently the loop ends after 30 seconds, but other
% conditions can be set to exit the loop (i.e. robot position or number of 
% laser scan messages) based on information on the ROS network.

%%
% Disconnect from the ROS network
rosshutdown