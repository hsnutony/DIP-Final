function eye = chkeye(bImage,h0,w0,h, w)

part = zeros(h, w);

for i = h0:(h0+h)
    for j = w0:(w0+w)
        if bImage(i, j) == 0
            part(i-h0+1,j-w0+1) = 255;
        else
            part(i-h0+1,j-w0+1) = 0;
        end
    end
end
[~,num] = bwlabel(part,8);
% 如果?域中有??以上的矩形???有眼睛
if num < 2
    eye = 0;
else
    eye = 1;
end