function [L,kk]=findlimit(L)

%l���w�������ǯx�}
%kk���S���ϰ쪺�Ǹ�

tt=size(size(L));
if tt(2)==3  %�YI��3���x�}�A�h�ݭn�ഫ���ǫ׹Ϲ�
    J=rgb2gray(L);
else        %I��3���x�}
    J=L;
end

%[m,n]=size(J);


%��F�~ �N�F�~�Ц��P�@�Ӱ϶�
[L,num]=bwlabel(J,8);
area=zeros(1,num+1);%���n
zhonghengbi=zeros(1,num+1);%���
eyechk=zeros(1,num+1);%����
re1=zeros(num+1,2);
for k=0:num
    [r,c]= find(L==k);
     % re(k+1,1)=min(r);     %������V�̤p�ȡ]�W�^
     % re(k+1,2)=max(r);    %������V�̤j�ȡ]�U�^
     % re(k+1,3)=min(c);     %������V�̤p�ȡ]���^
     % re(k+1,4)=max(c);    %������V�̤j�ȡ]�k�^
     re1(k+1,1)=max(r)-min(r);%����
     re1(k+1,2)=max(c)-min(c);%�e��
     zhonghengbi(k+1)=re1(k+1,1)/re1(k+1,2);%���e��
     eyechk(k+1) = chkeye(J, min(r), min(c), re1(k+1,1), re1(k+1,2));
     if(re1(k+1,2)==0)
         zhonghengbi(k+1)=0;
     end%����X�{��������u�����p
     area(k+1)=re1(k+1,1)*re1(k+1,2);
end

%�ˬd�ŦX�H�y���϶�
%�P�_��� ���n ���S�����������F��

j=1;
for i=1:num+1
    if zhonghengbi(i)>0.2&&zhonghengbi(i)<3&&area(i)>15000&&eyechk(i)>0
%���e��]�m��0.2~3.0�����A���n�{���j��1000�A�`�N���n���H�����A�P�Ϥ��j�p���ܤj�����t
       kk(j)=i-1;
       j=j+1;
    end
end
