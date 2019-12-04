function varargout = assig2(varargin)
% ASSIG2 MATLAB code for assig2.fig
%      ASSIG2, by itself, creates a new ASSIG2 or raises the existing
%      singleton*.
%
%      H = ASSIG2 returns the handle to a new ASSIG2 or the handle to
%      the existing singleton*.
%
%      ASSIG2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASSIG2.M with the given input arguments.
%
%      ASSIG2('Property','Value',...) creates a new ASSIG2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before assig2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to assig2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help assig2

% Last Modified by GUIDE v2.5 27-Nov-2019 01:27:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @assig2_OpeningFcn, ...
                   'gui_OutputFcn',  @assig2_OutputFcn, ...
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


% --- Executes just before assig2 is made visible.
function assig2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to assig2 (see VARARGIN)

% Choose default command line output for assig2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes assig2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = assig2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
[filename pathname] = uigetfile('*.*', 'Choose an image');
image = strcat(pathname, filename);
axes(handles.axes3)
imshow(image)
set(handles.namaFile,'string',filename);
set(handles.almPath,'string',image);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambar = get(handles.almPath,'String');
matrixRGB = imread(gambar);

matrixBlur = [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];
% matrixBlur = [0 -1 0; -1 5 -1; 0 -1 0];
yR = matrixRGB(:,:,1)*0;
yG = matrixRGB(:,:,2)*0;
yB = matrixRGB(:,:,3)*0;
sumR = 0;
sumG = 0;
sumB = 0;

matrixR = padarray(matrixRGB(:,:,1),[1 1],0);
matrixG = padarray(matrixRGB(:,:,2),[1 1],0);
matrixB = padarray(matrixRGB(:,:,3),[1 1],0);

for i=1:size(yR,1)
    for j=1:size(yR,2)
        cuttedR = matrixR(i:i+2,j:j+2);
        cuttedG = matrixG(i:i+2,j:j+2);
        cuttedB = matrixB(i:i+2,j:j+2);
        mpxR = double(cuttedR).*matrixBlur;
        mpxG = double(cuttedG).*matrixBlur;
        mpxB = double(cuttedB).*matrixBlur;
        sumR = sum(mpxR(:));
        sumG = sum(mpxG(:));
        sumB = sum(mpxB(:));
           
        yR(i,j) = sumR;
        yG(i,j) = sumG;
        yB(i,j) = sumB;
        sumR = 0;
        sumG = 0;
        sumB = 0;
    end
end
% y = conv2(matrixRGB,matrixBlur,'same');
y = cat(3,yR,yG,yB);

% axes(handles.axes3);
% imshow(gambar);
axes(handles.picFrame);
imshow(y);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambar = get(handles.almPath,'String');
matrixRGB = imread(gambar);

% matrixED = [-1 -1 -1; -1 8 -1; -1 -1 -1];
matrixED = [1 1 1; 1 -8 1; 1 1 1];

yR = matrixRGB(:,:,1)*0;
yG = matrixRGB(:,:,2)*0;
yB = matrixRGB(:,:,3)*0;
sumR = 0;
sumG = 0;
sumB = 0;

matrixR = padarray(matrixRGB(:,:,1),[1 1],0);
matrixG = padarray(matrixRGB(:,:,2),[1 1],0);
matrixB = padarray(matrixRGB(:,:,3),[1 1],0);

for i=1:size(yR,1)
    for j=1:size(yR,2)
        cuttedR = matrixR(i:i+2,j:j+2);
        cuttedG = matrixG(i:i+2,j:j+2);
        cuttedB = matrixB(i:i+2,j:j+2);
        mpxR = double(cuttedR).*matrixED;
        mpxG = double(cuttedG).*matrixED;
        mpxB = double(cuttedB).*matrixED;
        sumR = sum(mpxR(:));
        sumG = sum(mpxG(:));
        sumB = sum(mpxB(:));
           
        yR(i,j) = sumR;
        yG(i,j) = sumG;
        yB(i,j) = sumB;
        sumR = 0;
        sumG = 0;
        sumB = 0;
    end
end
% y = conv2(matrixRGB,matrixBlur,'same');
y = cat(3,yR,yG,yB);

axes(handles.axes3);
imshow(gambar);
axes(handles.picFrame);
imshow(y);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambar = get(handles.almPath,'String');
matrixRGB = imread(gambar);

matrixSharp = [0 -1 0; -1 5 -1; 0 -1 0];
yR = matrixRGB(:,:,1)*0;
yG = matrixRGB(:,:,2)*0;
yB = matrixRGB(:,:,3)*0;
sumR = 0;
sumG = 0;
sumB = 0;

matrixR = padarray(matrixRGB(:,:,1),[1 1],0);
matrixG = padarray(matrixRGB(:,:,2),[1 1],0);
matrixB = padarray(matrixRGB(:,:,3),[1 1],0);

for i=1:size(yR,1)
    for j=1:size(yR,2)
        cuttedR = matrixR(i:i+2,j:j+2);
        cuttedG = matrixG(i:i+2,j:j+2);
        cuttedB = matrixB(i:i+2,j:j+2);
        mpxR = double(cuttedR).*matrixSharp;
        mpxG = double(cuttedG).*matrixSharp;
        mpxB = double(cuttedB).*matrixSharp;
        sumR = sum(mpxR(:));
        sumG = sum(mpxG(:));
        sumB = sum(mpxB(:));
           
        yR(i,j) = sumR;
        yG(i,j) = sumG;
        yB(i,j) = sumB;
        sumR = 0;
        sumG = 0;
        sumB = 0;
    end
end
% y = conv2(matrixRGB,matrixBlur,'same');
y = cat(3,yR,yG,yB);

axes(handles.axes3);
imshow(gambar);
axes(handles.picFrame);
imshow(y);


function namaFile_Callback(hObject, eventdata, handles)
% hObject    handle to namaFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of namaFile as text
%        str2double(get(hObject,'String')) returns contents of namaFile as a double


% --- Executes during object creation, after setting all properties.
function namaFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to namaFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function almPath_Callback(hObject, eventdata, handles)
% hObject    handle to almPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of almPath as text
%        str2double(get(hObject,'String')) returns contents of almPath as a double


% --- Executes during object creation, after setting all properties.
function almPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to almPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
