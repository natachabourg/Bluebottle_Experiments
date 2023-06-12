clear all; close all;

%%

size_x = 21;
size_y = 14;

grid_x = NaN*ones(size_x,size_y);
grid_y = NaN*ones(size_x,size_y);

path= '/home/nbourg/Bluebottle_Experiments/Calibration_Camera/';
file =[path 'calib_anne_png.png']

I = imread(file);
imshow(I)

for i = 1:size_y
    for j = 1:size_x
        [X,Y]= ginput(1)
        
        grid_x(j,i) = X;
        grid_y(j,i) = Y;

    end
end

save('calib1st.mat','grid_x','grid_y')

%%


dist_x = NaN*ones(14,21);
dist_y = NaN*ones(14,21);


for i=1:21
    dist_x(:,i) = 0:20:(14-1)*20;
end


for i=1:14
    dist_y(i,:) = 0:20:(21-1)*20;
end


%%

load('calib1st.mat')

gx = reshape(grid_x, [14,21]);
gy = reshape(grid_y, [14,21]);


scatter(gx,gy);

gx(gy<99)=NaN;
gy(gy<99)=NaN;
%%

path= '/home/nbourg/Bluebottle_Experiments/Calibration_Camera/';
file =[path 'calib_anne_png.png']

I = imread(file);

imshow((I));
hold on;

pcolor(gx,gy,dist_y)

%% test 



 for i = 1:5
    
    imshow(I)


    [X,Y]= ginput(1)
    
    bb_points_x_left(i) = X;
    bb_points_y_left(i) = Y
    close all;


    close all;
 end


%%



imshow((Ic));
hold on;

pcolor(gx,gy,dist_y)
scatter(bb_points_x_left, bb_points_y_left,'r','filled')



