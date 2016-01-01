function [L,kk]=findlimit(L)

%l為已分類有序矩陣
%kk為特征區域的序號

tt=size(size(L));
if tt(2)==3  %若I為3維矩陣，則需要轉換為灰度圖像
    J=rgb2gray(L);
else        %I為3維矩陣
    J=L;
end

%[m,n]=size(J);


%找鄰居 將鄰居標成同一個區塊
[L,num]=bwlabel(J,8);
area=zeros(1,num+1);%面積
zhonghengbi=zeros(1,num+1);%比例
eyechk=zeros(1,num+1);%眼睛
re1=zeros(num+1,2);
for k=0:num
    [r,c]= find(L==k);
     % re(k+1,1)=min(r);     %垂直方向最小值（上）
     % re(k+1,2)=max(r);    %垂直方向最大值（下）
     % re(k+1,3)=min(c);     %水平方向最小值（左）
     % re(k+1,4)=max(c);    %水平方向最大值（右）
     re1(k+1,1)=max(r)-min(r);%高度
     re1(k+1,2)=max(c)-min(c);%寬度
     zhonghengbi(k+1)=re1(k+1,1)/re1(k+1,2);%高寬比
     eyechk(k+1) = chkeye(J, min(r), min(c), re1(k+1,1), re1(k+1,2));
     if(re1(k+1,2)==0)
         zhonghengbi(k+1)=0;
     end%防止出現單條垂直線的情況
     area(k+1)=re1(k+1,1)*re1(k+1,2);
end

%檢查符合人臉的區塊
%判斷比例 面積 有沒有像眼睛的東西

j=1;
for i=1:num+1
    if zhonghengbi(i)>0.2&&zhonghengbi(i)<3&&area(i)>15000&&eyechk(i)>0
%高寬比設置為0.2~3.0之間，面積認為大於1000，注意面積為隨機項，與圖片大小有很大的關系
       kk(j)=i-1;
       j=j+1;
    end
end
