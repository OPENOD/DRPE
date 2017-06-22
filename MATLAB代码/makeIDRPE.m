function flag=makeIDRPE(hObject, eventdata, handles)
global  RM1Im RM2Im EncryptionIm DecryptionIm;
h_fig=findall(0,'Type','figure','Tag','figure');
KeyFlag=getappdata(h_fig,'KeyFlag');
ArnoldImFlag=getappdata(h_fig,'ArnoldImFlag');
makeRM1Flag=getappdata(h_fig,'makeRM1Flag');
makeRM2Flag=getappdata(h_fig,'makeRM2Flag');
if KeyFlag==0
   msgbox('ÇëÏÈ´ò¿ªÃÜÔ¿£¡',' Error'); 
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
if makeRM2Flag==0
    flag=makeRM2(hObject, eventdata, handles);
    if flag==0
        return;
    end
    setappdata(h_fig,'makeRM2Flag',true);
end   
DecryptionIm=ifft2(fft2(double(EncryptionIm)).*conj(double(RM2Im))).*conj(double(RM1Im));
if ArnoldImFlag
    flag=iMakeArnold(hObject, eventdata, handles);
    if flag==0
        return;
    end
end
flag=1;