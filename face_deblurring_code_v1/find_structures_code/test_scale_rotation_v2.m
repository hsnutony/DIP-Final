clc;
clear all;
close all;
addpath(genpath('fitting_function'));
inpath = '.\Training\*.png';
dir_im = dir(inpath);
dx = [-1 1; 0 0];
dy = [-1 0; 1 0];
testImg = imread('data_sets_part_5/im16_ker01_blur.png');
figure; imshow(testImg)
ori_test = double(testImg);
testImg = imresize(testImg,[size(testImg,1), size(testImg,2)]/2,'bilinear');
if size(testImg,3) == 3
    testImg = rgb2gray(testImg);
end
testImg = im2double(testImg);
[Imgx, Imgy] = gradient(testImg);
Imgx = Imgx./norm(Imgx(:));
Imgy = Imgy./norm(Imgy(:));
test_grad = [Imgx(:); Imgy(:)];
%%
val = zeros(length(dir_im),5);
for i =1:length(dir_im)
    imName = dir_im(i).name;%
    I = imread([inpath(1:end - 5) imName]);
    count  = 1;
    rot_angle = [-10,-9 -8, -7, - 6, -5, -4, -3, -2, -1, 0, ...
        1, 2, 3, 4, 5, 6, 7, 8, 9 ,10];
%rot_angle = 0;
    for rot_idx = rot_angle
        I = imresize(I,[size(testImg,1), size(testImg,2)],'bilinear');
        I_rot = imrotate(I,rot_idx,'bilinear','crop');
        if size(I,3) == 3
            I_rot = rgb2gray(I_rot);
        end
        I_rot= im2double(I_rot);
        %% For scale
        scale_range = 0.5:0.5:2;
        for scale_idx = scale_range
            I_rot_scale = imresize(I_rot,[size(I_rot,1), size(I_rot,2)]*scale_idx,'bilinear');
            [Ix, Iy] = gradient(I_rot_scale);
            tt1x = Ix;%.*Mask;
            tt1y = Iy;%.*Mask;
            tt1x = tt1x./norm(tt1x(:));
            tt1y = tt1y./norm(tt1y(:));
            val(i, count, count) = gradient_similarity([Imgx(:); Imgy(:)] ,[tt1x(:);tt1y(:)]);
            count = count + 1;
        end
    end
    i
end
[VALS, IDX] = sort(val,'descend');
% save('ori_val','val');
% save('VALS','VALS');
% save('IDX','IDX');