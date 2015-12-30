function output = findFace(oriImg, tlow, thigh)

%figure, imshow(oriImg)

%get size
[m, n, ~] = size(oriImg);

mask = detectSkin(oriImg, tlow, thigh);

%figure;imshow(mask);

fmask = imfill(mask);
%figure;imshow(fmask);

for i = 1 : m
    chk_s = [0, 0];
    chk_e = [0, 0];
    inpart = 0;
    partnum = 1;
    partsum = [0, 0];
    for j = 1 : n
        if((fmask(i, j) == 255)&&(inpart ==0))
            chk_s(partnum) = j;
            inpart = 1;
        elseif((fmask(i, j)==0)&&(inpart ==1))
            chk_e(partnum) = j;
            partsum(partnum) = sum(fmask(i, chk_s(partnum) : chk_e(partnum)));
            partnum = partnum + 1;
            if((partnum == 3))
                if(partsum(1) < partsum(2))
                    for k = chk_s(1) : chk_e(1)
                        fmask(i, k) = 0;
                    end
                    chk_s(1) = chk_s(2);
                    chk_e(1) = chk_e(2);
                    partsum(1) = partsum(2);
                else
                    for k = chk_s(2) : chk_e(2)
                        fmask(i, k) = 0;
                    end
                end
                partnum = 2;
            end
            inpart = 0;
        end
    end
end
%figure;imshow(fmask);


ui8_mask = uint8(fmask/255);
mask_3d = repmat(ui8_mask, [1, 1, 3]);
faceimg = oriImg .* mask_3d;
figure;imshow(faceimg);


flag = 0;
for i=1:m
    if((sum(fmask(i,:)) > 0)&&(flag == 0))
        top = i;
        flag = 1;
    elseif((sum(fmask(i,:)) == 0)&&(flag == 1))
            down = i;
            flag = 0;
    end
end

for i=1:n
    if((sum(fmask(:,i)) > 0)&&(flag == 0))
        left = i;
        flag = 1;
    elseif((sum(fmask(:,i)) == 0)&&(flag == 1))
            right = i;
            flag = 0;
    end
end
mask = mask & fmask;
cut_face = faceimg(top:down,left:right,:);
cut_mask = mask(top:down,left:right,:);


faceline = drawline(cut_face, 2, 5, 0.25, 0.5);


[p, q] = size(cut_mask);
[t,l,h,w] = findMouth(cut_mask);
mouthline = drawline(cut_face(t-5 : h+5, l-5 : w+5, :), 1, 3, 0.2, 0.5);

figure;imshow(mouthline);

mouth = zeros(p, q);
for i = 0 : (h-t+10)
    for j = 0 : (w-l+10)
            mouth(i+t-5, j+l-5) = mouthline(i+1, j+1);
            faceline(i+t-5, j+l-5) = 0;
    end
end

faceline = mouth + faceline;
pad = zeros(m, n);

for i = 0 : (down - top)
    for j = 0 : (right - left)
            pad(top + i, left + j) = faceline(i+1, j+1);
    end
end

output = pad;

