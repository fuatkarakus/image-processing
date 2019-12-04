function varargout = filterAssig(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @filterAssig_OpeningFcn, ...
                   'gui_OutputFcn',  @filterAssig_OutputFcn, ...
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


% --- Executes just before filterAssig is made visible.
function filterAssig_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%set('selectedobject',handles.radiobutton4);

% --- Outputs from this function are returned to the command line.
function varargout = filterAssig_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
% select image
global image;
global pn;
pn = 1;
[filename, pathname]=uigetfile('*.*','Choose an image');
filePath = strcat(pathname, filename);
image = imread(filePath);
I = im2double(rgb2gray(image));
axes(handles.axes1)
imshow(I)
set(handles.fileName,'string',filename);
set(handles.path,'string',filePath);


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
%  gaussian
global D0;
global pn;
global image;

I = rgb2gray(image);
I = im2double(I);

[M N]= size (I);

F =fft2(I);
F = fftshift(F);
H = zeros(M,N);

D0 = round(get(handles.slider1,'Value'));

xc = M/2;
yc = N/2;
for i=1:M
    for j = 1:N
       dist = sqrt(power(i-xc,2)+power(j-yc,2));
       %H(i,j) = 1/power((1+dist/D0),4);
        H(i,j) = exp(-dist*dist/(2*D0*D0));
    end
end
%H = 1-H;


if pn==1
    F = F.*H;
    IF = ifftshift(F);
    g = ifft2(IF);
    axes(handles.axes3);
    imshow(H);
    axes(handles.axes2);
    imshow(g);
    
elseif pn==-1
    H = 1-H;
    F = F.*H;
    IF = ifftshift(F);
    g = ifft2(IF);
    axes(handles.axes3);
    imshow(H);
    axes(handles.axes2);
    imshow(g);
    
end

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% butterwoth
global D0;
global pn;
D0=round(get(handles.slider1,'Value'));		
global image;

I = rgb2gray(image);
I = im2double(I);
n=1;
h=size(I,1);
w=size(I,2);
fftim = fftshift(fft2(double(I)));
[x y]=meshgrid(-floor(w/2):floor(w/2)-1,-floor(h/2):floor(h/2)-1);

B = sqrt(2) - 1; %// Define B
D = sqrt(x.^2 + y.^2); %// Define distance to centre
hhp = 1 ./ (1 + B * ((D0 ./ D).^(2 * n)));

if pn==-1
    out_spec_centre = fftim .* hhp;
    %// Uncentre spectrum
    out_spec = ifftshift(out_spec_centre);
    %// Inverse FFT, get real components
    out = real(ifft2(out_spec));
    %// Normalize and cast
    out = (out - min(out(:))) / (max(out(:)) - min(out(:)));
    out = uint8(255*out);
    axes(handles.axes3);
    imshow(hhp);
    axes(handles.axes2);
    imshow(out);
elseif pn==1
    hhp = 1-hhp;
    out_spec_centre = fftim .* hhp;
    %// Uncentre spectrum
    out_spec = ifftshift(out_spec_centre);
    %// Inverse FFT, get real components
    out = real(ifft2(out_spec));
    %// Normalize and cast
    out = (out - min(out(:))) / (max(out(:)) - min(out(:)));
    out = uint8(255*out);
    axes(handles.axes3);
    imshow(hhp);
    axes(handles.axes2);
    imshow(out);
end

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% Ideal
global D0;
global pn;
D0=round(get(handles.slider1,'Value'));		
global image;
I = rgb2gray(image);
I = im2double(I);

[ir,ic,iz] = size(I);
hr = (ir-1)/2;
hc = (ic-1)/2;
[x, y] = meshgrid(-hc:hc, -hr:hr); 
mg = sqrt((x/hc).^2 + (y/hr).^2);

IM = fftshift(fft2(double(I)));
IP = zeros(size(IM));

if pn==1
    lp = double(mg <= D0);
    for z = 1:iz
        IP(:,:,z) = IM(:,:,z) .* lp;
    end
    im = abs(ifft2(ifftshift(IP)));
    
    axes(handles.axes3);
    imshow(lp);
    axes(handles.axes2);
    imshow(im);
elseif pn==-1
    lp = double(mg >= D0);
    for z = 1:iz
        IP(:,:,z) = IM(:,:,z) .* lp;
    end
    im = abs(ifft2(ifftshift(IP)));
    axes(handles.axes3);
    imshow(lp);
    axes(handles.axes2);
    imshow(im);
end

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% Low pass
global pn;
pn=1;

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% High pass
global pn;
pn=-1;



function fileName_Callback(hObject, eventdata, handles)
% hObject    handle to fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileName as text
%        str2double(get(hObject,'String')) returns contents of fileName as a double


% --- Executes during object creation, after setting all properties.
function fileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function path_Callback(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path as text
%        str2double(get(hObject,'String')) returns contents of path as a double


% --- Executes during object creation, after setting all properties.
function path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
