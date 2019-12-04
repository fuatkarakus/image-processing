function varargout = hw1_test(varargin)
% HW1_TEST MATLAB code for hw1_test.fig
%      HW1_TEST, by itself, creates a new HW1_TEST or raises the existing
%      singleton*.
%
%      H = HW1_TEST returns the handle to a new HW1_TEST or the handle to
%      the existing singleton*.
%
%      HW1_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HW1_TEST.M with the given input arguments.
%
%      HW1_TEST('Property','Value',...) creates a new HW1_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hw1_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hw1_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hw1_test

% Last Modified by GUIDE v2.5 30-Oct-2019 19:10:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hw1_test_OpeningFcn, ...
                   'gui_OutputFcn',  @hw1_test_OutputFcn, ...
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


% --- Executes just before hw1_test is made visible.
function hw1_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hw1_test (see VARARGIN)

% Choose default command line output for hw1_test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.slider1,'Value',0);  
set(handles.slider2,'Value',0);



% UIWAIT makes hw1_test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hw1_test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I;
global K;

[filename, pathname] = uigetfile('*.*', 'Choose an image');
myfilename = [pathname filename];
I = imread(myfilename);
I = rgb2gray(I);

[M N] = size(I);
K = zeros(M,N);

axes(handles.axes1);
imshow(I);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


global s;
global I;
global K;

s= get(handles.slider1,'Value');

K = I + s;

%if all(K < 0.01)
%    K = I + s;
%else
%    K = K + s;
%end

axes(handles.axes2);
imshow(K);

updateHistogram(K,hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function updateHistogram(K, hObject, eventdata, handles)

h = zeros(1,256);
[M N] = size(K);

for i=1:M
  for j=1:N
      %h(1,I(i,j)+1) = h(1,I(i,j)+1)+1;
      h(1,K(i,j)+1) = h(1,K(i,j)+1)+1;
 end
end

A = uint8(zeros(M, N));

freq=zeros(256,1);
pmf=zeros(256,1);
result=zeros(256,1);

pixelsCount = M*N;

for i=1:M
    for j=1:N
        freq(K(i,j)+1)=freq(K(i,j)+1)+1;
        pmf(K(i,j)+1)=freq(K(i,j)+1)/pixelsCount;
    end
end


cdf=0;
levels = 255;

for i=1:size(pmf)
   cdf = cdf + pmf(i);
   result(i)=round(cdf*levels);
end

for i=1:size(K,1)
    for j=1:size(K,2)
        A(i,j)=result(K(i,j)+1);
    end
end

finalHist = zeros(1,256);

for i=1:M
  for j=1:N
      %h(1,I(i,j)+1) = h(1,I(i,j)+1)+1;
      finalHist(1,A(i,j)+1) = finalHist(1,A(i,j)+1)+1;
 end
end


axes(handles.axes5);
imshow(A);

axes(handles.axes3);
bar(h, 'r');
axes(handles.axes4);
bar(finalHist,'b');

%pixels = linspace(0,255,256);
%[AX H1 H2] = plotyy(pixels, h, pixels, finalHist, 'bar', 'bar');
%set(H1,'FaceColor','r');
%set(H2,'FaceColor','b');



J = histeq(K);
axes(handles.axes6);
imshow(J);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I;
global K;

updateHistogram(K,hObject, eventdata, handles);

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


global I;
global K;

s= get(handles.slider2,'Value');

K = I*(1 + (s/256)) + (s/256);

%if all(K < 0.01)
%    K = I*(1 + (s/256)) + (s/256);
%else
%    K = K*(1 + (s/256)) + (s/256);
%end

axes(handles.axes2);
imshow(K);

updateHistogram(K,hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
