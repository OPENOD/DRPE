function varargout=makeImentropy(Img)
I=abs(Img);
p = imhist(I);
p(p==0) = [ ];
p = p ./ numel(I);
H=-sum(p.*log2(p));
varargout{1}=num2str(H);

