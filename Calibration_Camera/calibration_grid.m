clear all; close all;

%%

size_x = 21;
size_y = 14;

grid_x = NaN*ones(size_x,size_y);
grid_y = NaN*ones(size_x,size_y);
%%
path= '/home/nbourg/Bluebottle_Experiments/Calibration_Camera/';
file =[path 'calib_anne_screen.png']

I = imread(file);
imshow(rgb2ycbcr(I))
for i = 7:size_y
    for j = 1:size_x
        [X,Y]= ginput(1)
        
        grid_x(j,i) = X;
        grid_y(j,i) = Y;

    end
end
%%


save('calib2nd.mat','grid_x','grid_y')

%%
load("calib2nd.mat")

dist_x = NaN*ones(21,14);
dist_y = NaN*ones(21,14);


for i=1:21
    dist_x(i,:) = 0:20:(14-1)*20;
end


for i=1:14
    dist_y(:,i) = 0:20:(21-1)*20;
end



%% test 

clear bb_points_y_left
clear bb_points_x_left

 for i = 1:5
    
    imshow(I)


    [X,Y]= ginput(1)
    
    bb_points_x_left(i) = X;
    bb_points_y_left(i) = Y
    close all;


    close all;
 end




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



