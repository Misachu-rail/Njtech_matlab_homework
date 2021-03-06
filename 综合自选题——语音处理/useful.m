function varargout = useful(varargin)
% USEFUL MATLAB code for useful.fig
%      USEFUL, by itself, creates a new USEFUL or raises the existing
%      singleton*.
%
%      H = USEFUL returns the handle to a new USEFUL or the handle to
%      the existing singleton*.
%
%      USEFUL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USEFUL.M with the given input arguments.
%
%      USEFUL('Property','Value',...) creates a new USEFUL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before useful_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to useful_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help useful

% Last Modified by GUIDE v2.5 29-Dec-2020 14:35:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @useful_OpeningFcn, ...
                   'gui_OutputFcn',  @useful_OutputFcn, ...
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


% --- Executes just before useful is made visible.
function useful_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to useful (see VARARGIN)

% Choose default command line output for useful
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes useful wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = useful_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%-------------------------------------------------------------------------
% --- Executes on button press in pushbutton_open.
function pushbutton_open_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.wav;*.mp3','*.wav;*.mp3'},'选择声音文件');
if isequal([filename pathname],[0,0])
    return;
end
str=[pathname filename];%选择的声音文件路径和文件名
global temp;
global Fs;
global flag;
[temp,Fs]=audioread(str);%temp表示声音数据 Fs表示频率
handles.y=temp;handles.Fs=Fs;
flag = 2;


% --- Executes on button press in pushbutton_play.
function pushbutton_play_Callback(hObject, eventdata, handles)
global temp;
global Fs;
sound(temp,Fs);%播放音频文件


% --- Executes on button press in pushbutton_gt.
% ---此处稍后完善（高通）
function pushbutton_gt_Callback(hObject, eventdata, handles)
global temp;
global Fs;
y = temp;
wp=2*pi*str2double(get(handles.wp,'String'))/Fs;
ws=2*pi*str2double(get(handles.ws,'String'))/Fs;
Rp=str2double(get(handles.rp,'String'));
Rs=str2double(get(handles.rs,'String'));
wdelta=wp-ws;
N=ceil(8*pi/wdelta);%取整
wn=(wp+ws)/2;
[b,a]=fir1(N,wn/pi,'high');     
        
y1=filter(b,a,y);

plot(handles.axes1,y)
title(handles.axes1,'FIR高通滤波器滤波前的时域波形');
xlabel(handles.axes1,'时间（ms)'); 
ylabel(handles.axes1,'幅值');

plot(handles.axes2,y1);
title(handles.axes2,'FIR高通滤波器滤波后的时域波形');
xlabel(handles.axes2,'时间（ms)'); 
ylabel(handles.axes2,'幅值');
        
sound(y1,Fs);%播放滤波后的语音信号
        
F0=fft(y1,3000);
f=Fs*(0:511)/1024;
y2=fft(y,1024);
plot(handles.axes4,f,abs(y2(1:512)));
title(handles.axes4,'FIR高通滤波器滤波前的频谱')
xlabel(handles.axes4,'频率/Hz');
ylabel(handles.axes4,'幅值');
plot(handles.axes5,f,abs(F0(1:512)));
title(handles.axes5,'FIR高通滤波器滤波后的频谱')
xlabel(handles.axes5,'频率/Hz');
ylabel(handles.axes5,'幅值');



% --- Executes on button press in pushbutton_dt.
function pushbutton_dt_Callback(hObject, eventdata, handles)
global temp;
global Fs;
wp=2*pi*str2double(get(handles.wp,'String'))/Fs;
ws=2*pi*str2double(get(handles.ws,'String'))/Fs;
Rp=str2double(get(handles.rp,'String'));
Rs=str2double(get(handles.rs,'String'));
wdelta=ws-wp;
N=ceil(8*pi/wdelta);%取整
wn=(wp+ws)/2;
[b,a]=fir1(N,wn/pi,hamming(N+1));%选择窗函数，并归一化截止频率
       
y1=filter(b,a,temp);


plot(handles.axes1,temp)
title(handles.axes1,'FIR低通滤波器滤波前的时域波形');
xlabel(handles.axes1,'时间（ms)'); 
ylabel(handles.axes1,'幅值'); 

plot(handles.axes2,y1);
title(handles.axes2,'FIR低通滤波器滤波后的时域波形');
xlabel(handles.axes2,'时间（ms)'); 
ylabel(handles.axes2,'幅值');
sound(y1,Fs);%播放滤波后的语音信号

F0=fft(y1,1024);
f=Fs*(0:511)/1024;
y2=fft(temp,1024);
plot(handles.axes4,f,abs(y2(1:512)));
title(handles.axes4,'FIR低通滤波器滤波前的频谱')
xlabel(handles.axes4,'频率/Hz');
ylabel(handles.axes4,'幅值');
F2=plot(handles.axes5,f,abs(F0(1:512)));
title(handles.axes5,'FIR低通滤波器滤波后的频谱');
xlabel(handles.axes5,'频率/Hz');
ylabel(handles.axes5,'幅值');


% --- Executes on button press in pushbutton_dat.
% ---此处稍后完善（带通）
function pushbutton_dat_Callback(hObject, eventdata, handles)
global temp;
global Fs;
y=temp;
wp1=2*pi*str2double(get(handles.wp,'String'))/Fs;wp2=2*pi*str2double(get(handles.wp2,'String'))/Fs;
ws1=2*pi*str2double(get(handles.ws,'String'))/Fs;ws2=2*pi*str2double(get(handles.ws2,'String'))/Fs;
Rp=str2double(get(handles.rp,'String'));
Rs=str2double(get(handles.rs,'String'));
wp=(wp1+ws1)/2;ws=(wp2+ws2)/2;
wdelta=wp1-ws1;
N=ceil(8*pi/wdelta);%取整
wn=[wp ws];
[b,a]=fir1(N,wn/pi,'bandpass');      
y1=filter(b,a,y);

plot(handles.axes1,y);
xlabel(handles.axes1,'时间（ms)'); 
ylabel(handles.axes1,'幅值'); 
title(handles.axes1,'FIR带通滤波器滤波前的时域波形');

plot(handles.axes2,y1);
title(handles.axes2,'FIR带通滤波器滤波后的时域波形');
xlabel(handles.axes2,'时间（ms)'); 
ylabel(handles.axes2,'幅值'); 
        
sound(y1,Fs);%播放滤波后的语音信号
        
F0=fft(y1,3000);
f=Fs*(0:511)/1024;
y2=fft(y,1024);

plot(handles.axes4,f,abs(y2(1:512)));
title(handles.axes4,'FIR带通滤波器滤波前的频谱')
xlabel(handles.axes4,'频率/Hz');
ylabel(handles.axes4,'幅值');

plot(handles.axes5,f,abs(F0(1:512)));
title(handles.axes5,'FIR带通滤波器滤波后的频谱')
xlabel(handles.axes5,'频率/Hz');
ylabel(handles.axes5,'幅值');



function wp_Callback(hObject, eventdata, handles)
% hObject    handle to wp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wp as text
%        str2double(get(hObject,'String')) returns contents of wp as a double


% --- Executes during object creation, after setting all properties.
function wp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rs_Callback(hObject, eventdata, handles)
% hObject    handle to rs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rs as text
%        str2double(get(hObject,'String')) returns contents of rs as a double


% --- Executes during object creation, after setting all properties.
function rs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ws_Callback(hObject, eventdata, handles)
% hObject    handle to ws (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ws as text
%        str2double(get(hObject,'String')) returns contents of ws as a double


% --- Executes during object creation, after setting all properties.
function ws_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ws (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rp_Callback(hObject, eventdata, handles)
% hObject    handle to rp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rp as text
%        str2double(get(hObject,'String')) returns contents of rp as a double


% --- Executes during object creation, after setting all properties.
function rp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ys.(音色识别)
function pushbutton_ys_Callback(hObject, eventdata, handles)
global temp;
global Fs;
global flag;
tempa = temp(:,1);%取单声道
[~,index]=max(tempa);%求出时域图中的最大幅值对应时间
timewin=floor(0.015*Fs);%依据采样频率，取出参加计算的时域范围
xwin=tempa(index-timewin:index+timewin);%index为中点得出参加计算的范围
y=xcorr(xwin);%利用自相关函数求取基频y
ylen=length(y);%基频计算长度
halflen=(ylen+1)/2 +30;
yy=y(halflen: ylen);%控制参加比较的基频范围
[~,maxindex] = max(yy);%得到参加比较的基频最大值时域位置
fmax=Fs/(maxindex+30);
if fmax<200;%阈值设定200
    set(handles.edit_srcsex,'string','男声');
    set(handles.edit_change,'string','女声');
    flag = 0.6;
else
    set(handles.edit_srcsex,'string','女声');
    set(handles.edit_change,'string','男声');
    flag = 1.4;
end;


% --- Executes on button press in pushbutton_ysfz.
function pushbutton_ysfz_Callback(hObject, eventdata, handles)
global temp;
global Fs;
global flag;
if flag == 2;
    h=errordlg('请先检测音色','错误');
    ha=get(h,'children');
 
    hu=findall(allchild(h),'style','pushbutton');
    set(hu,'string','确定');
    ht=findall(ha,'type','text');
    set(ht,'fontsize',20);
else
    x1=temp(:,1); %读入的y矩阵有两列,取第1列
    sound(voice(x1,flag),Fs);
    N=length(voice(x1,flag)); %长度
    n=0:N-1;
    w=2*n*pi/N;
    y1=fft(voice(x1,flag)); %对原始信号做FFT变换
    plot(handles.axes4,n,voice(x1,flag)) %做原始语音信号的时域波形图
    title(handles.axes4,'变声语音信号时域图');
    xlabel(handles.axes4,'时间t');
    ylabel(handles.axes4,'幅值');

    plot(handles.axes5,w/pi,abs(y1));
    title(handles.axes5,'变声语音信号频谱')
    xlabel(handles.axes5,'频率');
    ylabel(handles.axes5,'幅度');
end;



function edit_srcsex_Callback(hObject, eventdata, handles)
% hObject    handle to edit_srcsex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_srcsex as text
%        str2double(get(hObject,'String')) returns contents of edit_srcsex as a double


% --- Executes during object creation, after setting all properties.
function edit_srcsex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_srcsex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_change_Callback(hObject, eventdata, handles)
% hObject    handle to edit_change (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_change as text
%        str2double(get(hObject,'String')) returns contents of edit_change as a double


% --- Executes during object creation, after setting all properties.
function edit_change_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_change (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_fft.
function pushbutton_fft_Callback(hObject, eventdata, handles)
global temp;
global Fs;
global n;
global temp1;
global len;
n=length(temp);%提取信号长度
temp1=fft(temp,n);%进行快速傅里叶变化
len=round((length(temp1))/2);%选取一半长度
plot(handles.axes2,abs(temp1(1:len)));%画出频域图
title(handles.axes2,'FFT变换得到的频域波形');
xlabel(handles.axes2,'频率');
ylabel(handles.axes2,'幅值');


% --- Executes on button press in pushbutton_fast.
function pushbutton_fast_Callback(hObject, eventdata, handles)
global temp;
global Fs;
M=2*Fs; %采样频率加倍
sound(temp,M)



% --- Executes on button press in pushbutton_slow.
function pushbutton_slow_Callback(hObject, eventdata, handles)
global temp;
global Fs;
M=0.5*Fs; %采样频率加倍
sound(temp,M)


% --- Executes on button press in pushbutton_sy.
function pushbutton_sy_Callback(hObject, eventdata, handles)
global temp;
global Fs;
plot(handles.axes1,temp);%画出时域图，放到坐标轴1中
title(handles.axes1,'时域波形');
xlabel(handles.axes1,'时间')
ylabel(handles.axes1,'幅值')



function wp2_Callback(hObject, eventdata, handles)
% hObject    handle to wp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wp2 as text
%        str2double(get(hObject,'String')) returns contents of wp2 as a double


% --- Executes during object creation, after setting all properties.
function wp2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ws2_Callback(hObject, eventdata, handles)
% hObject    handle to ws2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ws2 as text
%        str2double(get(hObject,'String')) returns contents of ws2 as a double


% --- Executes during object creation, after setting all properties.
function ws2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ws2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
