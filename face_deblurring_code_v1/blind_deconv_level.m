function [deblurImg, k] = blind_deconv_level(blurImg, Bx, By, Ix, Iy,opts)
%% This is the implementation of Algorithm 2 in our paper
%%
dx = [-1 1; 0 0];
dy = [-1 0; 1 0];
%%
lam_reg = 2e-3; %%Weitht for L0 prior
%% Without using exemplar structure
% Ix = Bx;
% Iy = By;
for iter = 1:opts.xk_iter
  %% Kernel estimation
  %[k1,k2] = size(k);
  k1 = opts.kernel_size;
  k2 = k1; %% for square kernel

  %% solve for k using (7) in our paper.
  k = estimate_psf(Bx, By, Ix, Iy, 1, [k1,k2]);
  
  %% pruning isolated noise in kernel
  CC = bwconncomp(k,8);
  for ii=1:CC.NumObjects
      currsum=sum(k(CC.PixelIdxList{ii}));
      if currsum<.1 
          k(CC.PixelIdxList{ii}) = 0;
      end
  end
  %k  = Cho_correct(k);
  k(k<0) = 0;
  k=k/sum(k(:));
  k = adjust_psf_center(k);
  k(k<0) = 0;
  k = k./sum(k(:));
  %%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Latent Image restoration
  k = fliplr(flipud(k));
  %% Solve for I using Algorithm 1 in our paper
  % deblurImg = L0Restoration(blurImg, fliplr(flipud(k)), lam_reg, 2.0);
  % original / blurryfish changes

  deblurImg = L0Restoration(blurImg, fliplr(flipud(k)), lam_reg, 9.5);
  figure(1); 
  subplot(131); imshow(deblurImg,[]);
  subplot(132); imshow(Ix,[]);
  subplot(133); imshow(k,[]);
  fprintf('%d iterations is done!\n', iter);
%% Update salient edges
  latent_x = conv2(deblurImg, dx, 'same'); 
  latent_y = conv2(deblurImg, dy, 'same'); 
  latent_x(:,end) = 0;  latent_x(end,:) = 0;
  latent_y(:,end) = 0;  latent_y(end,:) = 0;
  Ix = latent_x./norm(latent_x(:));
  Iy = latent_y./norm(latent_y(:));

end;
