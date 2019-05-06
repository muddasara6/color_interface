function varargout = Color_Detect(varargin)
% COLOR_DETECT MATLAB code for Color_Detect.fig
%      COLOR_DETECT, by itself, creates a new COLOR_DETECT or raises the existing
%      singleton*.
%
%      H = COLOR_DETECT returns the handle to a new COLOR_DETECT or the handle to
%      the existing singleton*.
%
%      COLOR_DETECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLOR_DETECT.M with the given input arguments.
%
%      COLOR_DETECT('Property','Value',...) creates a new COLOR_DETECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Color_Detect_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Color_Detect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Color_Detect

% Last Modified by GUIDE v2.5 03-Apr-2019 16:49:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Color_Detect_OpeningFcn, ...
                   'gui_OutputFcn',  @Color_Detect_OutputFcn, ...
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

% --- Executes just before Color_Detect is made visible.
function Color_Detect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Color_Detect (see VARARGIN)

% Choose default command line output for Color_Detect
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Set tools visibility and enability off
set(handles.axes1, 'visible', 'off');
set(handles.axes2, 'visible', 'off');
set(handles.uipanel1, 'visible', 'off');
set(handles.uipanel2, 'visible', 'off');
set(handles.start, 'enable', 'off');
set(handles.oi, 'visible', 'off');
set(handles.dc, 'visible', 'off');
set(handles.uipanel3, 'visible', 'off');
set(handles.startv, 'enable', 'off');
set(handles.text, 'enable', 'off');
set(handles.set, 'enable', 'off');
set(handles.pop, 'enable', 'off');
set(handles.text5, 'visible', 'off');  

% UIWAIT makes Color_Detect wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Color_Detect_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Set the enable off
set(handles.startv, 'enable', 'off');
set(handles.start_scale_detection, 'enable', 'off');

% --- Executes on button press in image.
function image_Callback(hObject, eventdata, handles)
% hObject    handle to image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Sets to invisible
set(handles.uipanel1, 'visible', 'on');
set(handles.video, 'enable', 'off');

% --- Executes on button press in video.
function video_Callback(hObject, eventdata, handles)
% hObject    handle to video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.image, 'enable', 'off');
% Set enable on
set(handles.text, 'enable', 'on');
set(handles.pop, 'enable', 'on');

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Stores an association to a function
im = handles.im; 
x = handles.x;
% Execute one of several groups of statements
switch x
    % Each choice is covered by a case statement
    case 1
        axes(handles.axes2); 
        cla;
        im = handles.im;
        % Set red colour
        r = im(:, :, 1);
        % Set green colour
        g = im(:, :, 2); 
        % Set blue colour
        b = im(:, :, 3);
        % Subtract the red colour
        diff = imsubtract(r, rgb2gray(im));
        % Convert image to binary image, based on threshold
        bw = im2bw(diff, 0.18); 
        % Remove small objects from binary image
        area = bwareaopen(bw, 300); 
        % Detect all red objects
        rm = immultiply(area, r);  
        gm = g.*0;  
        bm = b.*0; 
        image = cat(3, rm, gm, bm); 
        % Display image
        imshow(image);
    case 2        
        axes(handles.axes2); 
        cla;        
        im = handles.im;
        r = im(:, :, 1); 
        g = im(:, :, 2); 
        b = im(:, :, 3);
        diff = imsubtract(g, rgb2gray(im)); 
        bw = im2bw(diff, 0.18); 
        area = bwareaopen(bw, 300); 
        gm = immultiply(area, g);  
        rm = r.*0;  
        bm = b.*0; 
        image = cat(3, rm, gm, bm); 
        imshow(image);
    case 3        
        axes(handles.axes2); 
        cla;        
        im = handles.im;
        r = im(:, :, 1); 
        g = im(:, :, 2); 
        b = im(:, :, 3);
        diff = imsubtract(b, rgb2gray(im));
        bw = im2bw(diff, 0.18);
        area = bwareaopen(bw, 300);
        bm = immultiply(area, b);  
        gm = g.*0; 
        rm = r.*0;
        image = cat(3, rm, gm, bm);
        imshow(image); 
    case 4        
        im1 = getimage(handles.axes2);      
        im1 = handles.im;
        % Set to grayscale
        im = rgb2gray(im);  
        % Display image in a GUI figure
        subplot(handles.axes2), imshow(im);      
        if im == 0           
            return     
        end   
        [row, col] = size(im); 
        % Set row value to 4
        for x=4:row-4       
            % Set column value to 4
            for y=4:col-4 
                % Create edge detection
                % Find edges of an object and set colour to gray
                im2(x,y) = abs(im(x,y) - im(x+4,y+4)) + abs(im(x,y+4) ...
                    - im(x+4,y));     
            end            
        end        
        subplot(handles.axes2), imshow(im2);
end
set(handles.dc, 'visible', 'on');

% --- Executes on button press in red.
function red_Callback(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Set to case 1
handles.x = 1;
% Call handles structure
guidata(hObject,handles);
set(handles.start, 'enable', 'on');

% --- Executes on button press in green.
function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.x = 2;
guidata(hObject,handles);
set(handles.start, 'enable', 'on');

% --- Executes on button press in blue.
function blue_Callback(hObject, eventdata, handles)
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.x = 3;
set(handles.start, 'enable', 'on');
guidata(hObject, handles);

% --- Executes on button press in camera.
function camera_Callback(hObject, eventdata, handles)
% hObject    handle to camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Disconnect and delete all image acquisition objects
imaqreset
info = imaqhwinfo;
name = char(info.InstalledAdaptors(end));
c_info = imaqhwinfo(name);
% Acquire webcam device
id = c_info.DeviceInfo.DeviceID(end);
format = char(c_info.DeviceInfo.SupportedFormats(end));
% Create video input object
handles.vid = videoinput(name, id, format);
axes(handles.axes1);
% Clear axes
cla;
% Create wait bar dialog box
h = waitbar(0, 'Please wait...');
steps = 200;
for step = 1:steps
    % computations take place here
    waitbar(step / steps);
end
% close wait bar dialog box
close(h);
% Preview of live video data
preview(handles.vid);
set(handles.snap, 'enable', 'on');
guidata(hObject, handles);
set(handles.uipanel2, 'visible', 'on');
set(handles.oi, 'visible', 'on');

% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Browse the file from user

% Load image to figure using uigetfile
[file, path] = uigetfile({'*.jpg';'*.bmp';'*.jpeg';'*.png'}, 'Load Image File within Avilable Extensions');
image = [path, file];
handles.file = image;
if (file == 0)
    % Create warning dialog box
    warndlg('You did not selected any file'); % file is not selected
end
[fpath, fname, fext] = fileparts(file);
validex = ({'.bmp', '.jpg', '.jpeg', '.png'});
found = 0;
for x=1:length(validex)
    if (strcmpi(fext, validex{x}))
    found = 1;
    handles.im = imread(image);
    axes(handles.axes1); 
    cla; 
    h = waitbar(0,'Please wait...');
    steps = 100;
    for step = 1:steps    
        % computations take place here    
        waitbar(step / steps)
    end    
    close(h)  
    end    
end
imshow(handles.im);
if (found == 0)     
    errordlg('Selected file does not match available extensions. Please select file from available extensions [.jpg, .jpeg, .bmp, .png]', 'Image Format Error');
end
guidata(hObject, handles);
set(handles.uipanel2, 'visible', 'on');
set(handles.oi, 'visible', 'on');

% --- Executes on button press in snap.
function snap_Callback(hObject, eventdata, handles)
% hObject    handle to snap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Display videoPlayer in axes
handles.im = getsnapshot(handles.vid);
axes(handles.axes1); 
cla; 
imshow(handles.im);
% Close preview of video
closepreview(handles.vid);
guidata(hObject, handles);

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); 
cla;
axes(handles.axes2); 
cla;
set(handles.axes1, 'visible', 'off');
set(handles.axes2, 'visible', 'off');
set(handles.uipanel1, 'visible', 'off');
set(handles.uipanel2, 'visible', 'off');
set(handles.start, 'enable', 'off');
set(handles.snap, 'enable', 'off');
set(handles.oi, 'visible', 'off');
set(handles.dc, 'visible', 'off');
set(handles.video, 'enable', 'on');
set(handles.image, 'enable', 'on');
set(handles.uipanel3, 'visible', 'off');
set(handles.startv, 'enable', 'off');
set(handles.text, 'enable', 'off');
set(handles.set, 'enable', 'off');
set(handles.pop, 'enable', 'off');
set(handles.text5, 'visible', 'off');

% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Close GUI
close

% --- Executes on button press in set.
function set_Callback(hObject, eventdata, handles)
% hObject    handle to set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.val = handles.frame;
guidata(hObject, handles);
set(handles.uipanel3, 'visible', 'on');

% --- Executes on button press in startv.
function startv_Callback(hObject, eventdata, handles)
% hObject    handle to startv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); 
cla;
axes(handles.axes2); 
cla;
set(handles.axes1, 'visible', 'off');
set(handles.axes2, 'visible', 'off');
set(handles.uipanel1, 'visible', 'off');
set(handles.uipanel2, 'visible', 'off');
set(handles.start, 'enable', 'off');
set(handles.snap, 'enable', 'off');
set(handles.oi, 'visible', 'off');
set(handles.dc, 'visible', 'off');
set(handles.video, 'enable', 'off');
set(handles.image, 'enable', 'off');
set(handles.uipanel3, 'visible', 'off');
set(handles.startv, 'enable', 'off');
set(handles.text, 'enable', 'off');
set(handles.set, 'enable', 'off');
set(handles.pop, 'enable', 'off');
set(handles.text5, 'visible', 'off');
set(handles.dc, 'visible', 'on');
set(handles.text5, 'visible', 'on');
h = waitbar(0, 'Please wait...');
steps = 200;
for step = 1:steps
    % computations take place here
    waitbar(step / steps)
end
close(h)
switch handles.cv
    case 1
        imaqreset
        info = imaqhwinfo;
        name = char(info.InstalledAdaptors(end));
        c_info = imaqhwinfo(name);
        id = c_info.DeviceInfo.DeviceID(end);
        format = char(c_info.DeviceInfo.SupportedFormats(end));
        vid= videoinput(name, id, format);
         set(vid, 'FramesPerTrigger', Inf);
        set(vid, 'ReturnedColorspace', 'rgb');
        vid.FrameGrabInterval = 5;
        start(vid);
        % Set loop from the value of slider                
        while(vid.FramesAcquired <= handles.val)              
            % current snapshot               
            im = getsnapshot(vid);            
            r = im(:, :, 1); 
            g = im(:, :, 2); 
            b = im(:, :, 3);            
            diff = imsubtract(r, rgb2gray(im));            
            bw = im2bw(diff, 0.18);           
            area = bwareaopen(bw, 300);            
            rm = immultiply(area,r);  
            gm = g.*0;  
            bm = b.*0;            
            image = cat(3, rm, gm, bm);            
            axes(handles.axes2);            
            imshow(image); 
            axes(handles.axes1);            
            imshow(im);            
        end        
        stop(vid);        
        flushdata(vid);        
        clear all;
    case 2      
        imaqreset
        info = imaqhwinfo;
        name = char(info.InstalledAdaptors(end));
        c_info = imaqhwinfo(name);
        id = c_info.DeviceInfo.DeviceID(end);
        format = char(c_info.DeviceInfo.SupportedFormats(end));
        vid= videoinput(name, id, format);
        set(vid, 'FramesPerTrigger', Inf);
        set(vid, 'ReturnedColorspace', 'rgb');
        vid.FrameGrabInterval = 5;
        start(vid);
        % Set loop from the value of slider              
        while(vid.FramesAcquired <= handles.val)        
            % current snapshot            
            im = getsnapshot(vid);            
            r = im(:, :, 1); 
            g = im(:, :, 2); 
            b = im(:, :, 3);            
            diff = imsubtract(g, rgb2gray(im));            
            bw = im2bw(diff, 0.18);            
            area = bwareaopen(bw, 300);            
            gm = immultiply(area, g);  
            rm = r.*0;  
            bm = b.*0;            
            image = cat(3, rm, gm, bm);            
            axes(handles.axes2);            
            imshow(image);            
            axes(handles.axes1);            
            imshow(im);            
        end        
        stop(vid);        
        flushdata(vid);        
        clear all;                
    case 3       
        imaqreset
        info = imaqhwinfo;
        name = char(info.InstalledAdaptors(end));
        c_info = imaqhwinfo(name);
        id = c_info.DeviceInfo.DeviceID(end);
        format = char(c_info.DeviceInfo.SupportedFormats(end));
        vid= videoinput(name, id, format);
        set(vid, 'FramesPerTrigger', Inf);
        set(vid, 'ReturnedColorspace', 'rgb');
        vid.FrameGrabInterval = 5;
        start(vid);
        % Set loop from the value of slider            
        while(vid.FramesAcquired <= handles.val)        
            % current snapshot            
            im = getsnapshot(vid);            
            r = im(:, :, 1); 
            g = im(:, :, 2);
            b = im(:, :, 3);            
            diff = imsubtract(b, rgb2gray(im));            
            bw = im2bw(diff, 0.18);            
            area = bwareaopen(bw, 300);            
            bm = immultiply(area, b); 
            gm = g.*0; 
            rm = r.*0;              
            image = cat(3, rm, gm, bm);         
            axes(handles.axes2);            
            imshow(image);            
            axes(handles.axes1);            
            imshow(im);            
        end        
        stop(vid);        
        flushdata(vid);        
        clear all;
end

% --- Executes on button press in bluev.
function bluev_Callback(hObject, eventdata, handles)
% hObject    handle to bluev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cv = 3;
guidata(hObject, handles);
set(handles.startv, 'enable', 'on');

% --- Executes on button press in greenv.
function greenv_Callback(hObject, eventdata, handles)
% hObject    handle to greenv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cv = 2;
guidata(hObject, handles);
set(handles.startv, 'enable', 'on');

% --- Executes on button press in redv.
function redv_Callback(hObject, eventdata, handles)
% hObject    handle to redv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cv = 1;
guidata(hObject, handles);
set(handles.startv, 'enable', 'on');

% --- Executes on selection change in pop.
function pop_Callback(hObject, eventdata, handles)
% hObject    handle to pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop contents as cell array
% contents{get(hObject,'Value')} returns selected item from pop
val = get(hObject, 'value');
switch val
    case 1
        warndlg('Please select a frame value');
        set(handles.set, 'enable', 'off');
    case 2  
        handles.frame = 25;
        set(handles.set, 'enable', 'on');      
    case 3 
        handles.frame = 50;
        set(handles.set, 'enable', 'on');       
    case 4  
        handles.frame = 100;
        set(handles.set, 'enable', 'on');       
    case 5  
        handles.frame = 150;
        set(handles.set, 'enable', 'on');       
    case 6  
        handles.frame = 200;
        set(handles.set, 'enable', 'on');         
    case 7  
        handles.frame = 300;
        set(handles.set, 'enable', 'on');          
    case 8  
        handles.frame = 400;        
        set(handles.set, 'enable', 'on');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
% See ISPC and COMPUTER.
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))    
    set(hObject, 'BackgroundColor', 'white');
end

% --- Executes on button press in custom_detection.
function custom_detection_Callback(hObject, eventdata, handles)
% hObject    handle to custom_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.x = 4;
set(handles.start, 'enable', 'on');
guidata(hObject, handles);

% --- Executes on button press in start_scale_detection.
function start_scale_detection_Callback(hObject, eventdata, handles)
% hObject    handle to custom_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch handles.cv1 
    case 1
    % ------ Select Black_and_white* ------
    %Always the first operator to a properly work     
    imaqreset;    
    info = imaqhwinfo;     
    name = char(info.InstalledAdaptors(end));    
    c_info = imaqhwinfo(name);    
    id = c_info.DeviceInfo.DeviceID(end);    
    format = char(c_info.DeviceInfo.SupportedFormats(end));    
    vid = videoinput(name, id, format);    
    set(vid, 'FramesPerTrigger', Inf);    
    set(vid, 'ReturnedColorspace', 'rgb');    
    vid.FrameGrabInterval = 5;    
    start(vid);      
    while(vid.FramesAcquired <= 100)    
        % current snapshot        
        data = getsnapshot(vid);          
        diff_im = imsubtract(data(:, :, 1), rgb2gray(data));          
        diff_im = medfilt2(diff_im, [3, 3]);           
        diff_im = im2bw(diff_im, 0.10);            
        diff_im = bwareaopen(diff_im, 300);                     
        bw = bwlabel(diff_im, 8);          
        stats=regionprops(bw, 'BoundingBox', 'Centroid');     
        image(data);            
        hold on;           
        for object=1:length(stats)          
            bb=stats(object).BoundingBox;                
            bo=stats(object).Centroid;                
            rectangle('Position', bb, 'EdgeColor', 'r', 'LineWidth', 2);                
            plot(bo(1), bo(2), 'm+');                
        end
        hold off;    
    end    
    stop(vid);    
    flushdata(vid);              
    clear all;    
    case 2    
        imaqreset;        
        info = imaqhwinfo;        
        name = char(info.InstalledAdaptors(end));        
        c_info = imaqhwinfo(name);
        id = c_info.DeviceInfo.DeviceID(end);
        format = char(c_info.DeviceInfo.SupportedFormats(end));
        vid = videoinput(name, id, format);
        set(vid, 'FramesPerTrigger', Inf);
        set(vid, 'ReturnedColorspace', 'rgb');
        vid.FrameGrabInterval = 5;
        start(vid);      
        while(vid.FramesAcquired <= 100)
            % current snapshot        
            data = getsnapshot(vid);            
            diff_im = imsubtract(data(:, :, 2), rgb2gray(data));            
            diff_im = medfilt2(diff_im, [3, 3]);            
            diff_im = im2bw(diff_im, 0.10);            
            diff_im = bwareaopen(diff_im, 300);                        
            bw = bwlabel(diff_im, 8);            
            stats = regionprops(bw, 'BoundingBox', 'Centroid');            
            image(data);            
            hold on;          
            for object=1:length(stats)            
                bb = stats(object).BoundingBox;                
                bo = stats(object).Centroid;                
                rectangle('Position', bb, 'EdgeColor', 'g', 'LineWidth', 2);                
                plot(bo(1), bo(2), 'm+');                
            end            
            hold off;            
        end  
        stop(vid);                
        flushdata(vid);                
        clear all;
    case 3
        imaqreset;
        info = imaqhwinfo;
        name = char(info.InstalledAdaptors(end));
        c_info = imaqhwinfo(name);
        id = c_info.DeviceInfo.DeviceID(end);
        format = char(c_info.DeviceInfo.SupportedFormats(end));
        vid = videoinput(name, id, format);
        set(vid, 'FramesPerTrigger', Inf);
        set(vid, 'ReturnedColorspace', 'rgb');
        vid.FrameGrabInterval = 5;
        start(vid);  
        while(vid.FramesAcquired <= 100)
            % current snapshot
            data = getsnapshot(vid);            
            diff_im = imsubtract(data(:, :, 3), rgb2gray(data));            
            diff_im = medfilt2(diff_im, [3, 3]);            
            diff_im = im2bw(diff_im, 0.10);            
            diff_im = bwareaopen(diff_im, 300);                      
            bw = bwlabel(diff_im, 8);            
            stats = regionprops(bw, 'BoundingBox', 'Centroid');            
            image(data);            
            hold on;            
            for object=1:length(stats)           
                bb = stats(object).BoundingBox;                
                bo = stats(object).Centroid;                
                rectangle('Position', bb, 'EdgeColor', 'b', 'LineWidth', 2);                
                plot(bo(1), bo(2), 'm+');               
            end            
            hold off;            
        end
        stop(vid);        
        flushdata(vid);        
        clear all;        
end

% --- Executes on button press in red_scale.
function red_scale_Callback(hObject, eventdata, handles)
% hObject    handle to red_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cv1 = 1;
guidata(hObject, handles);
set(handles.start_scale_detection, 'enable', 'on');

% --- Executes on button press in green_scale.
function green_scale_Callback(hObject, eventdata, handles)
% hObject    handle to green_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cv1 = 2;
guidata(hObject, handles);
set(handles.start_scale_detection, 'enable', 'on');

% --- Executes on button press in blue_scale.
function blue_scale_Callback(hObject, eventdata, handles)
% hObject    handle to blue_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cv1 = 3;
guidata(hObject, handles);
set(handles.start_scale_detection, 'enable', 'on');
