function varargout=makeSelfCoeffDiagonal(Img)
I=Img;
[M,N]=size(I);
m_xy=ceil(8000/(sqrt(M*N)/2));
m_xy=ceil(M/m_xy);
coff_xy=0;
count=0;
for t=1:m_xy:M-1
    x=double(diag(I,t));
    if isempty(x)
        break;
    end
    y=double(diag(I,t+1));
    if length(x)>length(y)
        x(end)=[];
    end
    coff_xy=coff_xy+abs(corr(x,y));
    count=count+1;
end
coff_xy=coff_xy/count;
varargout{1}=coff_xy;