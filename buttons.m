function varargout = buttons(varargin)
% BUTTONS MATLAB code for buttons.fig
%      BUTTONS, by itself, creates a new BUTTONS or raises the existing
%      singleton*.
%
%      H = BUTTONS returns the handle to a new BUTTONS or the handle to
%      the existing singleton*.
%
%      BUTTONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BUTTONS.M with the given input arguments.
%
%      BUTTONS('Property','Value',...) creates a new BUTTONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before buttons_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to buttons_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help buttons
% Last Modified by GUIDE v2.5 15-Nov-2018 13:53:30
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @buttons_OpeningFcn, ...
                   'gui_OutputFcn',  @buttons_OutputFcn, ...
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

% --- Executes just before buttons is made visible.
function buttons_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to buttons (see VARARGIN)

% Choose default command line output for buttons
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes buttons wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Plots a white line to help with sizing issues.
plot(0:100, 0:100, '-w');

%Creates a variable called handles.particleList to store all the particles.
particleList(1) = createParticle(0,0,0,0,0,0);
particleList(2) = createParticle(1, 10, 10, 80, 5, 1);
particleList(3) = createParticle(1, 350, 10, 20, 5, 1);
handles.particleList = particleList;
handles.nextTimeStep = 1;
handles.lower = 0.5;
handles.upper = 99.5;

guidata(hObject, handles);
hold on
createCircle(handles.particleList(1).xPos, handles.particleList(1).yPos, handles.particleList(1).radius);
hold off
drawnow
%handles.listLength = 1;
%guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = buttons_OutputFcn(hObject, eventdata, handles) 
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
x = inputdlg({'Mass of Particle:', 'Radius of Particle:'}, 'Create Particle');
y = str2double(x);
particle = createParticle(rand(1,1), rand(1,1)*360, y(1) + (100-2 * y(1)) * rand(1,1) , y(1) + (100-2 * y(1)) * rand(1,1) , y(2),y(1));
hold on
createCircle(particle.xPos, particle.yPos, particle.radius);
hold off
handles.particleList(end + 1) = particle;
guidata(hObject, handles);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
    while get(hObject, 'Value')
        
        %change text on checkbox
        hObject.String = 'Uncheck to Pause';
        
        %updates while box is checked
        run(hObject, eventdata, handles);
        handles = guidata(hObject);
        
        %calculate all circles
        toPlotX = zeros(length(handles.particleList),101);
        toPlotY = toPlotX;
        for i = 2:length(handles.particleList)
            [toPlotX(i,:),toPlotY(i,:)] = createCircle(handles.particleList(i).xPos,handles.particleList(i).yPos,handles.particleList(i).radius);
        end
        
        %plot and draw everything
        plot(0:100, 0:100, '-w',toPlotX', toPlotY');
        drawnow
    end
    %change text on checkbox
    hObject.String = 'Check to Resume'; 


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1 

function handles = run(hObject, eventdata, handles) 
%nextTimeStep is used to prevent particles from clipping. Instead of
%updating the position of the particles by a full tick every time, we look
%for the specific time for when two particles are going to colide and we
%update the simulation by a fraction of a tick so that the two particles
%are just touching each other.
%Although this decreases the performance, the ammount is negligible and
%will allow us to achieve a more accurate simulation

    %Updates particles after bouncing off wall/border.
    for i = 2:length(handles.particleList)
        if handles.particleList(i).xPos >= handles.upper - handles.particleList(i).radius
            handles.particleList(i).angle = 180 - handles.particleList(i).angle;
        elseif handles.particleList(i).xPos <= handles.lower + handles.particleList(i).radius
            handles.particleList(i).angle = 180 - handles.particleList(i).angle;
        end
        if handles.particleList(i).yPos >= handles.upper - handles.particleList(i).radius
            handles.particleList(i).angle = -1 * handles.particleList(i).angle;
        elseif handles.particleList(i).yPos <= handles.lower + handles.particleList(i).radius
            handles.particleList(i).angle = -1 * handles.particleList(i).angle;
        end

        %update position of particles
        handles.particleList(i) = particleUpdate(handles.particleList(i),handles.nextTimeStep);
    end
    
    handles.nextTimeStep = 1;

    %Test for collision of all combinations of particles 
    if(length(handles.particleList)>2)
        for i = 2:length(handles.particleList)-1
            for j =i+1:length(handles.particleList)
                
                if collisionTest(handles.particleList(i),handles.particleList(j))
                    [handles.particleList(i), handles.particleList(j)] = collision(handles.particleList(i), handles.particleList(j));
                end
                
                [tTCol, colWithinASecond] = timeToCollision(handles.particleList(i),handles.particleList(j),"particleParticle");
                if colWithinASecond && tTCol < handles.nextTimeStep
                    handles.nextTimeStep = tTCol;
                end
            end
            [tTCol, colWithinASecond] = timeToCollision(handles.particleList(i),0,"particleWall",handles.lower,handles.upper);
            if colWithinASecond && tTCol < handles.nextTimeStep && tTCol ~= 0
                    handles.nextTimeStep = tTCol;
            end
        end
    end
    
    guidata(hObject, handles);

