function varargout = Displace_gui(varargin)
% DISPLACE_GUI MATLAB code for Displace_gui.fig
%      DISPLACE_GUI, by itself, creates a new DISPLACE_GUI or raises the existing
%      singleton*.
%
%      H = DISPLACE_GUI returns the handle to a new DISPLACE_GUI or the handle to
%      the existing singleton*.
%
%      DISPLACE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISPLACE_GUI.M with the given input arguments.
%
%      DISPLACE_GUI('Property','Value',...) creates a new DISPLACE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Displace_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Displace_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Displace_gui

% Last Modified by GUIDE v2.5 26-Mar-2022 17:25:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Displace_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Displace_gui_OutputFcn, ...
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


% --- Executes just before Displace_gui is made visible.
function Displace_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Displace_gui (see VARARGIN)

% Choose default command line output for Displace_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Displace_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Displace_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function dis_Callback(hObject, eventdata, handles)
% hObject    handle to dis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dis as text
%        str2double(get(hObject,'String')) returns contents of dis as a double


% --- Executes during object creation, after setting all properties.
function dis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Connect.
function Connect_Callback(hObject, eventdata, handles)
% hObject    handle to Connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s;
s = serial('COM7');
fopen(s);
i = 0;
go = true;
while go
    i= i+1;
    displacement(i) = fscanf(s, '%d');
    set(handles.dis, 'string', num2str(displacement(i)));
    drawnow;
    axes(handles.axes1);
    plot(displacement, 'r','lineWidth', 2);
    grid on;
    axis([0 100 -5 5]);
end
set(handles.Connect, 'Enable', 'off');
set(handles.Close, 'Enable', 'on');
    
    


% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s;
fclose(s);
set(handles.Connect, 'Enable', 'on');
set(handles.Close, 'Enable', 'off');


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
