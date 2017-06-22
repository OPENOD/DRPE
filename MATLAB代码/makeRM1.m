function flag=makeRM1(hObject, eventdata, handles)
global  OriginalIm ArnoldIm  EncryptionIm LogisticX LogisticU LogisticN RM1Im
h_fig=findall(0,'Type','figure','Tag','figure');
OriginalImFlag=getappdata(h_fig,'OriginalImFlag');
ArnoldImFlag=getappdata(h_fig,'ArnoldImFlag');
EncryptionImFlag=getappdata(h_fig,'EncryptionImFlag');
KeyFlag=getappdata(h_fig,'KeyFlag');
if OriginalImFlag==0
   msgbox('���ȴ�ԭʼͼ��',' Error'); 
   flag=0;
   return;
end
if KeyFlag==0
   msgbox('���ȴ���Կ��',' Error'); 
   flag=0;
   return;
end
if EncryptionImFlag
    Im=EncryptionIm;
elseif ArnoldImFlag
    Im=ArnoldIm;
else
    Im=OriginalIm;
end
[M,N]=size(Im);
count=M*N+LogisticN;
X=LogisticX;
for i=1:count
    X=LogisticU*X*(1-X);
    x_n(i)=X;
end

for i=1:M
    for j=1:N
        U(i,j)=x_n(LogisticN+i*j);
    end
end

U=mat2gray(U);
% U=mapminmax(U,0,1);
%�����λģ�庯��1
RM1Im=exp(2*1i*pi*U);
flag=1;
