clc;
clear all;
close all;
addpath(genpath('fitting_function'));
inpath = '.\Training\*.png';
dir_im = dir(inpath);
dx = [-1 1; 0 0];
dy = [-1 0; 1 0];
for data_idxi = [16:20]
    for data_idxj = [1:8]
    image_name = sprintf('data_sets_part_5/im%02d_ker%02d_blur.png',data_idxi,data_idxj);
    mat_outname=sprintf('data_sets_part_5/im%02d_ker%02d_match.mat',data_idxi,data_idxj);
    %testImg = imread('C:\work\2013\gt_face_image\003_01_01_041_09_blur_with_kernel11.png');
    testImg = imread(image_name);
    %% For speed, we imresize the input and exemplar.
    testImg = imresize(testImg,[size(testImg,1), size(testImg,2)]/2,'bilinear');
    %figure; imshow(testImg)
    ori_test = double(testImg);
    if size(testImg,3) == 3
        testImg = rgb2gray(testImg);
    end
    testImg = im2double(testImg);
    % Imgx = conv2(testImg, dx, 'valid');
    % Imgy = conv2(testImg, dy, 'valid');
    [Imgx, Imgy] = gradient(testImg);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Imgx = Imgx./norm(Imgx(:));
    Imgy = Imgy./norm(Imgy(:));
    test_grad = [Imgx(:); Imgy(:)];
    %%
    val = zeros(length(dir_im),1);
    for i =1:10
        imName = dir_im(i).name;%
        I = imread([inpath(1:end - 5) imName]);
        I = imresize(I,[size(testImg,1), size(testImg,2)],'bilinear');
        Mask = imread([inpath(1:end - 6) '_mask\' imName(1:end - 4) '_mask.png']);
        Mask = imresize(Mask,[size(testImg,1), size(testImg,2)],'bilinear');
        Mask = double(im2bw(Mask));
        if size(I,3) == 3
            I = rgb2gray(I);
        end
        I = im2double(I);
        %     Ix = conv2(I, dx, 'valid');
        %     Iy = conv2(I, dy, 'valid');
        [Ix, Iy] = gradient(I);
        Mag = sqrt(Ix.^2 + Iy.^2).*Mask;
        Mag = Mag./norm(Mag(:));
        tt1x = Ix;%.*Mask;
        tt1y = Iy;%.*Mask;
        tt1x = tt1x./norm(tt1x(:));
        tt1y = tt1y./norm(tt1y(:));
        %% equation (3) in paper
        val(i) = gradient_similarity([Imgx(:); Imgy(:)] ,[tt1x(:);tt1y(:)]); 
        i
    end
    [VALS, IDX] = sort(val,'descend');
    match_name = dir_im(IDX(1)).name; %% find the largest values
    eval(sprintf('save  %s VALS IDX val match_name' ,mat_outname));
    end
end