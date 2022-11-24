function varargout = MPU_guide(varargin)
% MPU_GUIDE MATLAB code for MPU_guide.fig
%      MPU_GUIDE, by itself, creates a new MPU_GUIDE or raises the existing
%      singleton*.
%
%      H = MPU_GUIDE returns the handle to a new MPU_GUIDE or the handle to
%      the existing singleton*.
%
%      MPU_GUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MPU_GUIDE.M with the given input arguments.
%
%      MPU_GUIDE('Property','Value',...) creates a new MPU_GUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MPU_guide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MPU_guide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MPU_guide

% Last Modified by GUIDE v2.5 05-Apr-2022 23:49:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MPU_guide_OpeningFcn, ...
                   'gui_OutputFcn',  @MPU_guide_OutputFcn, ...
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


% --- Executes just before MPU_guide is made visible.
function MPU_guide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MPU_guide (see VARARGIN)

% Choose default command line output for MPU_guide
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MPU_guide wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MPU_guide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Connect.
function Connect_Callback(hObject, eventdata, handles)
% hObject    handle to Connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s;

% Lay Serial Com
portList = get(handles.Com, 'String');
portIndex = get(handles.Com, 'Value');
port = portList{portIndex,:};
set(s, 'Port', port);

% Lay Baud
set(s, 'BaudRate', 115200);

% s.BytesAvailableFcnMode = 'byte';
% s.BytesAvailableFcnCount = 7 ;   
% s.BytesAvailableFcn ={@getData, handles};


% Ket noi COM
fopen(s);
set(handles.Connect,'Enable', 'off');
set(handles.Disconnect,'Enable', 'on');
set(handles.Com,'Enable', 'off');

displacement = 0;
go = true;

 while go
   data = fscanf(s, '%d');
   set(handles.Output,'String', num2str(data));
   axes(handles.axes1);
   displacement = [displacement data]
   plot(displacement, 'r', 'linewidth' , 1.25);
   grid on;
   xlabel('Time (s)','FontSize',12,'FontWeight','bold','Color','black');
   ylabel('displacement (mm)','FontSize',12,'FontWeight','bold','Color','black');
   title ('Realtime displacement','FontSize',20,'FontWeight','bold','Color','black')
   drawnow;
%    axis([i-50, i+50, -30 30])
%    hold on;

   pause(0.01);
  
  
 end





function Output_Callback(hObject, eventdata, handles)
% hObject    handle to Output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Output as text
%        str2double(get(hObject,'String')) returns contents of Output as a double


% --- Executes during object creation, after setting all properties.
function Output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Disconnect.
function Disconnect_Callback(hObject, eventdata, handles)
% hObject    handle to Disconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s ;

fclose(s);
clear all;
clc;
set(handles.Connect,'Enable', 'on');
set(handles.Disconnect,'Enable', 'off');
set(handles.Com,'Enable', 'on');



% --- Executes on selection change in Com.
function Com_Callback(hObject, eventdata, handles)
% hObject    handle to Com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Com contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Com


% --- Executes during object creation, after setting all properties.
function Com_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s;
if (strcmp(get(s, 'Status'), 'open'))
    fclose(s);
end
delete(s);
clear s;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global s;
s = serial('COM6');



% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
