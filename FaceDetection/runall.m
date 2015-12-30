clear;
close all;

ton1 = imread('gg3be0.JPG');
ton2 = imread('test1.jpg');

%H = fspecial('motion',20,45);
%ton2 = imfilter(ton1, H, 'replicate');


%讀圖找臉der框框
%參數是找皮膚色用的 是照片而定
ton_face= findFace(ton2, 144, 160);
figure;imshow(ton_face);


%{
YCBCR=rgb2ycbcr(ton_face);
Y=YCBCR(:,:,2);
sigma=2;
BW1=edge(Y,'canny',[0.2 0.4],sigma,'Thinning');
figure, imshow(BW1);
%}