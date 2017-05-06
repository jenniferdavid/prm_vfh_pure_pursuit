%% calculate a steering direction based on input laser scan data.
 vfh = robotics.VectorFieldHistogram;
%% Input laser scan data and target direction.
ranges = 10*ones(1, 500);
ranges(1, 225:275) = 1.0;
angles = linspace(-pi, pi, 500);
targetDir = 0;
 %% Compute obstacle-free steering direction
steeringDir = step(vfh, ranges, angles, targetDir)
%% Visualize the VectorFieldHistogram computation
show(vfh);
%show(vfh,'Parent',parent);