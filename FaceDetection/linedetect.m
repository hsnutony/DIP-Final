I=imread('normal.jpg');
figure, imshow(I)


Ihsv=rgb2hsv(I);
Ivl=Ihsv(:,:,3);                    %����v��?
Iedge=edge(Ivl,'sobel');    %?�u??
Iedge = imdilate(Iedge,ones(3));%?����?

%�s�ص��f�A??��
figure, imshow(Iedge);
figure, imshow(Iedge);
hold on

%���誽???�O?��
%�o���N�Ҫ�?
[H1,T1,R1] = hough(Iedge,'Theta',-90:90:0);

%�D���?
Peaks=houghpeaks(H1,100);

%�o��?�q�H��
lines=houghlines(Iedge,T1,R1,Peaks);

%?��?�q
 for k=1:length(lines)
xy=[lines(k).point1;lines(k).point2];   
plot(xy(:,1),xy(:,2),'LineWidth',4);
 end

 
 %�k�誽???�O?��
[H2,T2,R2] = hough(Iedge,'Theta',-75:0.1:-20);
Peaks1=houghpeaks(H2,5);
lines1=houghlines(Iedge,T2,R2,Peaks1);
for k=1:length(lines1)
xy1=[lines1(k).point1;lines1(k).point2];   
plot(xy1(:,1),xy1(:,2),'LineWidth',4);
end

hold off