function varargout = test2(varargin)
% TEST2 MATLAB code for test2.fig
%      TEST2, by itself, creates a new TEST2 or raises the existing
%      singleton*.
%
%      H = TEST2 returns the handle to a new TEST2 or the handle to
%      the existing singleton*.
%
%      TEST2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST2.M with the given input arguments.
%
%      TEST2('Property','Value',...) creates a new TEST2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test2

% Last Modified by GUIDE v2.5 29-Dec-2020 11:45:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test2_OpeningFcn, ...
                   'gui_OutputFcn',  @test2_OutputFcn, ...
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


% --- Executes just before test2 is made visible.
function test2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test2 (see VARARGIN)

% Choose default command line output for test2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in button_open.
function button_open_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.wav;*.mp3','*.wav;*.mp3'},'ѡ�������ļ�');
if isequal([filename pathname],[0,0])
    return;
end
str=[pathname filename];%ѡ��������ļ�·�����ļ���
global temp;
global Fs;
[temp,Fs]=audioread(str);%temp��ʾ�������� Fs��ʾƵ��
handles.y=temp;handles.Fs=Fs;


% --- Executes on button press in button_play.
function button_play_Callback(hObject, eventdata, handles)
global temp;
global Fs;
sound(temp,Fs);%������Ƶ�ļ�



% --- Executes on button press in button_shiyu.
function button_shiyu_Callback(hObject, eventdata, handles)
global temp;
global Fs;
plot(handles.axes1,temp);%����ʱ��ͼ���ŵ�������1��
title(handles.axes1,'���Բ��Բ���A');
xlabel(handles.axes1,'ʱ��')
ylabel(handles.axes1,'��ֵ')


% --- Executes on button press in button_pinyu.
function button_pinyu_Callback(hObject, eventdata, handles)
global temp;
global Fs;
global n;
global temp1;
global len;
n=length(temp);%��ȡ�źų���
temp1=fft(temp,n);%���п��ٸ���Ҷ�仯
len=round((length(temp1))/2);%ѡȡһ�볤��
plot(handles.axes2,abs(temp1(1:len)));%����Ƶ��ͼ
title('���Բ��Բ���');
xlabel(handles.axes2,'Ƶ��');
ylabel(handles.axes2,'��ֵ');
