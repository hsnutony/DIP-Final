clear;
close all;

%this file just be used to make motion blur

face = imread('../face_deblurring_code_v1/test_image/Lena_1.jpg');
H = fspecial('motion',8,8);
blurimg = imfilter(face, H, 'replicate');

figure, imshow(blurimg)
%{
ton1 = imread('../face_deblurring_code_v1/test_image/HEBE_2.jpg');

ton1 = imcrop(ton1);
ton3 = ton1(:, :, 1);
cbcr = rgb2ycbcr(ton1);
cbcr3 = cbcr(:, :, 3);
%}
%ton2 = imread('wang3.jpg');
%{
blurry_Test = imread('../face_deblurring_code_v1/test_image/Lena_2.jpg');
test = imcrop(blurry_Test);
ttmp = imread('../face_deblurring_code_v1/test_image/Lena_Noise.png');
[m, n, z] = size(ttmp);
I = imresize(test, [m n]);

%figure;imshow(ton1);

[ton_face, Q ,QQ]= findFace(ton1, 142, 165);
Mask = findMask(Q, QQ);
figure;imshow(ton_face);
figure;imshow(Q);
figure;imshow(QQ);
figure;imshow(QQ);
figure;imshow(Mask);
%}
imwrite(blurimg,'test_image/Lena_blur_1.jpg');


%{
YCBCR=rgb2ycbcr(ton_face);
Y=YCBCR(:,:,2);
sigma=2;
BW1=edge(Y,'canny',[0.2 0.4],sigma,'Thinning');
figure, imshow(BW1);
%}