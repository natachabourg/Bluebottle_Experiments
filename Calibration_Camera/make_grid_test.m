%%%%%%%%%%%%%%%%%%%%%%%%%
% MAKE THE GRID for calibration
%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

path= '/home/nbourg/Bluebottle_Experiments/Calibration_Camera/';
file =[path 'calib_anne_screen.png']
I = imread(file);

A1=I(:,:,1);
A2=I(:,:,2);
A3=I(:,:,3);
% RGB image
%%%%%%%%%%%%%%%%%%%%%%%%%


imshow(I)
tmp=A2;
korn=ginput(4)

%// Create perspective transformation that warps the original 
%// image coordinates to the trapezoid
movingPoints = [1 1; size(img,2) 1; 1 size(img,1); size(img,2) size(img,1)];
fixedPoints = [180 100; 340 100; 50 300; 450 300];
tform = fitgeotrans(movingPoints, fixedPoints, 'Projective');


%// Create a reference coordinate system where the extent is the size of
%// the image
RA = imref2d([size(img,1) size(img,2)], [1 size(img,2)], [1 size(img,1)]);
%// Warp the image
[out,r] = imwarp(img, tform, 'OutputView', RA);


% extract only the lines and their coordinates
%%%%%%%%%%%%%%%%%%%%%%%%%

A2=imresize(tmp,[1200 1920]);
A2(A2~=0)=1000;
[ix,iy]=find(A2==0);
figure
plot(iy,ix','.')
size(A2)

%%%https://stackoverflow.com/questions/32447767/how-to-warp-an-image-into-a-trapezoidal-shape-in-matlab