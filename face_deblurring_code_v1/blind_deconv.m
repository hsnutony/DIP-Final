function [interim_latent, kernel] = blind_deconv(y, truthImg, Mask, opts)
%% 
%---------------Pre-processing --------------------%
if (size(y, 3) == 3)
    y = rgb2gray(y);
end;
if (size(truthImg,3)==3)
    truthImg = rgb2gray(truthImg);
end
y = im2double(y);
truthImg = im2double(truthImg);
%---------------end--------------------%
%% Gamma correction
if opts.gamma_correct~=1.0
    y = y.^opts.gamma_correct;
end
%% Convert "Mask" into binary image by OTSU method
t_level = graythresh(Mask);
Mask = double(im2bw(Mask,t_level));
%figure; imshow(Mask);
%--------------------------------------------------
% derivative filters
dx = [-1 1; 0 0];
dy = [-1 0; 1 0];
  yx = conv2(y, dx, 'same'); 
  yy = conv2(y, dy, 'same'); 
  %% using valid values
  yx(:,end) = 0; yx(end,:) = 0;
  yy(:,end) = 0; yy(end,:) = 0;
  %% normalize
  yx = yx./norm(yx(:));
  yy = yy./norm(yy(:));
  %%test%%
  truthx = conv2(truthImg, dx, 'same');
  truthy = conv2(truthImg, dy, 'same');
  %% 
  truthx(:,end) = 0; truthx(end,:) = 0;
  truthy(:,end) = 0; truthy(end,:) = 0;
  truthx = truthx.*Mask;
  truthy = truthy.*Mask;
  truthx = truthx./norm(truthx(:));
  truthy = truthy./norm(truthy(:));
  %% Visualize the gradients by Poisson reconstruction
  %imedge1=reconsEdge3(truthx,truthy);
  %imedge2=reconsEdge3(truthx,truthy);
  %figure(11); imshow([imedge1 imedge2],[]);
  %% 
  %------The main procedure (See Algorithm 2 in our paper)------%
  [interim_latent kernel] = blind_deconv_level(y, yx, yy, truthx, truthy, opts);
  
  %% Center the kernel
   kernel = adjust_psf_center(kernel);
   kernel(kernel<0) = 0;
   kernel=kernel/sum(kernel(:));
% %% Debug
% debug = 1;
