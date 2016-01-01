function output = detectSkin(oriImg, tlow, thigh)

%get size
[m, n, ~] = size(oriImg);
%color transform
cbcr = rgb2ycbcr(oriImg);
cbcr3 = cbcr(:, :, 3);

%skin thredhold  
for i = 1 : m
    for j = 1 : n
        if((cbcr3(i, j) > tlow) && (cbcr3(i, j) < thigh))
            cbcr3(i, j) = 255;
        else
            cbcr3(i, j) = 0;
        end
    end
end

%figure, imshow(cr1)

%mean filter
for i=3:m-2
    for j=3:n-2;
        tmp=cbcr3(i-2:i+2,j-2:j+2);
        s_tmp=sort(tmp);
        cbcr3(i,j)=s_tmp(13);
    end
end


%check whether the region like an face
[l,kk]=findlimit(cbcr3);
mask=l;
for i=1:m
    for j=1:n
    if(l(i,j)~=0&&isson(l(i,j),kk)==1)
        mask(i,j)=255;
    else
        mask(i,j)=0;
    end
    end
end
output = mask;