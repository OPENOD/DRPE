function makeEnterKey(hObject, eventdata, handles)
global ArnoldCount LogisticX LogisticU LogisticN ChenX ChenY ChenZ ChenC ChenH ChenT ChenN;
% % SZ=get(0,'ScreenSize');
% % h=figure('menubar','none','position',[SZ(3)/5,SZ(4)/5,600,400],'units','normalized');
% % str='<html>adfasdf</html>';
% % hText=uicontrol(h,'style','edit','string',str,'fontsize',10,'position',[100 350 70 60]);
% % 

prompt = {'ArnoldCount(>=0):','LogisticX():','LogisticU():','LogisticN():','ChenX():','ChenY():','ChenZ():','ChenC():','ChenH():','ChenT():','ChenN():'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {num2str(ArnoldCount),num2str(LogisticX),num2str(LogisticU),num2str(LogisticN), num2str(ChenX),num2str(ChenY),num2str(ChenZ),num2str(ChenC),num2str(ChenH),num2str(ChenT),num2str(ChenN)};
% defaultans = {num2str(ArnoldCount),LogisticX,LogisticU,LogisticN, ChenX,ChenY,ChenZ,ChenC,ChenH,ChenT,ChenN};
% defaultans = {'8', '0.5','3.9','500', '2','1','3','28','0.001','0','2000'};
k= inputdlg(prompt,dlg_title,num_lines,defaultans);
if isempty(k)
    return;
end
key(11)=0;
for i=1:11
    key(i)=str2num(k{i});
end
ArnoldCount=key(1);
LogisticX=key(2);
LogisticU=key(3);
LogisticN=key(4);
ChenX=key(5);
ChenY=key(6);
ChenZ=key(7);
ChenC=key(8);
ChenH=key(9);
ChenT=key(10);
ChenN=key(11);
setappdata(handles.figure,'KeyFlag',true);