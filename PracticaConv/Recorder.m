function varargout = Recorder(varargin)
% RECORDER MATLAB code for Recorder.fig
%      RECORDER, by itself, creates a new RECORDER or raises the existing
%      singleton*.
%
%      H = RECORDER returns the handle to a new RECORDER or the handle to
%      the existing singleton*.
%
%      RECORDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECORDER.M with the given input arguments.
%
%      RECORDER('Property','Value',...) creates a new RECORDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Recorder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Recorder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Recorder

% Last Modified by GUIDE v2.5 29-Nov-2019 16:07:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Recorder_OpeningFcn, ...
                   'gui_OutputFcn',  @Recorder_OutputFcn, ...
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


% --- Executes just before Recorder is made visible.
function Recorder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Recorder (see VARARGIN)

% Choose default command line output for Recorder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Recorder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Recorder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global recObj;
recObj = audiorecorder;
disp("Start recording");
disp('Start speaking.');
recordblocking(recObj, 5); disp('End of Recording.');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global recObj;
disp('debería sonar :c');
play(recObj);




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global recObj;
mtzaudio = getaudiodata(recObj);
plot(mtzaudio);
