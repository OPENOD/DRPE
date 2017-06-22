function flag=makeDRPE(hObject, eventdata, handles)
global OriginalIm ArnoldIm RM1Im RM2Im EncryptionIm;
h_fig=findall(0,'Type','figure','Tag','figure');
OriginalImFlag=getappdata(h_fig,'OriginalImFlag');
KeyFlag=getappdata(h_fig,'KeyFlag');
ArnoldImFlag=getappdata(h_fig,'ArnoldImFlag');
makeRM1Flag=getappdata(h_fig,'makeRM1Flag');
makeRM2Flag=getappdata(h_fig,'makeRM2Flag');
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
if makeRM1Flag==0
    flag=makeRM1(hObject, eventdata, handles);
    if flag==0
        return;
    end
    setappdata(h_fig,'makeRM1Flag',true);
end
if makeRM2Flag==false
    flag=makeRM2(hObject, eventdata, handles);
    if flag==0
        return;
    end
    setappdata(h_fig,'makeRM2Flag',true);
end    
if ArnoldImFlag
    Img=ArnoldIm;
else
    Img=OriginalIm;
end
EncryptionIm=ifft2(fft2((double(Img)).*RM1Im).*RM2Im);
flag=1;