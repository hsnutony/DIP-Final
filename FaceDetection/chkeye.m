function eye = chkeye(bImage,h0,w0,h, w)


%大概偵測區域中有沒有眼睛
%效果普普QQ

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

%檢查鄰居 8代表 上下左右 左上左下右上右下
[~,num] = bwlabel(part,8);

if num < 2
    eye = 0;
else
    eye = 1;
end