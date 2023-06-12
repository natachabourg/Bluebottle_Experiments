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


dist_x = NaN*ones(21,14);
dist_y = NaN*ones(21,14);


for i=1:21
    dist_x(i,:) = 0:20:(14-1)*20;
end


for i=1:14
    dist_y(:,i) = 0:20:(21-1)*20;
end



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



imshow((I));
hold on;

pcolor(grid_x,grid_y,dist_y)


scatter(bb_points_x_left, bb_points_y_left,'r','filled')



