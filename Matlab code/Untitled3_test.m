clear
a = arduino('COM4', 'Uno', 'Libraries', 'I2C');

fs = 100; % Sample Rate in Hz   
imu = mpu9250(a,'SampleRate',fs,'OutputFormat','matrix'); 

%displayMessage(['Fusion algorithms use magnetometer readings which need to compensate for magnetic distortions.' ...
%    'The given code snippet can be used to find the correction values for compensating Hard Iron Distortions. When the code '...
%    'is executing, rotate the sensor around x axis from 0 to 360 degree. For other axes, modify the code accordingly and rotate the ' ...
%    'sensor along that axis'],'Compensating Hard Iron Distortions');
tic;
stopTimer = 100;
magReadings=[];
while(toc<stopTimer)
    % Rotate the sensor around x axis from 0 to 360 degree.
    % Take 2-3 rotations to improve accuracy.
    % For other axes, rotate around that axis.
    [accel,gyro,mag] = read(imu);
    magReadings = [magReadings;mag];
end

% For y axis, use magReadings (:,2) and for z axis use magReadings(:,3)
magx_min = min(magReadings(:,1));
magx_max = max(magReadings(:,1));
magx_correction = (magx_max+magx_min)/2;

% GyroscopeNoise and AccelerometerNoise is determined from datasheet.
% GyroscopeNoiseMPU9250 = 3.0462e-06; % GyroscopeNoise (variance value) in units of rad/s
% AccelerometerNoiseMPU9250 = 0.0061; % AccelerometerNoise(variance value)in units of m/s^2
% viewer = HelperOrientationViewer('Title',{'AHRS Filter'});
% FUSE = ahrsfilter('SampleRate',imu.SampleRate, 'GyroscopeNoise',GyroscopeNoiseMPU9250,'AccelerometerNoise',AccelerometerNoiseMPU9250);
% stopTimer = 100;

% Use ahrsfilter to estimate orientation and update the viewer as the
% sensor moves for time specified by stopTimer
% displayMessage(['This section uses AHRS filter to determine orientation of the sensor by collecting live sensor data from the \slmpu9250 \rm' ...
%     'system object. Move the sensor to visualize orientation of the sensor in the figure window. Keep the sensor stationery before you' ...
%     'click OK'],...
%     'Estimate Orientation using AHRS filter and MPU-9250')
% tic;
% while(toc < stopTimer)
%     [accel,gyro,mag] = readSensorDataMPU9250(imu);
%     rotators = FUSE(accel,gyro,mag);
%     for j = numel(rotators)
%         viewer(rotators(j));
%     end
% end