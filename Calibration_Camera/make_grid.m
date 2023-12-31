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

subplot(2,2,1)
imshow(A1)
subplot(2,2,2)
imshow(A2)
subplot(2,2,3)
imshow(A3)
subplot(2,2,4)
imshow(I)
tmp=A2;
% extract only the lines and their coordinates
%%%%%%%%%%%%%%%%%%%%%%%%%

A2=imresize(tmp,[1200 1920]);
A2(A2~=0)=1000;
[ix,iy]=find(A2==0);
figure
plot(iy,ix','.')
size(A2)

% READ THE IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%

%I2=imread('/home/nbourg/Bureau/fc2_save_2023-05-19-173851-0076.jpg');
I2=imread('/home/nbourg/Bureau/fc2_save_2023-05-19-173851-0089.jpg');
X1=I2(:,:,1);X2=I2(:,:,2);X3=I2(:,:,3);

% example to find points
%%%%%%%%%%%%%%%%%%%%%%%%%
% ginput(3)
% (in1,in2)=ans;
% (in1;in2)=ans;
% toto=ans;
% X1(fix(toto))
% X2(fix(toto))
% X3(fix(toto))
help im2bw
% Make the image in bw
%%%%%%%%%%%%%%%%%%%%%%%%%

I3=im2bw(I2,0.5);
I3(1:400,1300:1900)=0; % remove white upper-right corner
size(I3)
figure
imshow(I3)
[t1,t2]=find(I3~=0);
pause
hold on
plot(t2,t1,'.y')
pause
plot(mean(t2),mean(t1),'*r')

figure(1)
hold on
plot(mean(t2),mean(t1),'*r')
