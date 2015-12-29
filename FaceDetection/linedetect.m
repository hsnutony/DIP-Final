I=imread('normal.jpg');
figure, imshow(I)


Ihsv=rgb2hsv(I);
Ivl=Ihsv(:,:,3);                    %提取v空?
Iedge=edge(Ivl,'sobel');    %?沿??
Iedge = imdilate(Iedge,ones(3));%?像膨?

%新建窗口，??用
figure, imshow(Iedge);
figure, imshow(Iedge);
hold on

%左方直???与?制
%得到霍夫空?
[H1,T1,R1] = hough(Iedge,'Theta',-90:90:0);

%求极值?
Peaks=houghpeaks(H1,100);

%得到?段信息
lines=houghlines(Iedge,T1,R1,Peaks);

%?制?段
 for k=1:length(lines)
xy=[lines(k).point1;lines(k).point2];   
plot(xy(:,1),xy(:,2),'LineWidth',4);
 end

 
 %右方直???与?制
[H2,T2,R2] = hough(Iedge,'Theta',-75:0.1:-20);
Peaks1=houghpeaks(H2,5);
lines1=houghlines(Iedge,T2,R2,Peaks1);
for k=1:length(lines1)
xy1=[lines1(k).point1;lines1(k).point2];   
plot(xy1(:,1),xy1(:,2),'LineWidth',4);
end

hold off