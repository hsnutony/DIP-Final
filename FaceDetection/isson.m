function x=isson(y,I)

%抄來的
%檢查是不是在區塊內吧

x=0;
z=size(I);
for i=1:z(2)
    if(y==I(i))
        x=1;
        break;
    end
end
