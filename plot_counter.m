function varargout = plot_counter(varargin)
% plot_counter MATLAB code for plot_counter.fig
%      plot_counter, by itself, creates a new plot_counter or raises the existing
%      singleton*.
%
%      H = plot_counter returns the handle to a new plot_counter or the handle to
%      the existing singleton*.
%
%      plot_counter('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in plot_counter.M with the given input arguments.
%
%      plot_counter('Property','Value',...) creates a new plot_counter or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_counter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_counter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_counter

% Last Modified by GUIDE v2.5 04-Dec-2020 14:34:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_counter_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_counter_OutputFcn, ...
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


% --- Executes just before plot_counter is made visible.
function plot_counter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_counter (see VARARGIN)

% Choose default command line output for plot_counter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes plot_counter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_counter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in plot_button.
function plot_button_Callback(hObject, eventdata, handles)
% hObject    handle to plot_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(instrfind)
dg1022z = visa( 'ni','USB0::0x1AB1::0x0642::DG1ZA000000001::INSTR' ); %Create VISA object
fopen(dg1022z);  %Open the VISA object created  
fclose(dg1022z);  %Close the VISA object   
 

y=[0 0];
x=[0 0];
 for n=1:300
   x(1,1)=x(1,2);
   x(1,2)=n; %time in actual
   y(1,1)=y(1,2);
   fprintf(dg1022z, ':Counter:Measure?' );  %Send request  
   query_counter = fscanf(dg1022z);  %Query data   
   A=strsplit(query_counter,',');
   y(1,2)=str2double(A(1)); % first value is counter freq
   h=plot(x,y);
   xlim([0 1000])
   ylim([0 1000])
   set(h,'XData',x,'YData',y,'Color','red');
   hold all;
%    pause(0.01)
 end
% --- Executes on button press in stop_button.
function stop_button_Callback(hObject, eventdata, handles)
% hObject    handle to stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 delete(instrfind)
  
