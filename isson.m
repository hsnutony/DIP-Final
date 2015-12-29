function x=isson(y,I)
x=0;
z=size(I);
for i=1:z(2)
    if(y==I(i))
        x=1;
        break;
    end
end
