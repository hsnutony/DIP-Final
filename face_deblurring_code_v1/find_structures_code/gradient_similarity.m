function s = gradient_similarity(gradB, gradT)
%-------------------------------------------------------------
% calculate the gradient similarity using the response of convolution
% devided by the norm
% Reference:
% Z. Hu and M.-H. Yang. Good regions to deblur. In ECCV, pages 59¨C72, 2012
%-------------------------------------------------------------

gradB = gradB/sqrt(sum(sum(gradB.^2)));
temp = imfilter(gradB, gradT,'corr','full');
temp2 = sqrt(sum(sum(gradT.^2)));
s = max(temp(:))/temp2;

end