function makeAPCD(Img)
[m n]=size(Img);
for i=1:66:m
    for j=1:n-1
        plot(abs(Img(i,j)),abs(Img(i,j+1)),'*');
        hold on
    end
end
% title('ˮƽ�����������طֲ�ͼ');
xlabel('(i,j)�������ֵ');
ylabel('(i,j+1)�������ֵ');