function  [t,l,h,w] = findMouth(mask)

%find mouth  but not efficient enough
%I just find the biggest non-skin color region
% if some light or shadow on the face
%and the mouth is small
%it will not work

%cbcr = rgb2ycbcr(mask);
%cbcr3 = cbcr(:, :, 3);

%init output
t = 1;
l = 1;
[h, w] = size(mask);

%figure, imshow(oriImg)

mask = (mask - 1) .* (-1);
%figure;imshow(mask );


%find the same region and label it
[L,num]=bwlabel(mask,8);
area=zeros(1,num+1);%area
zhonghengbi=zeros(1,num+1);%ratio
re1=zeros(num+1,2);
maxarea = 0;

for k=0:num
    [r,c]= find(L==k);
    re1(k+1,1)=max(r)-min(r);%height
    re1(k+1,2)=max(c)-min(c);%weight
    zhonghengbi(k+1)=re1(k+1,1)/re1(k+1,2);%height/weight
    if(re1(k+1,2)==0)
         zhonghengbi(k+1)=0;
     end%prevent single straight line
     area(k+1)=re1(k+1,1)*re1(k+1,2);
     
     %find some region that matching mouth condition
     if zhonghengbi(k+1)>0.1&&zhonghengbi(k+1)<1&&area(k+1)>maxarea
        maxarea = area(k+1);
        t = min(r);
        l = min(c);
        h = max(r);
        w = max(c);
     end
end




