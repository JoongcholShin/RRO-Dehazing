%% ------------------------------ 
% Edge Preserving Smoothing test demo
% Written by JoongChol Shin at Dec 21, 2017.
% Image Processing and Intelligency System Lab., Chung-Ang University, Seoul, Korea.
%
% The requisite functions
%--------------------------------------------------------------------------
%L0Smoothing
%GL0Smoothing.m
%D5D_Smoothing_proposed.m
%--------------------------------------------------------------------------


clear all
close all
clc

%% image read

addpath(cd);
addpath( [cd '\function'] );
initial_path='images\*.*';
[full_name,file_path]=uigetfile(initial_path,'choose the image');
full_path=sprintf('%s%s',file_path,full_name);
opened=imread(full_path);
img=opened;
img=im2double(img);

%% 
[m, n, D]=size(img);
tic
g=imfilter(img,ones(3,3)/9,'replicate');
SGL0 = GL0Smoothing(g,0.02,2,img);
toc
figure, imshow(SGL0);
title('GL0 Result')

tic
SD5L0=D5D_Smoothing_proposed(img,0.02,2,1e5);
toc
figure, imshow(SD5L0);
title('D5L0 Result')

tic
SL0=L0Smoothing(img,0.02,2);
toc
figure, imshow(SL0);
title('L0 Result')


[m,n,D]=size(img);
tic
if D==1
SGF = guidedfilter(img,img,12,10^-1.5);
else
SGF=zeros(m,n,D);
SGF(:,:,1) = guidedfilter(img(:,:,1),img(:,:,1),12,10^-1.5);
SGF(:,:,2) = guidedfilter(img(:,:,2),img(:,:,2),12,10^-1.5);
SGF(:,:,3) = guidedfilter(img(:,:,3),img(:,:,3),12,10^-1.5);
end
toc
figure, imshow(SGF);

%%

if exist('save', 'dir') ~= 7; mkdir('save'); end
file_name = full_name(1:length(full_name)-4);

save_string = sprintf('%s%s_%s', 'save\', file_name, 'original.png');
imwrite(img, save_string, 'png');

save_string = sprintf('%s%s_%s', 'save\', file_name, 'S_GL0.png');
imwrite(SGL0, save_string, 'png');


save_string = sprintf('%s%s_%s', 'save\', file_name, 'GI_L0.png');
imwrite(SD5L0, save_string, 'png');


save_string = sprintf('%s%s_%s', 'save\', file_name, 'L0.png');
imwrite(SL0, save_string, 'png');


save_string = sprintf('%s%s_%s', 'save\', file_name, 'GF.png');
imwrite(SGF, save_string, 'png');