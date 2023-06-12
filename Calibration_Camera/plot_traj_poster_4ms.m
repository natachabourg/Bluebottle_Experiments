clear all; close all;

%%

clear all

path= '/home/nbourg/Bluebottle_Experiments/Calibration_Camera/';
file =[path 'calib_anne_png.png']

I = imread(file);
imshow(I)

for i = 1:21
    for j = 1:14
        [X,Y]= ginput(1)
        
        grid_x(j,i) = X;
        grid_y(j,i) = Y;

    end
end


imshow(rgb2gray(I));hold on;
scatter(grid_x,grid_y,'red','filled')
