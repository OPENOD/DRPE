function varargout=makeSelfCoeffHorizontal(Img)
I=Img;
[M,N]=size(I);
m_x=ceil(8000/M);
m_x=ceil(M/m_x);
coff_x=0;
count=0;
for t=1:m_x
    x=double(I(t,:)');
    y=double(I(t+1,:)');
    coff_x=coff_x+abs(corr(x,y));
    count=count+1;
end
coff_x=coff_x/count;
varargout{1}=coff_x;