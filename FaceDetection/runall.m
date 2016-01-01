clear;
close all;


face = imread('../face_deblurring_code_v1/test_image/HEBE_4.jpg');
H = fspecial('motion',15,15);
blurimg = imfilter(face, H, 'replicate');

figure, imshow(blurimg)
%{
%ton1 = imread('gg3be0.JPG');
%ton2 = imread('wang3.jpg');

blurry_Test = imread('../face_deblurring_code_v1/test_image/Lena_2.jpg');
test = imcrop(blurry_Test);
ttmp = imread('../face_deblurring_code_v1/test_image/Lena_Noise.png');
[m, n, z] = size(ttmp);
I = imresize(test, [m n]);

%figure;imshow(ton1);

ton_face= findFace(I, 125, 150);
figure;imshow(ton_face);
%}
imwrite(blurimg,'test_image/HEBE_blur4.jpg');


%{
YCBCR=rgb2ycbcr(ton_face);
Y=YCBCR(:,:,2);
sigma=2;
BW1=edge(Y,'canny',[0.2 0.4],sigma,'Thinning');
figure, imshow(BW1);
%}