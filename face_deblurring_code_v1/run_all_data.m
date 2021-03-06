clc;
%clear all;
close all;

% add path
addpath(genpath('boundary_proc_code'));
addpath(genpath('fina_deconvolution_code'));
addpath(genpath('../FaceDetection'));
% i don't know where these values from QQ?
k_size = [19, 17, 15, 27, 13, 21, 23, 23];

%% unuse
% if having several matched images 
%for i=[2:4]

%i = 3;
%% 

%size arg  size(1) is 19
j = 1;

%% unuse
% for several inputs
%input_name = sprintf('./find_structures_code/data_sets_part_5/im%02d_ker%02d_blur.png',i,j);
%y_color = imread(input_name);
%%


%% unuse
%{
y_color = imread('test_image/Lena_Noise.png');
if size(y_color,3) == 3
  blurred = rgb2gray(y_color);
end
blurred = im2double(blurred);
%}
%%

%%%%%%%%%% 1/4  input auto-crop upgrape %%%%%%%%%%%%%

%get blur img
blur_img = imread('test_image/Lena_blur_1.jpg');
figure, imshow(blur_img)


%% unuse
% for several inputs
%inputMatch = sprintf('Lena_Match%d.png',i);
%inputMask = sprintf('Lena_Mask%d.png',i);
%%

%get reference img
Matched = imread('test_image/Lena_2.jpg');
figure, imshow(Matched)


%% unuse
%Matched = imread('test_image/Lena_Ori.png');
%Mask = imread('test_image/Lena_Mask2.png');

%Mask = imread('../FaceDetection/Lena_autoMask.png');
%%

%pre process
[blurred, Matched, Mask] = cropFace(blur_img, Matched);

% initial k_size, xk_iter (do how many times), gamma_correct
opts.kernel_size  =k_size(j);
opts.xk_iter = 50;
opts.gamma_correct = 1.0;

%% Blind Deblur -> find kernel
[interim_latent, kernel] = blind_deconv(blurred, Matched, Mask, opts);
%% With Coarse-to-fine 
%[interim_latent, kernel] = blind_deconv_coarse_to_fine(blurred, Matched, Mask, opts);
%% Final deblur
%Total_img = imread('test_image/Lena_Total.png');
Total_img = blur_img;
y_color = double(Total_img)/255;
deblur = [];
for cc = 1:size(y_color,3)
  %deblur(:,:,cc)=deconvSps(y_color(:,:,cc),kernel,0.001,100);
  %original 
  deblur(:,:,cc)=deconvSps(y_color(:,:,cc),kernel,0.002,100);
end
%% Save results
%eval(sprintf('save  %s kernel deblur' ,mat_outname))
%imwrite(deblur,img_out_name);
figure,
subplot(121);imshow(y_color);
subplot(122);imshow(deblur);

%% unuse
%{
compare = imread('test_image/Lena_Sample.png');
compare = im2double(compare);
deblur = im2double(deblur);
%psnrs(i) = psnr(compare, deblur);
kw = kernel-min(kernel(:));
kw = kw./max(kw(:));
%imwrite(kw,k_out_name);
%}
%%
%end




