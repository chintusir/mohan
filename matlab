Skip to content
digital image processing
Search
DIP CSC2014 – Colour Image Segmentation by Ramsha & Jocelyn & Steve
MATLAB Codes
Listed below are the MATLAB codes needed in order to carry out the demonstration. Please run the Function of the GUI after copy-pasting the appropriate files into MATLAB.

GUI_Segmentation.m (Function For the GUI)

function varargout = GUI_segmentation(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name', mfilename, ...
 'gui_Singleton', gui_Singleton, ...
 'gui_OpeningFcn', @GUI_segmentation_OpeningFcn, ...
 'gui_OutputFcn', @GUI_segmentation_OutputFcn, ...
 'gui_LayoutFcn', [] , ...
 'gui_Callback', []);
if nargin && ischar(varargin{1})
 gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
 [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
 gui_mainfcn(gui_State, varargin{:});
end



% --- Executes just before GUI_segmentation is made visible.
function GUI_segmentation_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = GUI_segmentation_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



% --- Executes on button press in upload_button.
function upload_button_Callback(hObject, eventdata, handles)
global image color;
color='none';
[filename, foldername] = uigetfile({'*.*'}, 'Select file');
if filename ~= 0
 FileName = fullfile(foldername, filename);
end

axes (handles.axes1);
image = imread (FileName);
imshow (image);

assignin('base','color',color); 
assignin('base','image',image); 
set(handles.fileName_text,'String',filename);
set(handles.imageTitle_text,'String','Original Image'); 



% --- Executes during object creation, after setting all properties.
function color_menu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
 set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in color_menu.
function color_menu_Callback(hObject, eventdata, handles)
global color;
contents=cellstr(get(hObject,'String'));
color_menu=contents{get(hObject,'Value')};
switch color_menu
 case 'Select Color'
 color='none';
 case 'Red'
 color='red';
 case 'Yellow'
 color='yellow';
 case 'Orange'
 color='orange';
 case 'Green'
 color='green';
 case 'Blue'
 color='blue';
 case 'Indigo'
 color='indigo';
 case 'Violet'
 color='violet';
end
assignin('base','color',color);



% --- Executes on button press in done_button.
function done_button_Callback(hObject, eventdata, handles)
global image color finalImage;
if (strcmp(color,'none')) 
 set(handles.warning_text,'String','PLEASE CHOOSE A COLOR TO SEGMENT'); 
else
 finalImage = segmentation(image,color);
 axes (handles.axes1); 
 imshow(uint8(finalImage));
 set(handles.warning_text,'String','');
 set(handles.imageTitle_text,'String','Segmented Image'); 
end

Segmentation.m
VIBGYOR (Violet Indigo Blue Green Yellow Orange Red) Color Segmentation Function

function image = segmentation(inputImage, color)


[row, column, plane] = size(inputImage);
inputImage = double(inputImage);
image = zeros(row,column,plane);

switch color
 case {'red'}
 f1 = 255;
 f2 = 102;
 f3 = 127.5;
 f4 = 0;
 f5 = 127.5; 
 f6 = 0;
 image = imageFilter(inputImage,f1,f2,f3,f4,f5,f6,1,0);
 
 case {'orange'}
 f1 = 255;
 f2 = 153;
 f3 = 173.4; 
 f4 = 76.5; 
 f5 = 76.5; 
 f6 = 0; 
 image = imageFilter(inputImage,f1,f2,f3,f4,f5,f6,1,0);
 
 case {'yellow'}
 f1 = 255;
 f2 = 198.9;
 f3 = 255; 
 f4 = 183.6;
 f5 = 132.6;
 f6 = 0;
 image = imageFilter(inputImage,f1,f2,f3,f4,f5,f6,1,1);
 
 case {'green'}
 f1 = 173.4; 
 f2 = 0;
 f3 = 255;
 f4 = 102;
 f5 = 173.4; 
 f6 = 0;
 image = imageFilter(inputImage,f1,f2,f3,f4,f5,f6,2,0);
 
 case {'blue'}
 f1 = 127.5;
 f2 = 0;
 f3 = 173.4; 
 f4 = 0;
 f5 = 255;
 f6 = 102;
 image = imageFilter(inputImage,f1,f2,f3,f4,f5,f6,3,0);
 
 case {'indigo'}
 f1 = 173.4; 
 f2 = 0;
 f3 = 255; 
 f4 = 153;
 f5 = 255;
 f6 = 153;
 image = imageFilter(inputImage,f1,f2,f3,f4,f5,f6,1,1);
 
 case {'violet'}
 f1 = 255;
 f2 = 153;
 f3 = 173.4; 
 f4 = 0;
 f5 = 255;
 f6 = 153;
 image = imageFilter(inputImage,f1,f2,f3,f4,f5,f6,3,1);
end
image = uint8(image);
Segmentation.m (same file as the above)

Function for Color Filter

%% Function for Color Filter
function image = imageFilter(inputImage,f1,f2,f3,f4,f5,f6,m,flag)
[row, column, plane] = size(inputImage);
image = zeros(row,column,plane);
for i = 1:row
 for j = 1:column
 if flag == 0
 if (inputImage(i,j,1) <= f1 && inputImage(i,j,1) >= f2 && inputImage(i,j,2) <= f3 && inputImage(i,j,2) >= f4 && inputImage(i,j,3) <= f5 && inputImage(i,j,3) >= f6 && inputImage(i,j,m) == max([inputImage(i,j,1) inputImage(i,j,2) inputImage(i,j,3)]))
 image(i,j,1:3) = inputImage(i,j,1:3);
 else
 image(i,j,1:3) = (inputImage(i,j,1) * 0.3) + (inputImage(i,j,2) * 0.59) + (inputImage(i,j,3) * 0.11);
 end
 else
 if (inputImage(i,j,1) <= f1 && inputImage(i,j,1) >= f2 && inputImage(i,j,2) <= f3 && inputImage(i,j,2) >= f4 && inputImage(i,j,3) <= f5 && inputImage(i,j,3) >= f6)
 image(i,j,1:3) = inputImage(i,j,1:3);
 else
 image(i,j,1:3) = (inputImage(i,j,1) * 0.3) + (inputImage(i,j,2) * 0.59) + (inputImage(i,j,3) * 0.11);
 end
 end
 end
end

