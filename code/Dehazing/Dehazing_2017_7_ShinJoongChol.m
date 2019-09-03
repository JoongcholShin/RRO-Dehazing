%% ------------------------------ 
% "Radiance-Reflectance Combined Optimization and Structure-Guided `0-Norm for Single
%  Image Dehazing" demo
% Written by Joongchol Shin at May., 2019.
% Image Processing and Intelligency System Lab., Chung-Ang University, Seoul, Korea.
%
% The requisite functions
%--------------------------------------------------------------------------
%HDP.m(Haze Destribution Prior)
%GL0Smooth.m
%quadtreeitr.m
%--------------------------------------------------------------------------
% The requisite data
%--------------------------------------------------------------------------
%BSDS histrogram
%%
clear all
close all

addpath(cd);
addpath( [cd '\function'] );
addpath(cd);
addpath( [cd '\dataset'] );
%==========================================================================
%% image read
initial_path='images\*.*';
[full_name,file_path]=uigetfile(initial_path,'choose the image');
full_path=sprintf('%s%s',file_path,full_name);
opened=imread(full_path);
img=opened;
img=im2double(img);
img=imresize(img,[256 256]);
Eps=0.1;




whole_time=tic;
%==========================================================================
%% initialize
initialize_time=tic;

[m,n,D]=size(img);
phi=50;
psai=10;
w=0.9;
lambda=0.005;
kappa=1.5;

guidence=min(min(img(:,:,1),img(:,:,2)),img(:,:,3));



times.initialize_time=toc(initialize_time);
disp('initialize_time')
disp(times.initialize_time)
%=========================================================================
%% estimating A
Airlight_time=tic;

A=zeros(3,1);
[Block,AH,AW]=quadtreeitr(guidence,4);
AH=fix(AH);
AW=fix(AW);
BH=AH+size(Block,1)-4;
BW=AW+size(Block,2)-4;
A(1)=mean(mean(img(AH:BH,AW:BW,1)));
A(2)=mean(mean(img(AH:BH,AW:BW,2)));
A(3)=mean(mean(img(AH:BH,AW:BW,3)));

A=reshape(A,1,1,3); 

times.Airlight_time=toc(Airlight_time);
disp(times.Airlight_time)


cores_t= 1-min(min(img(:,:,1)/A(1),img(:,:,2)/A(2)),img(:,:,3)/A(3));
ref2=zeros(size(img));
ref2(:,:,1)=A(1)+(img(:,:,1)-A(1))./max(cores_t,0.01);
ref2(:,:,2)=A(2)+(img(:,:,2)-A(2))./max(cores_t,0.01);
ref2(:,:,3)=A(3)+(img(:,:,3)-A(3))./max(cores_t,0.01);


%==========================================================================
%% Haze Destribution Prior
Transmission_time=tic;

RefR=load('dataset\totalR.mat');
RefG=load('dataset\totalG.mat');
RefB=load('dataset\totalB.mat');

[t, Corse, d_J, d_Jtild]=HDP(img, ref2, A, w, phi, psai, RefR, RefG, RefB);




times.Transmission_time=toc(Transmission_time);
disp('Transmission_time')
disp(times.Transmission_time)
%=========================================================================
%% transmission refinement

RefineTransmission_time=tic;
guidence=1-guidence./min(A(:));


[t_hat,Gd]=GL0Smoothing(guidence,lambda,kappa,t);

t_hat=max(t_hat,Gd);

times.RefineTransmission_time=toc(RefineTransmission_time);
disp('RefineTransmission_time')
disp(times.RefineTransmission_time)
%==========================================================================
%% recovering
J_time=tic;

recovering=zeros(size(img));
recovering(:,:,1)=A(:,:,1)+(img(:,:,1)-A(:,:,1))./max(t_hat,Eps);
recovering(:,:,2)=A(:,:,2)+(img(:,:,2)-A(:,:,2))./max(t_hat,Eps);
recovering(:,:,3)=A(:,:,3)+(img(:,:,3)-A(:,:,3))./max(t_hat,Eps);
recovering=recovering;

times.J_time=toc(J_time);
disp('J_time')
disp(times.J_time)
%==========================================================================
times.whole_time=toc(whole_time);
disp('times.whole_time')
disp(times.whole_time)



%==========================================================================
%% Result show 

figure, imshow(img);title('obseved image')
figure, imshow(t);title('Estimated transmission')
figure, imshow(t_hat);title('Refined transmission')
figure, imshow(recovering);title('Result image')
%==========================================================================
%% save

if exist('save', 'dir') ~= 7; mkdir('save'); end
file_name = full_name(1:length(full_name)-4);

save_string = sprintf('%s%s_%s', 'save\', file_name, 'original.png');
imwrite(img, save_string, 'png');

save_string = sprintf('%s%s_%s', 'save\', file_name, 't_max.png');
imwrite(t, save_string, 'png');

save_string = sprintf('%s%s_%s', 'save\', file_name, 't_hat_optimize.png');
imwrite(t_hat, save_string, 'png');

save_string = sprintf('%s%s_%s', 'save\', file_name, 'recovering_optimize.png');
imwrite(recovering, save_string, 'png');




