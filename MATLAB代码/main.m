function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 08-Jun-2017 11:15:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
%设置状态标签
setappdata(handles.figure,'OriginalImFlag',false);
setappdata(handles.figure,'ArnoldImFlag',false);
setappdata(handles.figure,'EncryptionImFlag',false);
setappdata(handles.figure,'DecryptionImFlag',false);

setappdata(handles.figure,'makeRM1Flag',false);
setappdata(handles.figure,'makeRM2Flag',false);

setappdata(handles.figure,'KeyFlag',false);
setappdata(handles.figure,'ArnoldCountKeyFlag',false);
setappdata(handles.figure,'LogisticXKeyFlag',false);
setappdata(handles.figure,'LogisticUKeyFlag',false);
setappdata(handles.figure,'LogisticNKeyFlag',false);
setappdata(handles.figure,'ChenXKeyFlag',false);
setappdata(handles.figure,'ChenYKeyFlag',false);
setappdata(handles.figure,'ChenZKeyFlag',false);
setappdata(handles.figure,'ChenCKeyFlag',false);
setappdata(handles.figure,'ChenHKeyFlag',false);
setappdata(handles.figure,'ChenTKeyFlag',false);
setappdata(handles.figure,'ChenNKeyFlag',false);

%隐藏坐标轴
set(handles.axesOriginalIm,'Visible','off');
set(handles.axesArnoldIm,'Visible','off');
set(handles.axesEncryptionIm,'Visible','off');
set(handles.axesDecryptionIm,'Visible','off');
% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function File_Callback(hObject, eventdata, handles)


function FileOpenOriginal_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile( ...  
    {'*.jpg;*.bmp;*.png;*.jpeg','Image Files ( *.jpg,*.bmp, *.png,*.jpeg)'; ...  
    '*.*','All Files (*.*)'}, ...  
    'Pick an image'); 
if isequal(filename,0) || isequal(pathname,0)
    return;  
end
fpath=[pathname filename];%将文件名和目录名组合成一个完整的路径  
global OriginalIm
OriginalIm=imread(fpath);
OriginalIm=im2double(OriginalIm);
if length(size(OriginalIm))==3
    OriginalIm=rgb2gray(OriginalIm);
end
axes(handles.axesOriginalIm); %用axes命令设定当前操作的坐标轴是axes_src
cla;%清空坐标图
imshow(OriginalIm);
title('原图');
h_fig=findall(0,'Type','figure','Tag','figure');
setappdata(h_fig,'makeRM1Flag',false);
setappdata(h_fig,'makeRM2Flag',false);
setappdata(h_fig,'OriginalImFlag',true);




function FileOpenKey_Callback(hObject, eventdata, handles)
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
set(handles.editArnoldCount,'string',num2str(ArnoldCount));
set(handles.editLogisticX,'string',num2str(LogisticX));
set(handles.editLogisticU,'string',num2str(LogisticU));
set(handles.editLogisticN,'string',num2str(LogisticN));
set(handles.editChenX,'string',num2str(ChenX));
set(handles.editChenY,'string',num2str(ChenY));
set(handles.editChenZ,'string',num2str(ChenZ));
set(handles.editChenC,'string',num2str(ChenC));
set(handles.editChenH,'string',num2str(ChenH));
set(handles.editChenT,'string',num2str(ChenT));
set(handles.editChenN,'string',num2str(ChenN));

h_fig=findall(0,'Type','figure','Tag','figure');
setappdata(h_fig,'makeRM1Flag',false);
setappdata(h_fig,'makeRM2Flag',false);
setappdata(handles.figure,'KeyFlag',true);




function FileOpenEncryption_Callback(hObject, eventdata, handles)
global EncryptionIm;
[filename, pathname] = uigetfile('encryption.mat','Pick an encryption file'); 
if isequal(filename,0) || isequal(pathname,0)
    return;  
end 
fpath=[pathname filename];%将文件名和目录名组合成一个完整的路径  
try
    load(fpath,'-mat');
catch
    msgbox('输入的源文件不能进行解密，请输入*.mat文件！','error');
    return;
end

axes(handles.axesEncryptionIm); %用axes命令设定当前操作的坐标轴是axes_src
cla;%清空坐标图
imshow(abs(EncryptionIm));
title('加密图');
h_fig=findall(0,'Type','figure','Tag','figure');
setappdata(h_fig,'makeRM1Flag',false);
setappdata(h_fig,'makeRM2Flag',false);
setappdata(h_fig,'ArnoldImFlag',true);
setappdata(h_fig,'EncryptionImFlag',true);

function FileSaveKey_Callback(hObject, eventdata, handles)
[filename, pathname] = uiputfile('key.csv','Save file name');
if isequal(filename,0) || isequal(pathname,0)  
    return;%如果点了“取消”  
else  
    fpath=fullfile(pathname, filename);%获得全路径的另一种方法  
end  
global ArnoldCount LogisticX LogisticU LogisticN ChenX ChenY ChenZ ChenC ChenH ChenT ChenN;
T=table(ArnoldCount,LogisticX,LogisticU,LogisticN,ChenX,ChenY,ChenZ,ChenC,ChenH,ChenT,ChenN);
writetable(T,fpath,'WriteRowNames',true,'Delimiter',',');

function FileSaveEncryption_Callback(hObject, eventdata, handles)
[filename, pathname] =   uiputfile('EncryptionIm.mat','Save file name');
if isequal(filename,0) || isequal(pathname,0)  
    return;%如果点了“取消”  
else  
    fpath=fullfile(pathname, filename);%获得全路径的另一种方法  
end  
global EncryptionIm;
save(fpath,'EncryptionIm');
% imwrite(abs(EncryptionIm),fpath);%保存图片  

function FileSaveDecryption_Callback(hObject, eventdata, handles)
[filename, pathname] =   uiputfile('original.jpg','Save file name');
if isequal(filename,0) || isequal(pathname,0)  
    return;%如果点了“取消”  
else  
    fpath=fullfile(pathname, filename);%获得全路径的另一种方法  
end  

global DecryptionIm
imwrite(DecryptionIm,fpath);%保存图片  

function FileBatch_Callback(hObject, eventdata, handles)
setappdata(handles.figure,'EncryptionImFlag',false);
setappdata(handles.figure,'DecryptionImFlag',false);
batch();

function FileClose_Callback(hObject, eventdata, handles)
sel=questdlg('确认退出?','关闭确认','Yes','No','No');
switch sel
    case'Yes'
        clear global;
        close();  
    case'No'
        return;
end

function EnDecryption_Callback(hObject, eventdata, handles)


function EnDecryptionEnterKey_Callback(hObject, eventdata, handles)
global ArnoldCount LogisticX LogisticU LogisticN ChenX ChenY ChenZ ChenC ChenH ChenT ChenN;
prompt = {'ArnoldCount(>=0):','LogisticX(>0):','LogisticU(3.5699456--4):','LogisticN(>=0):','ChenX:','ChenY:','ChenZ:','ChenC(20--28.4):','ChenH(0--1):','ChenT(>=0):','ChenN(>=0):'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {num2str(ArnoldCount),num2str(LogisticX),num2str(LogisticU),num2str(LogisticN), num2str(ChenX),num2str(ChenY),num2str(ChenZ),num2str(ChenC),num2str(ChenH),num2str(ChenT),num2str(ChenN)};
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

function EnDecryptionArnold_Callback(hObject, eventdata, handles)
flag=makeArnold(hObject, eventdata, handles);
if flag==0
    return;
end
setappdata(handles.figure,'ArnoldImFlag',true);
global ArnoldIm;
axes(handles.axesArnoldIm); %用axes命令设定当前操作的坐标轴是axes_src
cla;%清空坐标图
imshow(ArnoldIm);
title('Arnold变换图');

function EnDecryptionDRPEEncryption_Callback(hObject, eventdata, handles)
flag=makeDRPE(hObject, eventdata, handles);
if flag==0
    return;
end
setappdata(handles.figure,'EncryptionImFlag',true);
global EncryptionIm;
axes(handles.axesEncryptionIm); %用axes命令设定当前操作的坐标轴是axes_src
cla;%清空坐标图
imshow(abs(EncryptionIm));
title('加密图');


function EnDecryptionDRPEDecryption_Callback(hObject, eventdata, handles)
flag=makeIDRPE(hObject, eventdata, handles);
if flag==0
    return;
end
setappdata(handles.figure,'EncryptionImFlag',true);
global DecryptionIm;
axes(handles.axesDecryptionIm); %用axes命令设定当前操作的坐标轴是axes_src
cla;%清空坐标图
imshow(abs(DecryptionIm));
title('解密图');

function EnDecryptionAutoAll_Callback(hObject, eventdata, handles)
global TIME;
tic;
makeArnold(hObject, eventdata, handles);
setappdata(handles.figure,'ArnoldImFlag',true);
makeDRPE(hObject, eventdata, handles);
setappdata(handles.figure,'EncryptionImFlag',true);
makeIDRPE(hObject, eventdata, handles);
setappdata(handles.figure,'DecryptionImFlag',true);
TIME=toc;
global OriginalIm ArnoldIm EncryptionIm DecryptionIm;
figure('name','加解密过程图')
subplot(221),imshow(abs(OriginalIm)),title('原始图');
subplot(222),imshow(abs(ArnoldIm)),title('Arnold变换图');
subplot(223),imshow(abs(EncryptionIm)),title('加密图');
subplot(224),imshow(abs(DecryptionIm)),title('解密头');

function CharAnalysis_Callback(hObject, eventdata, handles)


function PerforAnalysis_Callback(hObject, eventdata, handles)


function PerforAnalysisSimilar_Callback(hObject, eventdata, handles)


function PerforAnalysisTime_Callback(hObject, eventdata, handles)
global TIME;
tem=isempty(TIME);
if tem
    EnDecryptionAutoAll_Callback(hObject, eventdata, handles);
end
t=num2str(TIME);
t=strcat(t,'s');
h=msgbox({'加解密共用时：' t},'Time');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  
function PerforAnalysisRobust_Callback(hObject, eventdata, handles)

function CharAnalysisAll_Callback(hObject, eventdata, handles)
global OriginalIm ArnoldIm EncryptionIm DecryptionIm;

figure('name','所有特性');
Img=OriginalIm;
subplot(4,4,1),imshow(abs(Img)),title('原始图');
subplot(4,4,5),imhist(abs(Img)),title('灰度直方图');
subplot(4,4,9),makeAPCD(Img),title('相邻像素相关性图');
subplot(4,4,13),H=makeImentropy(Img);str=strcat('图片的信息熵：',num2str(H));text(0,0.9,str);
             coff_h=makeSelfCoeffHorizontal(Img);str=strcat('水平方向自相关系数：',num2str(coff_h));text(0,0.6,str);
             coff_h=makeSelfCoeffVertical(Img);str=strcat('垂直方向自相关系数：',num2str(coff_h));text(0,0.3,str);
             coff_h=makeSelfCoeffDiagonal(Img);str=strcat('对角线上自相关系数：',num2str(coff_h));text(0,0.0,str);
             axis off;
             
Img=ArnoldIm;
subplot(4,4,2),imshow(abs(Img)),title('Arnold变换图');
subplot(4,4,6),imhist(abs(Img)),title('灰度直方图');
subplot(4,4,10),makeAPCD(Img),title('相邻像素相关性图');
subplot(4,4,14),H=makeImentropy(Img);str=strcat('图片的信息熵：',num2str(H));text(0,0.9,str);
             coff_h=makeSelfCoeffHorizontal(Img);str=strcat('水平方向自相关系数：',num2str(coff_h));text(0,0.6,str);
             coff_h=makeSelfCoeffVertical(Img);str=strcat('垂直方向自相关系数：',num2str(coff_h));text(0,0.3,str);
             coff_h=makeSelfCoeffDiagonal(Img);str=strcat('对角线上自相关系数：',num2str(coff_h));text(0,0.0,str);
             axis off;

             
Img=EncryptionIm;
subplot(4,4,3),imshow(abs(Img)),title('加密图');
subplot(4,4,7),imhist(abs(Img)),title('灰度直方图');
subplot(4,4,11),makeAPCD(Img),title('相邻像素相关性图');
subplot(4,4,15),H=makeImentropy(Img);str=strcat('图片的信息熵：',num2str(H));text(0,0.9,str);
             coff_h=makeSelfCoeffHorizontal(Img);str=strcat('水平方向自相关系数：',num2str(coff_h));text(0,0.6,str);
             coff_h=makeSelfCoeffVertical(Img);str=strcat('垂直方向自相关系数：',num2str(coff_h));text(0,0.3,str);
             coff_h=makeSelfCoeffDiagonal(Img);str=strcat('对角线上自相关系数：',num2str(coff_h));text(0,0.0,str);
             axis off;
             
             
Img=DecryptionIm;
subplot(4,4,4),imshow(abs(Img)),title('解密图');
subplot(4,4,8),imhist(abs(Img)),title('灰度直方图');
subplot(4,4,12),makeAPCD(Img),title('相邻像素相关性图');
subplot(4,4,16),H=makeImentropy(Img);str=strcat('图片的信息熵：',num2str(H));text(0,0.9,str);
             coff_h=makeSelfCoeffHorizontal(Img);str=strcat('水平方向自相关系数：',num2str(coff_h));text(0,0.6,str);
             coff_h=makeSelfCoeffVertical(Img);str=strcat('垂直方向自相关系数：',num2str(coff_h));text(0,0.3,str);
             coff_h=makeSelfCoeffDiagonal(Img);str=strcat('对角线上自相关系数：',num2str(coff_h));text(0,0.0,str);
             axis off;     


function CharAnalysisOriginal_Callback(hObject, eventdata, handles)


function CharAnalysisArnold_Callback(hObject, eventdata, handles)


function CharAnalysisEncryption_Callback(hObject, eventdata, handles)


function CharAnalysisDecryption_Callback(hObject, eventdata, handles)


function CharAnalysisDecryptionAll_Callback(hObject, eventdata, handles)
global DecryptionIm;
Img=DecryptionIm;
figure('name','解密图特性');
subplot(221),imhist(abs(Img)),title('灰度直方图');
subplot(222),makeAPCD(Img),title('相邻像素相关性图');
subplot(223),H=makeImentropy(Img);str=strcat('图片的信息熵：',num2str(H));text(0,0.9,str,'FontSize',18);
             coff_h=makeSelfCoeffHorizontal(Img);str=strcat('水平方向自相关系数：',num2str(coff_h));text(0,0.6,str,'FontSize',18);
             coff_h=makeSelfCoeffVertical(Img);str=strcat('垂直方向自相关系数：',num2str(coff_h));text(0,0.3,str,'FontSize',18);
             coff_h=makeSelfCoeffDiagonal(Img);str=strcat('对角线上自相关系数：',num2str(coff_h));text(0,0.0,str,'FontSize',18);
             axis off;

function CharAnalysisDecryptionImhist_Callback(hObject, eventdata, handles)
global DecryptionIm;
figure('name','解密图灰度直方图');
imhist(abs(DecryptionIm));

function CharAnalysisDecryptionAPCD_Callback(hObject, eventdata, handles)
global DecryptionIm;
figure('name','解密图相邻像素相关性图');
makeAPCD(DecryptionIm);

function CharAnalysisDecryptionSelfCoeff_Callback(hObject, eventdata, handles)


function CharAnalysisDecryptionImentropy_Callback(hObject, eventdata, handles)
global DecryptionIm;
H=makeImentropy(DecryptionIm);
h=msgbox({'解密图像信息熵：',num2str(H)},'imentropy');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  

function CharAnalysisEncryptionAll_Callback(hObject, eventdata, handles)
global EncryptionIm;
Img=EncryptionIm;
figure('name','加密图特性');
subplot(221),imhist(abs(Img)),title('灰度直方图');
subplot(222),makeAPCD(Img),title('相邻像素相关性图');
subplot(223),H=makeImentropy(Img);str=strcat('图片的信息熵：',num2str(H));text(0,0.9,str,'FontSize',18);
             coff_h=makeSelfCoeffHorizontal(Img);str=strcat('水平方向自相关系数：',num2str(coff_h));text(0,0.6,str,'FontSize',18);
             coff_h=makeSelfCoeffVertical(Img);str=strcat('垂直方向自相关系数：',num2str(coff_h));text(0,0.3,str,'FontSize',18);
             coff_h=makeSelfCoeffDiagonal(Img);str=strcat('对角线上自相关系数：',num2str(coff_h));text(0,0.0,str,'FontSize',18);
             axis off;

function CharAnalysisEncryptionImhist_Callback(hObject, eventdata, handles)
global EncryptionIm;
figure('name','解密图灰度直方图');
imhist(abs(EncryptionIm));


function CharAnalysisEncryptionAPCD_Callback(hObject, eventdata, handles)
global EncryptionIm;
figure('name','解密图相邻像素相关性图');
makeAPCD(EncryptionIm);


function CharAnalysisEncryptionSelfCoeff_Callback(hObject, eventdata, handles)



function CharAnalysisEncryptionImentropy_Callback(hObject, eventdata, handles)
global EncryptionIm;
H=makeImentropy(EncryptionIm);
h=msgbox({'水平方向自相关系数：' num2str(H)},'imentropy');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 ); 

function CharAnalysisArnoldAll_Callback(hObject, eventdata, handles)
global ArnoldIm;
Img=ArnoldIm;
figure('name','Arnold变换图特性');
subplot(221),imhist(abs(Img)),title('灰度直方图');
subplot(222),makeAPCD(Img),title('相邻像素相关性图');
subplot(223),H=makeImentropy(Img);str=strcat('图片的信息熵：',num2str(H));text(0,0.9,str,'FontSize',18);
             coff_h=makeSelfCoeffHorizontal(Img);str=strcat('水平方向自相关系数：',num2str(coff_h));text(0,0.6,str,'FontSize',18);
             coff_h=makeSelfCoeffVertical(Img);str=strcat('垂直方向自相关系数：',num2str(coff_h));text(0,0.3,str,'FontSize',18);
             coff_h=makeSelfCoeffDiagonal(Img);str=strcat('对角线上自相关系数：',num2str(coff_h));text(0,0.0,str,'FontSize',18);
             axis off;



function CharAnalysisArnoldImhist_Callback(hObject, eventdata, handles)
global ArnoldIm;
figure('name','解密图灰度直方图');
imhist(abs(ArnoldIm));

function CharAnalysisArnoldAPCD_Callback(hObject, eventdata, handles)
global ArnoldIm;
figure('name','解密图相邻像素相关性图');
makeAPCD(ArnoldIm);


function CharAnalysisArnoldSelfCoeff_Callback(hObject, eventdata, handles)


function CharAnalysisArnoldImentropy_Callback(hObject, eventdata, handles)
global ArnoldIm;
H=makeImentropy(ArnoldIm);
h=msgbox({'解密图像信息熵：',num2str(H)},'imentropy');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  

function CharAnalysisOriginalAll_Callback(hObject, eventdata, handles)
global OriginalIm;
Img=OriginalIm;
figure('name','原图特性');
subplot(221),imhist(abs(Img)),title('灰度直方图');
subplot(222),makeAPCD(Img),title('相邻像素相关性图');
subplot(223),H=makeImentropy(Img);str=strcat('图片的信息熵：',num2str(H));text(0,0.9,str,'FontSize',18);
             coff_h=makeSelfCoeffHorizontal(Img);str=strcat('水平方向自相关系数：',num2str(coff_h));text(0,0.6,str,'FontSize',18);
             coff_h=makeSelfCoeffVertical(Img);str=strcat('垂直方向自相关系数：',num2str(coff_h));text(0,0.3,str,'FontSize',18);
             coff_h=makeSelfCoeffDiagonal(Img);str=strcat('对角线上自相关系数：',num2str(coff_h));text(0,0.0,str,'FontSize',18);
             axis off;

function CharAnalysisOriginalImhist_Callback(hObject, eventdata, handles)
global OriginalIm;
figure('name','解密图灰度直方图');
imhist(abs(OriginalIm));


function CharAnalysisOriginalAPCD_Callback(hObject, eventdata, handles)
global OriginalIm;
figure('name','解密图相邻像素相关性图');
makeAPCD(OriginalIm);

function CharAnalysisOriginalSelfCoeff_Callback(hObject, eventdata, handles)


function CharAnalysisOriginalImentropy_Callback(hObject, eventdata, handles)
global OriginalIm;
H=makeImentropy(OriginalIm);
h=msgbox({'解密图像信息熵：',num2str(H)},'imentropy');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  

function PerforAnalysisRobustNoise_Callback(hObject, eventdata, handles)
global OriginalIm EncryptionIm RM1Im RM2Im ArnoldCount;
str=inputdlg('Gaussian白噪声','请输入Gaussian白噪声强度',1,{'0.002'},'on');
count =str2double(str{1});
EncryptionIm_noise= imnoise(EncryptionIm,'gaussian',0,count);

DecryptionIm_noise=ifft2(fft2(double(EncryptionIm_noise)).*conj(double(RM2Im))).*conj(double(RM1Im));
I=DecryptionIm_noise;
Arnold_a=1;
Arnold_b=1;
Arnold_c=1;
Arnold_d=2;
c=[Arnold_a,Arnold_b;Arnold_c,Arnold_d];
c=inv(c);
[M,N]=size(I);
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
DecryptionIm_noise=result;
figure('name','噪声攻击分析');
hold on;
subplot(221);imshow(OriginalIm);title('原图');
subplot(222);imshow(abs(EncryptionIm));title('原始加密图');
subplot(224);imshow(abs(EncryptionIm_noise));title('加入高斯白噪声后的加密图');
subplot(223);imshow(abs(DecryptionIm_noise));title('加入高斯白噪声后的解密图图');

function PerforAnalysisRobustCrop_Callback(hObject, eventdata, handles)
global OriginalIm EncryptionIm RM1Im RM2Im ArnoldCount;
[m n]=size(EncryptionIm);
str=inputdlg({'请输入剪切宽度比例(0--1)：','请输入剪切高度比例(0--1)：'},'剪切',1,{'0.5','0.5'},'on');
mm=str2num(str{1});
nn=str2num(str{2});
m=uint8(m*mm);
n=uint8(n*nn);
EncryptionIm_crop=EncryptionIm;
EncryptionIm_crop(1:m,1:n)=0;

DecryptionIm_crop=ifft2(fft2(double(EncryptionIm_crop)).*conj(double(RM2Im))).*conj(double(RM1Im));
I=DecryptionIm_crop;
Arnold_a=1;
Arnold_b=1;
Arnold_c=1;
Arnold_d=2;
c=[Arnold_a,Arnold_b;Arnold_c,Arnold_d];
c=inv(c);
[M,N]=size(I);
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
DecryptionIm_crop=result;
figure('name','剪切攻击分析');
hold on;
subplot(221);imshow(OriginalIm);title('原图');
subplot(222);imshow(abs(EncryptionIm));title('原始加密图');
subplot(224);imshow(abs(EncryptionIm_crop));title('剪切后的加密图');
subplot(223);imshow(abs(DecryptionIm_crop));title('剪切后的解密图');

function PerforAnalysisSimilarAll_Callback(hObject, eventdata, handles)
global OriginalIm DecryptionIm;
A=im2double(abs(OriginalIm));
B=im2double(abs(DecryptionIm));
figure('name','原图与解密图间相似度');
subplot('position',[0.2,0.9,0.8,0.2]),num=corr2(A,B);str=strcat('相关系数：',num2str(num));text(0,0,str,'fontSize',24);
                                      num=immse(A,B);str=strcat('均方误差：',num2str(num));text(0,-1,str,'fontSize',24);  
                                      [m,n]=psnr(A,B);str=strcat('峰值信噪比：',num2str(m));text(0,-2,str,'fontSize',24);  
                                                      str=strcat('信噪比：',num2str(n));text(0,-3,str,'fontSize',24);  

axis off;

function PerforAnalysisSimilarCorr_Callback(hObject, eventdata, handles)
global OriginalIm DecryptionIm;
A=im2double(OriginalIm);
B=im2double(abs(DecryptionIm));
num=corr2(A,B);
h=msgbox({'' '' '相关系数：' num2str(num)},'PSNR');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,200,120]);
set( ch, 'FontSize', 30 ); 


function PerforAnalysisSimilarIMMSE_Callback(hObject, eventdata, handles)
global OriginalIm DecryptionIm;
A=im2double(abs(OriginalIm));
B=im2double(abs(DecryptionIm));
num=immse(A,B);
h=msgbox({'均方误差：' num2str(num)},'PSNR');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,200,120]);
set( ch, 'FontSize', 30 ); 
function PerforAnalysisSimilarPSNR_Callback(hObject, eventdata, handles)
global OriginalIm DecryptionIm;
A=im2double(OriginalIm);
B=im2double(abs(DecryptionIm));
[m,n]=psnr(A,B);
h=msgbox({'峰值信噪比：' num2str(m)},'PSNR');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,200,120]);
set( ch, 'FontSize', 30 ); 


function PerforAnalysisSimilarSNR_Callback(hObject, eventdata, handles)
global OriginalIm DecryptionIm;
A=im2double(OriginalIm);
B=im2double(abs(DecryptionIm));
[m,n]=psnr(A,B);
h=msgbox({'信噪比：' num2str(n)},'PSNR');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,200,120]);
set( ch, 'FontSize', 30 );  
function CharAnalysisOriginalSelfCoeffHorizontal_Callback(hObject, eventdata, handles)
global OriginalIm;
coff_h=makeSelfCoeffHorizontal(OriginalIm);
h=msgbox({'水平方向自相关系数：' num2str(coff_h)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  

function CharAnalysisOriginalSelfCoeffVertical_Callback(hObject, eventdata, handles)
global OriginalIm;
coff_v=makeSelfCoeffVertical(OriginalIm);
h=msgbox({'垂直方向自相关系数：' num2str(coff_v)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  

function CharAnalysisOriginalSelfCoeffDiagonal_Callback(hObject, eventdata, handles)
global OriginalIm;
coff_d=makeSelfCoeffDiagonal(OriginalIm);
h=msgbox({'对角线方向自相关系数：' num2str(coff_d)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  

function CharAnalysisArnoldSelfCoeffHorizontal_Callback(hObject, eventdata, handles)
global ArnoldIm;
coff_h=makeSelfCoeffHorizontal(ArnoldIm);
h=msgbox({'水平方向自相关系数：' num2str(coff_h)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  


function CharAnalysisArnoldSelfCoeffVertical_Callback(hObject, eventdata, handles)
global ArnoldIm;
coff_v=makeSelfCoeffVertical(ArnoldIm);
h=msgbox({'垂直方向自相关系数：' num2str(coff_v)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  
function CharAnalysisArnoldSelfCoeffDiagonal_Callback(hObject, eventdata, handles)
global ArnoldIm;
coff_d=makeSelfCoeffDiagonal(ArnoldIm);
h=msgbox({'对角线方向自相关系数：' num2str(coff_d)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  


function CharAnalysisEncryptionSelfCoeffHorizontal_Callback(hObject, eventdata, handles)
global EncryptionIm;
coff_h=makeSelfCoeffHorizontal(EncryptionIm);
h=msgbox({'水平方向自相关系数：' num2str(coff_h)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  

function CharAnalysisEncryptionSelfCoeffVertical_Callback(hObject, eventdata, handles)
global EncryptionIm;
coff_v=makeSelfCoeffVertical(EncryptionIm);
h=msgbox({'垂直方向自相关系数：' num2str(coff_v)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  

function CharAnalysisEncryptionSelfCoeffDiagonal_Callback(hObject, eventdata, handles)
global EncryptionIm;
coff_d=makeSelfCoeffDiagonal(EncryptionIm);
h=msgbox({'对角线方向自相关系数：' num2str(coff_d)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 ); 


function CharAnalysisDecryptionSelfCoeffHorizontal_Callback(hObject, eventdata, handles)
global DecryptionIm;
coff_h=makeSelfCoeffHorizontal(DecryptionIm);
h=msgbox({'水平方向自相关系数：' num2str(coff_h)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  

function CharAnalysisDecryptionSelfCoeffVertical_Callback(hObject, eventdata, handles)
global DecryptionIm;
coff_v=makeSelfCoeffVertical(DecryptionIm);
h=msgbox({'垂直方向自相关系数：' num2str(coff_v)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  


function CharAnalysisDecryptionSelfCoeffDiagonal_Callback(hObject, eventdata, handles)
global DecryptionIm;
coff_d=makeSelfCoeffDiagonal(DecryptionIm);
h=msgbox({'对角线方向自相关系数：' num2str(coff_d)},'自相关系数');
ah = get( h, 'CurrentAxes' );  
ch = get( ah, 'Children' );  
set(h,'Resize', 'on'); 
SZ=get(0,'ScreenSize');
set(h,'position',[SZ(3)/3,SZ(4)/3,350,120]);
set( ch, 'FontSize', 30 );  


function editArnoldCount_Callback(hObject, eventdata, handles)


function editArnoldCount_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbuttonUpdataKey_Callback(hObject, eventdata, handles)
global ArnoldCount LogisticX LogisticU LogisticN ChenX ChenY ChenZ ChenC ChenH ChenT ChenN;
ArnoldCount=str2num(get(handles.editArnoldCount,'string'));
LogisticX=str2num(get(handles.editLogisticX,'string'));
LogisticU=str2num(get(handles.editLogisticU,'string'));
LogisticN=str2num(get(handles.editLogisticN,'string'));
ChenX=str2num(get(handles.editChenX,'string'));
ChenY=str2num(get(handles.editChenY,'string'));
ChenZ=str2num(get(handles.editChenZ,'string'));
ChenC=str2num(get(handles.editChenC,'string'));
ChenH=str2num(get(handles.editChenH,'string'));
ChenT=str2num(get(handles.editChenT,'string'));
ChenN=str2num(get(handles.editChenN,'string'));
setappdata(handles.figure,'KeyFlag',true);

function editLogisticX_Callback(hObject, eventdata, handles)


function editLogisticX_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editLogisticU_Callback(hObject, eventdata, handles)


function editLogisticU_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editLogisticN_Callback(hObject, eventdata, handles)


function editLogisticN_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit8_Callback(hObject, eventdata, handles)


function edit8_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit7_Callback(hObject, eventdata, handles)


function edit7_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit6_Callback(hObject, eventdata, handles)


function edit6_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit11_Callback(hObject, eventdata, handles)


function edit11_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit10_Callback(hObject, eventdata, handles)


function edit10_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit9_Callback(hObject, eventdata, handles)


function edit9_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editChenZ_Callback(hObject, eventdata, handles)


function editChenZ_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editChenY_Callback(hObject, eventdata, handles)


function editChenY_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editChenX_Callback(hObject, eventdata, handles)


function editChenX_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editChenC_Callback(hObject, eventdata, handles)


function editChenC_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editChenH_Callback(hObject, eventdata, handles)


function editChenH_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editChenT_Callback(hObject, eventdata, handles)


function editChenT_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editChenN_Callback(hObject, eventdata, handles)


function editChenN_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
