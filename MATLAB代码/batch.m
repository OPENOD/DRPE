function varargout = batch(varargin)
% BATCH MATLAB code for batch.fig
%      BATCH, by itself, creates a new BATCH or raises the existing
%      singleton*.
%
%      H = BATCH returns the handle to a new BATCH or the handle to
%      the existing singleton*.
%
%      BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCH.M with the given input arguments.
%
%      BATCH('Property','Value',...) creates a new BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help batch

% Last Modified by GUIDE v2.5 10-Jun-2017 22:49:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @batch_OpeningFcn, ...
    'gui_OutputFcn',  @batch_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before batch is made visible.
function batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batch (see VARARGIN)

% Choose default command line output for batch
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

h_fig=findall(0,'Type','figure','Tag','figure');
setappdata(h_fig,'KeyFlag',true);
setappdata(handles.figureBatch,'SelectSoureFileFlag',false);
setappdata(handles.figureBatch,'OpenKeyFlag',false);
setappdata(handles.figureBatch,'ResultDirFlag',false);

% UIWAIT makes batch wait for user response (see UIRESUME)
% uiwait(handles.figureBatch);


% --- Outputs from this function are returned to the command line.
function varargout = batch_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function pushbuttonOpenKey_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile( ...
    {'*.csv;*.txt','Image Files ( *.csv,*.txt)'; ...
    '*.*','All Files (*.*)'}, ...
    'Pick an image');
if isequal(filename,0) || isequal(pathname,0)
    return;
end
fpath=[pathname filename];%将文件名和目录名组合成一个完整的路径
k=importdata(fpath);
key=k.data;
global ArnoldCount LogisticX LogisticU LogisticN ChenX ChenY ChenZ ChenC ChenH ChenT ChenN;
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
set(handles.textOpenKey,'string',fpath);
set(handles.uitableKey,'data',{'ArnoldCount','LogisticX','LogisticU','LogisticN';ArnoldCount,LogisticX,LogisticU,LogisticN;
                                'ChenX','ChenY','ChenZ','LogisticN';ChenX,ChenY,ChenZ,ChenC;
                                'ChenH','ChenT','ChenN','';ChenH,ChenT,ChenN,'';},'ColumnEditable',false);
setappdata(handles.figureBatch,'OpenKeyFlag',1);





function pushbuttonResultDir_Callback(hObject, eventdata, handles)
global ResultDir;
ResultDir=uigetdir({},'选择文件夹');  
ResultDir=strcat(ResultDir,'\');
set(handles.textResultDir,'string',ResultDir);
setappdata(handles.figureBatch,'ResultDirFlag',1);


function pushbuttonSelectSoureFile_Callback(hObject, eventdata, handles)
[tfilename, tpathname] = uigetfile( ...
    {'*.jpg;*.bmp;*.png;*.jpeg;*mat','Image Files ( *.jpg,*.bmp, *.png,*.jpeg,*.mat)'; ...
    '*.*','All Files (*.*)'}, ...
    'Pick an image','MultiSelect','on');
if isequal(tfilename,0) || isequal(tpathname,0)
    return;
end
global filename pathname fpath;
if ischar(tfilename)
    tfpath=[tpathname tfilename];%将文件名和目录名组合成一个完整的路径
    filename=tfilename;
    pathname=tpathname;
    fpath=tfpath;
elseif iscell(tfilename)
    for i=1:length(tfilename)
        tfpath{i}=strcat(tpathname,tfilename{i});%将文件名和目录名组合成一个完整的路径
    end
    filename=tfilename;
    pathname=tpathname;
    fpath=tfpath;
else
    msgbox('文件打开出错！请重新打开。’,‘出错');
    return;
end

strfilename = char(filename);
set(handles.textSelectSoureFile,'string',pathname);
set(handles.listboxSelectSoureFile,'string',strfilename);
setappdata(handles.figureBatch,'SelectSoureFileFlag',true);

h_fig=findall(0,'Type','figure','Tag','figure');
setappdata(h_fig,'OriginalImFlag',true);
setappdata(h_fig,'DecryptionImFlag',true);



function listboxSelectSoureFile_CreateFcn(hObject, eventdata, handles)

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editResultFileName1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenuFileName1_Callback(hObject, eventdata, handles)
global filename;
if isempty(filename)
    firstname='源文件';
elseif ischar(filename)
    iIndex=strfind(filename,'.');
    firstname=filename(1:iIndex-1);
else
    firstname=char(filename(1));
    iIndex=strfind(firstname,'.');
    firstname=firstname(1:iIndex-1);
end
sel=get(hObject,'Value');
switch sel
    case 1
        str=strcat('示例：','001');
        set(handles.editResultFileName1,'string','001');
        set(handles.textResultFileDeo,'string',str);
    case 2
        str=strcat('示例：',firstname);
        set(handles.editResultFileName1,'string',firstname);
        set(handles.textResultFileDeo,'string',str);
end

function popupmenuFileName1_CreateFcn(hObject, eventdata, handles)


function pushbuttonBatchEncryptionIm_Callback(hObject, eventdata, handles)
global OriginalIm EncryptionIm filename pathname ResultDir;
SelectSoureFileFlag=getappdata(handles.figureBatch,'SelectSoureFileFlag');
OpenKeyFlag=getappdata(handles.figureBatch,'OpenKeyFlag');
ResultDirFlag=getappdata(handles.figureBatch,'ResultDirFlag');
if SelectSoureFileFlag==0
    msgbox('请先打开源文件','warn')
    return;
end
if OpenKeyFlag==0
    msgbox('请先打开密钥','warn')
    return;
end
if ResultDirFlag==0
    msgbox('请先选择目标文件夹','warn')
    return;
end
fpath=[pathname filename];%将文件名和目录名组合成一个完整的路径
if ischar(filename)
    try
        Img=imread(fpath);
    catch ME
        msgbox(ME.message,'error');
        return;
    end
    pro=0/length(1);
    strbar=strcat('加密完成:','0','/',num2str(1));
    hWaitbar=waitbar(pro,strbar,'name','解密进度条');
    OriginalIm=Img;
    if length(size(OriginalIm))==3
        OriginalIm=rgb2gray(OriginalIm);
    end
    OriginalIm=im2double(OriginalIm);
        h_fig=findall(0,'Type','figure','Tag','figure');
        setappdata(h_fig,'makeRM1Flag',false);
        setappdata(h_fig,'makeRM2Flag',false);
        setappdata(h_fig,'makeArnoldFlag',false);
        setappdata(h_fig,'EncryptionImFlag',false);
         flag=makeArnold(hObject, eventdata, handles);
        if flag==0
            return;
        else
            h_fig=findall(0,'Type','figure','Tag','figure');
            setappdata(h_fig,'makeArnoldFlag',true);
        end
    
    flag=makeRM1(hObject, eventdata, handles);
    if flag==0
        return;
    else
        h_fig=findall(0,'Type','figure','Tag','figure');
        setappdata(h_fig,'makeRM1Flag',true);
    end
    flag=makeRM2(hObject, eventdata, handles);
    if flag==0
        return;
    else
        h_fig=findall(0,'Type','figure','Tag','figure');
        setappdata(h_fig,'makeRM2Flag',true);
    end
    makeDRPE(hObject, eventdata, handles);
    
    %保存加密文件
    nname=filename;
    iIndex=strfind(nname,'.');
    nname=nname(1:iIndex-1);
    sel1=get(handles.popupmenuFileName1,'Value');
        switch sel1
            case 1
                str='001';
            case 2
                str=nname;
        end
        sel2=get(handles.popupmenuFileName2,'Value');
         switch sel2
            case 1
                str=strcat(str,nname);       
             case 2
                 str=strcat(str,'001');
             case 3
                 str=strcat(str,'.jpg');
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
         end
         sel3=get(handles.popupmenuFileName3,'Value');
         switch sel3
            case 1
                str=strcat(str,'.jpg');         
             case 2
                 str=strcat(str,'001');
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
         end
         sel4=get(handles.popupmenuFileName4,'Value');
         switch sel4
            case 1
                str=strcat(str,'');         
             case 2
                 str=strcat(str,'001');
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
             case 7
                 str=strcat(str,'.jpg');
         end
         sel5=get(handles.popupmenuFileName5,'Value');
         switch sel5
            case 1
                str=strcat(str,'');         
             case 2
                 str=strcat(str,'001');
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
             case 7
                 str=strcat(str,'.jpg');
         end
         str=strcat(ResultDir,str);
         fwritepath=char(str);
         save(fwritepath,'EncryptionIm');
         strbar=strcat('加密进度:',num2str(1),'/',num2str(1));
         pro=1/1;
         waitbar(pro,hWaitbar,strbar);
         pause(0.5);
         delete(hWaitbar);
         clear hWaitbar;

else
    pro=0/length(filename);
    strbar=strcat('加密完成:','0','/',num2str(length(filename)));
    hWaitbar=waitbar(pro,strbar,'name','加密进度条');
    for i=1:length(filename)
        strbar=strcat('加密进度:',num2str(i),'/',num2str(length(filename)));
        pro=i/length(filename);
        waitbar(pro,hWaitbar,strbar);
        tfpath=strcat(fpath(1),fpath(i+1));
        tfpath=char(tfpath);
        OriginalIm=imread(tfpath);
        if length(size(OriginalIm))==3
            OriginalIm=rgb2gray(OriginalIm);
        end
        OriginalIm=im2double(OriginalIm);
        h_fig=findall(0,'Type','figure','Tag','figure');
        setappdata(h_fig,'makeRM1Flag',false);
        setappdata(h_fig,'makeRM2Flag',false);
        setappdata(h_fig,'makeArnoldFlag',false);
        setappdata(h_fig,'EncryptionImFlag',false);
        flag=makeArnold(hObject, eventdata, handles);
        if flag==0
            return;
        else
            h_fig=findall(0,'Type','figure','Tag','figure');
            setappdata(h_fig,'makeArnoldFlag',true);
        end
        flag=makeRM1(hObject, eventdata, handles);
        if flag==0
            return;
        else
            h_fig=findall(0,'Type','figure','Tag','figure');
            setappdata(h_fig,'makeRM1Flag',true);
        end
        flag=makeRM2(hObject, eventdata, handles);
        if flag==0
            return;
        else
            h_fig=findall(0,'Type','figure','Tag','figure');
            setappdata(h_fig,'makeRM2Flag',true);
        end
        flag=makeDRPE(hObject, eventdata, handles);
        if flag==0
            return;
        end
        
        %保存加密文件
        nname=filename(i);
        nname=char(nname);
        iIndex=strfind(nname,'.');
        nname=nname(1:iIndex-1);
        sel1=get(handles.popupmenuFileName1,'Value');
        switch sel1
            case 1
                if i<10
                    str=strcat('00',num2str(i));
                elseif i<100
                    str=strcat('0',num2str(i));
                else
                    str=num2str(i);
                end
            case 2
                str=nname;
        end
        sel2=get(handles.popupmenuFileName2,'Value');
         switch sel2
            case 1
                str=strcat(str,nname);       
             case 2
                if i<10
                    tstr=strcat('00',num2str(i));
                elseif i<100
                    tstr=strcat('0',num2str(i));
                else
                    tstr=num2str(i);
                end           
                 str=strcat(str,tstr);
             case 3
                 str=strcat(str,'.jpg');
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
         end
         sel3=get(handles.popupmenuFileName3,'Value');
         switch sel3
            case 1
                str=strcat(str,'.jpg');         
             case 2
                if i<10
                    tstr=strcat('00',num2str(i));
                elseif i<100
                    tstr=strcat('0',num2str(i));
                else
                    tstr=num2str(i);
                end           
                 str=strcat(str,tstr);
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
         end
         sel4=get(handles.popupmenuFileName4,'Value');
         switch sel4
            case 1
                str=strcat(str,'');         
             case 2
                if i<10
                    tstr=strcat('00',num2str(i));
                elseif i<100
                    tstr=strcat('0',num2str(i));
                else
                    tstr=num2str(i);
                end           
                 str=strcat(str,tstr);
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
             case 7
                 str=strcat(str,'.jpg');
         end
         sel5=get(handles.popupmenuFileName5,'Value');
         switch sel5
            case 1
                str=strcat(str,'');         
             case 2
                if i<10
                    tstr=strcat('00',num2str(i));
                elseif i<100
                    tstr=strcat('0',num2str(i));
                else
                    tstr=num2str(i);
                end           
                 str=strcat(str,tstr);
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
             case 7
                 str=strcat(str,'.jpg');
         end
        str=strcat(ResultDir,str);
        fwritepath=char(str);
        save(fwritepath,'EncryptionIm');
    end
    delete(hWaitbar);
    clear hWaitbar;
end

function pushbuttonBatchDecryptionIm_Callback(hObject, eventdata, handles)
global OriginalIm ArnoldIm EncryptionIm DecryptionIm filename pathname ResultDir;
SelectSoureFileFlag=getappdata(handles.figureBatch,'SelectSoureFileFlag');
OpenKeyFlag=getappdata(handles.figureBatch,'OpenKeyFlag');
ResultDirFlag=getappdata(handles.figureBatch,'ResultDirFlag');
if SelectSoureFileFlag==0
    msgbox('请先打开源文件','warn')
    return;
end
if OpenKeyFlag==0
    msgbox('请先打开密钥','warn')
    return;
end
if ResultDirFlag==0
    msgbox('请先选择目标文件夹','warn')
    return;
end
fpath=[pathname filename];%将文件名和目录名组合成一个完整的路径
if ischar(filename)
    try
        load(fpath,'-mat');
    catch
        msgbox('输入的源文件不能进行解密，请输入*.mat文件！','error');
        return;
    end
    pro=0/length(1);
    strbar=strcat('解密完成:','0','/',num2str(1));
    hWaitbar=waitbar(pro,strbar,'name','解密进度条');
    OriginalIm=EncryptionIm;
    ArnoldIm=EncryptionIm;
    h_fig=findall(0,'Type','figure','Tag','figure');
    setappdata(h_fig,'makeRM1Flag',false);
    setappdata(h_fig,'makeRM2Flag',false);
    setappdata(h_fig,'makeArnoldFlag',false);
    setappdata(h_fig,'EncryptionImFlag',true);
    
    flag=makeRM1(hObject, eventdata, handles);
    if flag==0
        return;
    else
        h_fig=findall(0,'Type','figure','Tag','figure');
        setappdata(h_fig,'makeRM1Flag',true);
    end
    flag=makeRM2(hObject, eventdata, handles);
    if flag==0
        return;
    else
        h_fig=findall(0,'Type','figure','Tag','figure');
        setappdata(h_fig,'makeRM2Flag',true);
    end
    h_fig=findall(0,'Type','figure','Tag','figure');
    setappdata(h_fig,'ArnoldFlag',true);
    
    
    makeIDRPE(hObject, eventdata, handles);
    
    nname=filename;
    iIndex=strfind(nname,'.');
    nname=nname(1:iIndex-1);
    sel1=get(handles.popupmenuFileName1,'Value');
        switch sel1
            case 1
                str='001';
            case 2
                str=nname;
        end
        sel2=get(handles.popupmenuFileName2,'Value');
         switch sel2
            case 1
                str=strcat(str,nname);       
             case 2
                 str=strcat(str,'001');
             case 3
                 str=strcat(str,'.jpg');
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
         end
         sel3=get(handles.popupmenuFileName3,'Value');
         switch sel3
            case 1
                str=strcat(str,'.jpg');         
             case 2
                 str=strcat(str,'001');
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
         end
         sel4=get(handles.popupmenuFileName4,'Value');
         switch sel4
            case 1
                str=strcat(str,'');         
             case 2
                 str=strcat(str,'001');
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
             case 7
                 str=strcat(str,'.jpg');
         end
         sel5=get(handles.popupmenuFileName5,'Value');
         switch sel5
            case 1
                str=strcat(str,'');         
             case 2
                 str=strcat(str,'001');
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
             case 7
                 str=strcat(str,'.jpg');
         end
    %保存解密图
    str=strcat(ResultDir,str);
    fwritepath=char(str);
    iIndex=strfind(fwritepath,'.');
    ileng=length(iIndex);
    fleng=length(fwritepath);
    try
        imwrite(DecryptionIm,fwritepath);
    catch
        fwritepath=strcat(fwritepath,'.jpg');
        imwrite(DecryptionIm,fwritepath);
    end
    strbar=strcat('解密进度:',num2str(1),'/',num2str(1));
    pro=1/1;
    waitbar(pro,hWaitbar,strbar);
    pause(0.5);
    delete(hWaitbar);
    clear hWaitbar;

%     imwrite(DecryptionIm,fwritepath);
else    
    pro=0/length(filename);
    strbar=strcat('解密完成:','0','/',num2str(length(filename)));
    hWaitbar=waitbar(pro,strbar,'name','解密进度条');
    for i=1:length(filename)
        strbar=strcat('解密进度:',num2str(i),'/',num2str(length(filename)));
        pro=i/length(filename);
        waitbar(pro,hWaitbar,strbar);
        tfpath=strcat(fpath(1),fpath(i+1));
        tfpath=char(tfpath);
        tf=char(tfpath);
        try
            load(tf,'-mat');
        catch
            msgbox('输入的源文件不能进行解密，请输入*.mat文件！','error');
            return;
        end
        OriginalIm=EncryptionIm;
        ArnoldIm=EncryptionIm;
        h_fig=findall(0,'Type','figure','Tag','figure');
        setappdata(h_fig,'makeRM1Flag',false);
        setappdata(h_fig,'makeRM2Flag',false);
        setappdata(h_fig,'makeArnoldFlag',true);
        setappdata(h_fig,'EncryptionImFlag',true);
        flag=makeRM1(hObject, eventdata, handles);
        if flag==0
            return;
        else
            h_fig=findall(0,'Type','figure','Tag','figure');
            setappdata(h_fig,'makeRM1Flag',true);
        end
        flag=makeRM2(hObject, eventdata, handles);
        if flag==0
            return;
        else
            h_fig=findall(0,'Type','figure','Tag','figure');
            setappdata(h_fig,'makeRM2Flag',true);
        end
        h_fig=findall(0,'Type','figure','Tag','figure');
        setappdata(h_fig,'ArnoldFlag',true);
        flag=makeIDRPE(hObject, eventdata, handles);
        if flag==0
            return;
        else
            h_fig=findall(0,'Type','figure','Tag','figure');
            setappdata(h_fig,'makeRM2Flag',true);
        end
        
        
         %保存加密文件
        nname=filename(i);
        nname=char(nname);
        iIndex=strfind(nname,'.');
        nname=nname(1:iIndex-1);
        sel1=get(handles.popupmenuFileName1,'Value');
        switch sel1
            case 1
                if i<10
                    str=strcat('00',num2str(i));
                elseif i<100
                    str=strcat('0',num2str(i));
                else
                    str=num2str(i);
                end
            case 2
                str=nname;
        end
        sel2=get(handles.popupmenuFileName2,'Value');
         switch sel2
            case 1
                str=strcat(str,nname);       
             case 2
                if i<10
                    tstr=strcat('00',num2str(i));
                elseif i<100
                    tstr=strcat('0',num2str(i));
                else
                    tstr=num2str(i);
                end           
                 str=strcat(str,tstr);
             case 3
                 str=strcat(str,'.jpg');
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
         end
         sel3=get(handles.popupmenuFileName3,'Value');
         switch sel3
            case 1
                str=strcat(str,'.jpg');         
             case 2
                if i<10
                    tstr=strcat('00',num2str(i));
                elseif i<100
                    tstr=strcat('0',num2str(i));
                else
                    tstr=num2str(i);
                end           
                 str=strcat(str,tstr);
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
         end
         sel4=get(handles.popupmenuFileName4,'Value');
         switch sel4
            case 1
                str=strcat(str,'');         
             case 2
                if i<10
                    tstr=strcat('00',num2str(i));
                elseif i<100
                    tstr=strcat('0',num2str(i));
                else
                    tstr=num2str(i);
                end           
                 str=strcat(str,tstr);
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
             case 7
                 str=strcat(str,'.jpg');
         end
         sel5=get(handles.popupmenuFileName5,'Value');
         switch sel5
            case 1
                str=strcat(str,'');         
             case 2
                if i<10
                    tstr=strcat('00',num2str(i));
                elseif i<100
                    tstr=strcat('0',num2str(i));
                else
                    tstr=num2str(i);
                end           
                 str=strcat(str,tstr);
             case 3
                 str=strcat(str,nname);
             case 4
                 str=strcat(str,'.png');
             case 5
                 str=strcat(str,'.tif');
             case 6
                 str=strcat(str,'.mat');
             case 7
                 str=strcat(str,'.jpg');
         end
        %保存解密图
        str=strcat(ResultDir,str);
        fwritepath=char(str);
        iIndex=strfind(fwritepath,'.');
        ileng=length(iIndex);
        fleng=length(fwritepath);
        if strcmp(fwritepath(iIndex(ileng):fleng),'.mat')
            fwritepath=strcat(fwritepath,'.jpg');
        end
        imwrite(DecryptionIm,fwritepath);
    end
    delete(hWaitbar);
    clear hWaitbar;
end


function textResultFileDeo_ButtonDownFcn(hObject, eventdata, handles)


function editResultFileName2_Callback(hObject, eventdata, handles)


function editResultFileName2_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenuFileName2_Callback(hObject, eventdata, handles)
global filename;
if isempty(filename)
    firstname='源文件';
elseif ischar(filename)
    iIndex=strfind(filename,'.');
    firstname=filename(1:iIndex-1);
else
    firstname=char(filename(1));
    iIndex=strfind(firstname,'.');
    firstname=firstname(1:iIndex-1);
end
str=get(handles.editResultFileName1,'string');
str=strcat('示例：',str);
sel=get(hObject,'Value');
switch sel
    case 1
        str=strcat(str,firstname);
        set(handles.editResultFileName2,'string',firstname);
        set(handles.textResultFileDeo,'string',str);
    case 2
        str=strcat(str,'001');
        set(handles.editResultFileName2,'string','001');
        set(handles.textResultFileDeo,'string',str);
    case 3
        str=strcat(str,'.jpg');
        set(handles.editResultFileName2,'string','.jpg');
        set(handles.textResultFileDeo,'string',str);
    case 4
        str=strcat(str,'.png');
        set(handles.editResultFileName2,'string','.png');
        set(handles.textResultFileDeo,'string',str);
    case 5
        str=strcat(str,'.tif');
        set(handles.editResultFileName2,'string','.tif');
        set(handles.textResultFileDeo,'string',str);
    case 6
        str=strcat(str,'.mat');
        set(handles.editResultFileName2,'string','.mat');
        set(handles.textResultFileDeo,'string',str);
end

function popupmenuFileName2_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editResultFileName3_Callback(hObject, eventdata, handles)


function editResultFileName3_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenuFileName3_Callback(hObject, eventdata, handles)
global filename;
if isempty(filename)
    firstname='源文件';
elseif ischar(filename)
    iIndex=strfind(filename,'.');
    firstname=filename(1:iIndex-1);
else
    firstname=char(filename(1));
    iIndex=strfind(firstname,'.');
    firstname=firstname(1:iIndex-1);
end
str1=get(handles.editResultFileName1,'string');
str2=get(handles.editResultFileName2,'string');
str=strcat('示例：',str1,str2);
sel=get(hObject,'Value');
switch sel
    case 1
        str=strcat(str,'.jpg');
        set(handles.editResultFileName3,'string','.jpg');
        set(handles.textResultFileDeo,'string',str);
    case 2
        str=strcat(str,'001');
        set(handles.editResultFileName3,'string','001');
        set(handles.textResultFileDeo,'string',str);
    case 3
        str=strcat(str,firstname);
        set(handles.editResultFileName3,'string',firstname);
        set(handles.textResultFileDeo,'string',str);
    case 4
        str=strcat(str,'.png');
        set(handles.editResultFileName3,'string','.png');
        set(handles.textResultFileDeo,'string',str);
    case 5
        str=strcat(str,'.tif');
        set(handles.editResultFileName3,'string','.tif');
        set(handles.textResultFileDeo,'string',str);
    case 6
        str=strcat(str,'.mat');
        set(handles.editResultFileName3,'string','.mat');
        set(handles.textResultFileDeo,'string',str);
    case 7
        set(handles.editResultFileName3,'string','');
        set(handles.textResultFileDeo,'string',str);
end

function popupmenuFileName3_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editResultFileName4_Callback(hObject, eventdata, handles)


function editResultFileName4_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenuFileName4_Callback(hObject, eventdata, handles)
global filename;
if isempty(filename)
    firstname='源文件';
elseif ischar(filename)
    iIndex=strfind(filename,'.');
    firstname=filename(1:iIndex-1);
else
    firstname=char(filename(1));
    iIndex=strfind(firstname,'.');
    firstname=firstname(1:iIndex-1);
end
str1=get(handles.editResultFileName1,'string');
str2=get(handles.editResultFileName2,'string');
str3=get(handles.editResultFileName3,'string');
str=strcat('示例：',str1,str2,str3);
sel=get(hObject,'Value');
switch sel
    case 1
        set(handles.editResultFileName4,'string','');
        set(handles.textResultFileDeo,'string',str);
    case 2
        str=strcat(str,'001');
        set(handles.editResultFileName4,'string','001');
        set(handles.textResultFileDeo,'string',str);
    case 3
        str=strcat(str,firstname);
        set(handles.editResultFileName4,'string',firstname);
        set(handles.textResultFileDeo,'string',str);
    case 4
        str=strcat(str,'.png');
        set(handles.editResultFileName4,'string','.png');
        set(handles.textResultFileDeo,'string',str);
    case 5
        str=strcat(str,'.tif');
        set(handles.editResultFileName4,'string','.tif');
        set(handles.textResultFileDeo,'string',str);
    case 6
        str=strcat(str,'.mat');
        set(handles.editResultFileName4,'string','.mat');
        set(handles.textResultFileDeo,'string',str);
    case 7
        str=strcat(str,'.jpg');
        set(handles.editResultFileName4,'string','.jpg');
        set(handles.textResultFileDeo,'string',str);
end

function popupmenuFileName4_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editResultFileName5_Callback(hObject, eventdata, handles)


function editResultFileName5_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenuFileName5_Callback(hObject, eventdata, handles)
global filename;
if isempty(filename)
    firstname='源文件';
elseif ischar(filename)
    iIndex=strfind(filename,'.');
    firstname=filename(1:iIndex-1);
else
    firstname=char(filename(1));
    iIndex=strfind(firstname,'.');
    firstname=firstname(1:iIndex-1);
end
str1=get(handles.editResultFileName1,'string');
str2=get(handles.editResultFileName2,'string');
str3=get(handles.editResultFileName3,'string');
str4=get(handles.editResultFileName4,'string');
str=strcat('示例：',str1,str2,str3,str4);
sel=get(hObject,'Value');
switch sel
    case 1
        set(handles.editResultFileName5,'string','');
        set(handles.textResultFileDeo,'string',str);
    case 2
        str=strcat(str,'001');
        set(handles.editResultFileName5,'string','001');
        set(handles.textResultFileDeo,'string',str);
    case 3
        str=strcat(str,firstname);
        set(handles.editResultFileName5,'string',firstname);
        set(handles.textResultFileDeo,'string',str);
    case 4
        str=strcat(str,'.png');
        set(handles.editResultFileName5,'string','.png');
        set(handles.textResultFileDeo,'string',str);
    case 5
        str=strcat(str,'.tif');
        set(handles.editResultFileName5,'string','.tif');
        set(handles.textResultFileDeo,'string',str);
    case 6
        str=strcat(str,'.mat');
        set(handles.editResultFileName5,'string','.mat');
        set(handles.textResultFileDeo,'string',str);
    case 7
        str=strcat(str,'.jpg');
        set(handles.editResultFileName5,'string','.jpg');
        set(handles.textResultFileDeo,'string',str);
end

function popupmenuFileName5_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function figureBatch_CloseRequestFcn(hObject, eventdata, handles)

% Hint: delete(hObject) closes the figure
delete(hObject);
