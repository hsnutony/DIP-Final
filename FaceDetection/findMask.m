function output = findMask(cut_face, cut_mask)

%draw the face eyes mouth 's edge line

%arg can be modify
faceline = drawline(cut_face, 2, 5, 0.25, 0.5);

[p, q] = size(cut_mask);

%find mouth region
%same method as findFace
[t,l,h,w] = findMouth(cut_mask);
%arg can be modify
mouthline = drawline(cut_face(t : h, l : w, :), 1, 3, 0.2, 0.5);

%figure;imshow(mouthline);

%fit size
mouth = zeros(p, q);
for i = 0 : (h-t)
    for j = 0 : (w-l)
            mouth(i+t, j+l) = mouthline(i+1, j+1);
            faceline(i+t, j+l) = 0;
    end
end

%combine face and mouth edge line 
faceline = mouth + faceline;

output = faceline;