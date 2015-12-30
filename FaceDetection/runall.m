clear;
close all;

ton1 = imread('gg3be0.JPG');
ton2 = imread('wang3.jpg');

%H = fspecial('motion',20,45);
%ton2 = imfilter(ton1, H, 'replicate');

figure;imshow(ton1);

ton_face= findFace(ton1, 140, 170);
figure;imshow(ton_face);


%{
YCBCR=rgb2ycbcr(ton_face);
Y=YCBCR(:,:,2);
sigma=2;
BW1=edge(Y,'canny',[0.2 0.4],sigma,'Thinning');
figure, imshow(BW1);
%}