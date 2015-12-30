clc;
clear all;
close all;
r = 4;
eps = 10^-2;
inpath = '.\data2\*.png';
dir_im = dir(inpath);
for i =1:length(dir_im)
    imName = dir_im(i).name;%
    %imName = 'face50_flp.png';
    I = imread([inpath(1:end - 5) imName]);
    if size(I,3) == 3
        I = rgb2gray(I);
    end
    I = im2double(I);
    %I = imresize(I,[320,240],'bilinear');
    truthImg = I;
    %%
    disp('Bottom contour...');
    Mask=roipoly(truthImg);
    BW1=double(Mask);
    close all;
    S = guidedfilter(I, BW1, r, eps);
    thresh = graythresh(S); %% Adjustable
    Mask_contour = double(edge(S,'canny',thresh));
    BW1_contour = double(edge(BW1,'canny'));
    %% Remove the unper line
    [idx_i,idx_j] = find(Mask_contour);
    Mask_contour(min(idx_i)-10:min(idx_i)+10,:) = 0;
    BW1_contour(min(idx_i)-10:min(idx_i)+10,:) = 0;
%     figure(1); imshow(Mask_contour,[]);
    %% Left eye
    disp('Left eye...');
    Mask=roipoly(truthImg);
    BW2=double(Mask);
    close all;
    S = guidedfilter(I, BW2, 2, eps); %% for eye: smaller radius
    thresh = graythresh(S); %% Adjustable
    Maskl_eye = double(edge(S,'canny',thresh));
    BW2_leye=double(edge(BW2,'canny'));
%     figure(2); imshow(Maskl_eye,[]);
    %% Right eye
    disp('Right eye...');
    Mask=roipoly(truthImg);
    BW3=double(Mask);
    close all;
    S = guidedfilter(I, BW3, 2, eps); %% for eye: smaller radius ???
    thresh = graythresh(S); %% Adjustable
    Maskr_eye = double(edge(S,'canny',thresh));
    BW3_reye=double(edge(BW3,'canny'));
%     figure(3); imshow(Maskr_eye,[]);
    %% Mouth
    disp('Mouth...');
    Mask=roipoly(truthImg);
    BW4=double(Mask);
    close all;
    S = guidedfilter(I, BW4, r, eps);
    thresh = graythresh(S); %% Adjustable
    Mask_mouth = double(edge(S,'canny',thresh));
    BW4_mouth=double(edge(BW4,'canny'));
%     figure(4); imshow(Mask_mouth,[]);
    %% Compute final mask
    Mask = Mask_contour;
    idx1 = find(Mask_contour==1);
    idx2 = find(Maskl_eye==1);
    idx3 = find(Maskr_eye==1);
    idx4 = find(Mask_mouth==1);
    Mask(idx1) = Mask_contour(idx1);
    Mask(idx2) = Maskl_eye(idx2);
    Mask(idx3) = Maskr_eye(idx3);
    Mask(idx4) = Mask_mouth(idx4);
    %% For comparison
    Mask_ini = BW1_contour;
    idx1_ini = find(BW1_contour==1);
    idx2_ini = find(BW2_leye==1);
    idx3_ini = find(BW3_reye==1);
    idx4_ini = find(BW4_mouth==1);
    Mask_ini(idx1_ini) = BW1_contour(idx1_ini);
    Mask_ini(idx2_ini) = BW2_leye(idx2_ini);
    Mask_ini(idx3_ini) = BW3_reye(idx3_ini);
    Mask_ini(idx4_ini) = BW4_mouth(idx4_ini);
    %%
    imwrite(Mask,[inpath(1:end - 6) '_mask\' imName(1:end - 4) '_mask.png']);
    i
end
    
    