function  [t,l,h,w] = findMouth(mask)

%figure, imshow(oriImg)

mask = (mask - 1) .* (-1);
figure;imshow(mask );

[L,num]=bwlabel(mask,8);
area=zeros(1,num+1);%面積
zhonghengbi=zeros(1,num+1);%比例
re1=zeros(num+1,2);
maxarea = 0;
for k=0:num
    [r,c]= find(L==k);
    re1(k+1,1)=max(r)-min(r);%高度
    re1(k+1,2)=max(c)-min(c);%寬度
    zhonghengbi(k+1)=re1(k+1,1)/re1(k+1,2);%高寬比
    if(re1(k+1,2)==0)
         zhonghengbi(k+1)=0;
     end%防止出現單條垂直線的情況
     area(k+1)=re1(k+1,1)*re1(k+1,2);
     if zhonghengbi(k+1)>0.1&&zhonghengbi(k+1)<1&&area(k+1)>maxarea
        maxarea = area(k+1);
        t = min(r);
        l = min(c);
        h = max(r);
        w = max(c);
     end
end




