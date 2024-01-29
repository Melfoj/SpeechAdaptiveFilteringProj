function varargout = proba(varargin)
% PROBA MATLAB code for proba.fig
%      PROBA, by itself, creates a new PROBA or raises the existing
%      singleton*.
%
%      H = PROBA returns the handle to a new PROBA or the handle to
%      the existing singleton*.
%
%      PROBA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROBA.M with the given input arguments.
%
%      PROBA('Property','Value',...) creates a new PROBA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proba_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proba_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proba

% Last Modified by GUIDE v2.5 23-Oct-2017 21:33:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proba_OpeningFcn, ...
                   'gui_OutputFcn',  @proba_OutputFcn, ...
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


% --- Executes just before proba is made visible.
function proba_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proba (see VARARGIN)

% Choose default command line output for proba
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proba wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = proba_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function b1_Callback(hObject, eventdata, handles)

[FileName,PathName] = uigetfile('*.wav') ;
filename=[PathName FileName];
[x,fs]=audioread(filename);

z1_banka_filtara_i(x,fs);


function b2_Callback(hObject, eventdata, handles)

[FileName,PathName] = uigetfile('*.wav') ;
filename=[PathName FileName];
[x,fs]=audioread(filename);

z2_rucno_i(x,fs);


function b3_Callback(hObject, eventdata, handles)

[FileName,PathName] = uigetfile('*.wav') ;
filename=[PathName FileName];
[x,fs]=audioread(filename);

z3_decimacija_i(x,fs);


function b4_Callback(hObject, eventdata, handles)

[FileName,PathName] = uigetfile('*.wav') ;
filename=[PathName FileName];
[x,fs]=audioread(filename);

z4_fft_i(x,fs);


function b5_Callback(hObject, eventdata, handles)

[FileName,PathName] = uigetfile('*.wav') ;
filename=[PathName FileName];
[x,fs]=audioread(filename);

z5_spektrogram_i(x,fs);
