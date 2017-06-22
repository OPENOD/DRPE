function flag=iMakeArnold(hObject, eventdata, handles)
global ArnoldCount DecryptionIm;
h_fig=findall(0,'Type','figure','Tag','figure');
EncryptionImFlag=getappdata(h_fig,'EncryptionImFlag');
KeyFlag=getappdata(h_fig,'KeyFlag');
if EncryptionImFlag==0
   msgbox('请先打开加密图！',' Error'); 
   flag=0;
   return;
end
if KeyFlag==0
   msgbox('请先打开密钥！',' Error'); 
   flag=0;
   return;
end
I=DecryptionIm;
Arnold_a=1;
Arnold_b=1;
Arnold_c=1;
Arnold_d=2;
c=[Arnold_a,Arnold_b;Arnold_c,Arnold_d];
c=inv(c);
[M,N]=size(I);

% if varargin{2}==0
%     str=inputdlg('Arnold迭代次数','请输入Arnold迭代次数',1,{'2'},'on');
%     ArnoldCount =str2num(str{1});
% end

result=I;
for q=1:ArnoldCount
    if M==N
        for i=1 :M
            for j=1:N
                temp=c*[i;j];
                m=mod(temp(1),M);
                n=mod(temp(2),N);
                if m==0
                    m=M;
                end
                if n==0
                    n=N;
                end
                result(m,n)=I(i,j);
            end
        end
        I=result;
    elseif M<N
        t_floor=floor(N/M);
        t_mod=mod(N,M);
        if t_mod>floor(M/2)
            count=t_floor+2;
        else
            count=t_floor+1;
        end
        for q_1=1:count
            if q_1==1
                n_1=N-M+1;
                n_2=N;
            elseif q_1>1 && q_1<count
                n_1=int32(M*(count-q_1)+1-floor(M/2));
                n_2=int32(M*(count-q_1)+M-floor(M/2));
            else
                n_1=1;
                n_2=M;
            end
            result_t=result(1:M,n_1:n_2);
            I=result_t;
            for i=1:M
                for j=1:M
                    temp=c*[i;j];
                    m=mod(temp(1),M);
                    n=mod(temp(2),M);
                    if m==0
                        m=M;
                    end
                    if n==0
                        n=M;
                    end
                    result_t(m,n)=I(i,j);
                end
            end
            result(1:M,n_1:n_2)=result_t;
        end
    else
        t_floor=floor(M/N);
        t_mod=mod(M,N);
        if t_mod>floor(N/2)
            count=t_floor+2;
        else
            count=t_floor+1;
        end
        for q_1=1:count
            if q_1==1
                m_1=M-N+1;
                m_2=M;  
            elseif q_1>1 && q_1<count
                m_1=int32(N*(q_1-1)+1-floor(N/2));
                m_2=int32(N*(q_1-1)+N-floor(N/2));
            else
                m_1=1;
                m_2=N;
            end
            result_t=result(m_1:m_2,1:N);
            I=result_t;
            for i=1:N
                for j=1:N
                    temp=c*[i;j];
                    m=mod(temp(1),N);
                    n=mod(temp(2),N);
                    if m==0
                        m=N;
                    end
                    if n==0
                        n=N;
                    end
                    result_t(m,n)=I(i,j);
                end
            end
            result(m_1:m_2,1:N)=result_t;
        end
    end
end
DecryptionIm=result;
flag=1;