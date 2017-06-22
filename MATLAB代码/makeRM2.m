function flag=makeRM2(hObject, eventdata, handles)
global  OriginalIm ArnoldIm EncryptionIm ChenX ChenY ChenZ ChenC ChenH ChenT ChenN RM2Im;
h_fig=findall(0,'Type','figure','Tag','figure');
OriginalImFlag=getappdata(h_fig,'OriginalImFlag');
ArnoldImFlag=getappdata(h_fig,'ArnoldImFlag');
EncryptionImFlag=getappdata(h_fig,'EncryptionImFlag');
KeyFlag=getappdata(h_fig,'KeyFlag');
if OriginalImFlag==0
   msgbox('请先打开原始图像！',' Error'); 
   flag=0;
   return;
end
if KeyFlag==0
   msgbox('请先打开密钥！',' Error'); 
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
x_0=[ChenX ChenY ChenZ]; 
t_n=ceil(M*N/1000)+2;%终止时间点
a=35; b=3; ChenC=28;
% [t,result]=ode45(@Chen,t_0:h:t_n,x_0);
[t,result] = ode45(@(t,y) [a*y(2,:)-a*y(1,:)
           (ChenC-a)*y(1,:)+ChenC*y(2,:)-y(1,:)*y(3,:)
           y(1,:)*y(2,:)-b*y(3,:)], ChenT:ChenH:t_n,x_0);

x=result(ChenN:M*N+ChenN,1);
y=result(ChenN:M*N+ChenN,2);
z=result(ChenN:M*N+ChenN,3);
x_n(M*N)=0;
for i=1:M*N
    s=mod(i,3);
    switch s
        case 0
            x_n(i)=x(i);
        case 1
            x_n(i)=y(i);
        case 2
            x_n(i)=z(i);
        otherwise
                 disp('生成RM2失败！')
    end
    
end

for i=1:M
    for j=1:N
        u(i,j)=x_n(i*j);
    end
end

u=mat2gray(u);
% u=mapminmax(u,0,1);
result=exp(2*1i*pi*u);

RM2Im=result;
flag=1;
