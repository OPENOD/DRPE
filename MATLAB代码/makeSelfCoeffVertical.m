function varargout=makeSelfCoeffVertical(Img)
I=Img;
[M,N]=size(I);
m_y=ceil(8000/N);
m_y=ceil(N/m_y);
coff_y=0;
count=0;
for t=1:m_y
    x=double(I(:,t));
    y=double(I(:,t+1));
    coff_y=coff_y+abs(corr(x,y));
    count=count+1;
end
coff_y=coff_y/count;
varargout{1}=coff_y;