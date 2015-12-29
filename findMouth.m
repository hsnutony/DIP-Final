function  [t,l,h,w] = findMouth(mask)

%figure, imshow(oriImg)

mask = (mask - 1) .* (-1);
figure;imshow(mask );

[L,num]=bwlabel(mask,8);
area=zeros(1,num+1);%���n
zhonghengbi=zeros(1,num+1);%���
re1=zeros(num+1,2);
maxarea = 0;
for k=0:num
    [r,c]= find(L==k);
    re1(k+1,1)=max(r)-min(r);%����
    re1(k+1,2)=max(c)-min(c);%�e��
    zhonghengbi(k+1)=re1(k+1,1)/re1(k+1,2);%���e��
    if(re1(k+1,2)==0)
         zhonghengbi(k+1)=0;
     end%����X�{��������u�����p
     area(k+1)=re1(k+1,1)*re1(k+1,2);
     if zhonghengbi(k+1)>0.1&&zhonghengbi(k+1)<1&&area(k+1)>maxarea
        maxarea = area(k+1);
        t = min(r);
        l = min(c);
        h = max(r);
        w = max(c);
     end
end




