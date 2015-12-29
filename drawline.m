function [output] = drawline(input,d,s,r1,r2)
YCBCR=rgb2ycbcr(input);
Y=YCBCR(:,:,d);
sigma=s;
output=edge(Y,'canny',[r1 r2],sigma,'Thinning');

end

