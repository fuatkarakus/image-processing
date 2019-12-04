function varargout = untitled(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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

function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);
set(handles.slider1,'Value',0);  
set(handles.slider1,'Value',0);

function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
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

function slider1_Callback(hObject, eventdata, handles)

global s;
global I;
global K;

s= get(handles.slider1,'Value');
K = I + s;
axes(handles.axes2);
imshow(K);

updateHistogram(K,hObject, eventdata, handles);

function slider1_CreateFcn(hObject, eventdata, handles)
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

axes(handles.axes3);
bar(h, 'r');
axes(handles.axes4);
bar(finalHist,'b');

function slider2_Callback(hObject, eventdata, handles)
global I;
global K;

s= get(handles.slider2,'Value');

K = I*(1.5 + (s/256)) + (s/256);

axes(handles.axes2);
imshow(K);

updateHistogram(K,hObject, eventdata, handles);

function slider2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
