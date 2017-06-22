function makeAPCD(Img)
[m n]=size(Img);
for i=1:66:m
    for j=1:n-1
        plot(abs(Img(i,j)),abs(Img(i,j+1)),'*');
        hold on
    end
end
% title('水平方向相邻像素分布图');
xlabel('(i,j)点的像素值');
ylabel('(i,j+1)点的像素值');