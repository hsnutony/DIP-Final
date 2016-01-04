function [ blurred, Matched, Mask ] = cropFace( blur_img, Matched )

[bm, bn, ~] = size(blur_img);
[cm, cn, ~] = size(Matched);

%crop face region
[b_range, ~, ~] = findFace(blur_img, 135, 150);
%Matched = imcrop(Matched);
[c_range, cut_nbface, cut_mask] = findFace(Matched, 143, 160);
figure, imshow(cut_nbface);
bh = b_range.down - b_range.top;
bw = b_range.right - b_range.left;
b_min_ho = [fix(bh/6), b_range.top - 1, bm - b_range.down];
bh_offset = min(b_min_ho);
bw_offset =fix(((bh + 2*bh_offset)/(5/4) - bw )/2);
b_min_wo = [bw_offset, b_range.left - 1, bn - b_range.right];
bw_offset = min(b_min_wo);

b_range.top = b_range.top - bh_offset;
b_range.down = b_range.down + bh_offset;
b_range.left = b_range.left - bw_offset;
b_range.right = b_range.right + bw_offset;

ch = c_range.down - c_range.top;
cw = c_range.right - c_range.left;
c_min_ho = [fix(ch/6), c_range.top - 1, cm - c_range.down];
ch_offset = min(c_min_ho);
cw_offset =fix(((ch + 2*ch_offset)/(5/4) - cw )/2);
c_min_wo = [cw_offset, c_range.left - 1, cn - c_range.right];
cw_offset = min(c_min_wo);

c_range.top = c_range.top - ch_offset;
c_range.down = c_range.down + ch_offset;
c_range.left = c_range.left - cw_offset;
c_range.right = c_range.right + cw_offset;


blur_face = blur_img( b_range.top : b_range.down, b_range.left : b_range.right, :);
Matched = Matched( c_range.top : c_range.down, c_range.left : c_range.right, :);

%blur_face = imcrop(blur_img);
figure, imshow(blur_face)
%[p, q, ~] = size(blur_face);
blurred = rgb2gray(blur_face);
blurred = im2double(blurred);

%crop face region

%map size
%Matched = imresize(Matched, [p q]);
%cut_nbface = imresize(cut_nbface, [p q]);
%cut_mask = imresize(cut_mask, [p q]);
[p, q, ~] = size(Matched);
blurred = imresize(blurred, [p q]);
%find Mask
Mask = findMask(cut_nbface, cut_mask);
Mask = Mask( c_range.top : c_range.down, c_range.left : c_range.right);
figure, imshow(Matched)
figure, imshow(Mask)

Mask = im2double(Mask);

end

