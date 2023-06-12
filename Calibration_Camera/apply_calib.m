clear all; close all;

path= '/media/nbourg/One Touch/Bluebottle/poster/26_05_23/';
path_left = [path 'wind_4ms/run1/Left_UltraGauche/'];
path_right = [path 'wind_4ms/run1/Right_UltraDroite/'];


fn = dir(fullfile(path_left,'*.jpg'));
files = cell(1, length(fn));
 for i = 1:3:length(fn)
    files{i} = fullfile(path_left,fn(i).name);

    I = imread(files{i});
    imshow(I)


    [X,Y]= ginput(1)
    
    bb_points_x_left(i) = X;
    bb_points_y_left(i) = Y
    close all;


    close all;
 end


%%

load('calib2nd.mat')

path= '/home/nbourg/Bluebottle_Experiments/Calibration_Camera/';
file =[path 'calib_anne_screen.png']

grid = imread(file);
imshow(rgb2ycbcr(grid))

hold on;
imshow((I));
hold on;

scatter(grid_x,grid_y)


scatter(bb_points_x_left, bb_points_y_left,'r','filled')


%%

delta_t = 2*60;

gx = reshape(grid_x, [14*21,1]);
gy = reshape(grid_y, [14*21,1]);

dx = reshape(dist_x, [14*21,1]);
dy = reshape(dist_y, [14*21,1]);

[a, idx_x] = min(abs(bb_points_x_left-gx));
[a, idx_y] = min(abs(bb_points_y_left-gy))

delta_x = dx(idx_x(end))-dx(idx_x(1));
delta_y = dy(idx_y(end))-dy(idx_y(1));


xs = [gx(idx_x(1)), gx(idx_x(end))];
ys = [gy(idx_y(1)), gy(idx_y(end))];


% --------------------- calculs
distance = sqrt(delta_x^2+delta_y^2);
speed = distance/delta_t;

angle_rad = atan(delta_x/delta_y);
angle_deg = angle_rad*180/pi;

% --------------------- plots
%imshow((I));
hold on;

pcolor(grid_x,grid_y,dist_y)


scatter(bb_points_x_left, bb_points_y_left,'r','filled')
plot(xs,ys,'r')

title([num2str(angle_deg) '°, ' num2str(speed*100) 'cm/s'])

