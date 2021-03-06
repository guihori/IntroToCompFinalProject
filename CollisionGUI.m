function varargout = CollisionGUI(varargin)
% COLLISIONGUI MATLAB code for CollisionGUI.fig
%      COLLISIONGUI, by itself, creates a new COLLISIONGUI or raises the existing
%      singleton*.
%
%      H = COLLISIONGUI returns the handle to a new COLLISIONGUI or the handle to
%      the existing singleton*.
%
%      COLLISIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLLISIONGUI.M with the given input arguments.
%
%      COLLISIONGUI('Property','Value',...) creates a new COLLISIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CollisionGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CollisionGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CollisionGUI

% Last Modified by GUIDE v2.5 06-Dec-2018 16:09:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CollisionGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CollisionGUI_OutputFcn, ...
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


% --- Executes just before CollisionGUI is made visible.
function CollisionGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CollisionGUI (see VARARGIN)

% Choose default command line output for CollisionGUI
    handles.output = hObject;

% Update handles structure
    guidata(hObject, handles);

% UIWAIT makes CollisionGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% Plots a white line to help with sizing issues.
    plot(0:100, 0:100, '-w');
    ax = gca;
    set(gca,'XTickLabel',[]);
    set(gca,'YTickLabel',[]);
    ax.TickLength = [0 0];
    axis square;
    
    %Creates a variable called handles.particleList to store all the particles.
    handles.particleList = createParticle(0,0,0,0,0,0);
    
    %Use the following space and template to create new particles at will
    %handles.particleList(end + 1) = createParticle(speed, angle(degrees), 
    %x position, y position, radius, mass); 
    
    
    
    
    %nextTimeStep is used so to prevent clipping in the simulation.
    %Normally every time the simulation update the position of the
    %particles there is a chance for two particles to clip. Clips reduce
    %the accuracy of the simulation and in extreme cases can cause
    %particles to go through each other. To prevent that we introduce
    %variable time steps to our simulation. Variable time step allows us to
    %find the time (accurate to 1e-14 seconds) when two particles collide
    %and advandce the simulation to that time. The consequences of having a
    %variable time step are the extreme precision of the simulation and a
    %heavy dilation of time when too many collisions happen within a
    %second
    handles.nextTimeStep = 1;
    
    %Set the bounds of the field to be slightly smaller than the field
    %itself to prevent the particles to going over the field bounds and
    %messing the zoom.
    handles.lower = 0.0000000000001;
    handles.upper = 99.9999999999;
    guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = CollisionGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    varargout{1} = handles.output;

% --- Executes on button press in AddParticle.
function AddParticle_Callback(hObject, eventdata, handles)
% hObject    handle to AddParticle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if get(handles.StartStop, 'Value') 
        handles.StartStop.Value = 0;
        handles.StartStop.String = 'Check to Resume';
    end
    %Gets initial input data to feed to the while loop.
    x = inputdlg({'Mass of Particle: (>0)', 'Radius of Particle: (1-20)'}, 'Create Particle');
    y = str2double(x);
    
    %While loop to make sure the data is valid.
    while isnan(y(1)) || isnan(y(2)) || y(2) > 20 || y(2) < 1 || y(1) <= 0 
        waitfor(msgbox('Invalid input. Radius must be between 1 and 20 and mass must be positive and nonzero.'));
        x = inputdlg({'Mass of Particle: (>0)', 'Radius of Particle: (1-20)'}, 'Create Particle');
        y = str2double(x);
    end
    
    %createParticle(initial speed, initial angle, xPos, yPos, radius, mass)
    particle = createParticle(3*rand(1,1), rand(1,1)*360, y(2) + (100-2 * y(2)) * rand(1,1) , y(2) + (100-2 * y(2)) * rand(1,1) , y(2),y(1));
    counter = 0;
    while ~overlapTest(particle, handles.particleList) && counter <= 100000
        particle = createParticle(3*rand(1,1), rand(1,1)*360, y(2) + (100-2 * y(2)) * rand(1,1) , y(2) + (100-2 * y(2)) * rand(1,1) , y(2),y(1));
        counter = counter + 1;
    end
    
    %To prevent an infinite loop of trying to place a particle that is too
    %large.
    if counter >= 100000
        msgbox('Radius was too large, could not place the particle. Please try again.');
    else
        hold on
        [plotX, plotY] = createCircle(particle.xPos, particle.yPos, particle.radius);
        plot(plotX, plotY);
        hold off

        handles.particleList(end + 1) = particle;
        guidata(hObject, handles);
    end

% --- Executes on button press in RemoveParticle.
function RemoveParticle_Callback(hObject, eventdata, handles)
% hObject    handle to RemoveParticle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if get(handles.StartStop, 'Value')
        handles.StartStop.Value = 0;
        handles.StartStop.String = 'Check to Resume';
    end
    
    %Prints the index of each circle inside the circle so user knows which
    %index is being removed.
    for i = 2:length(handles.particleList)
        indNum = num2str(i- 1);
        text(handles.particleList(i).xPos, handles.particleList(i).yPos, indNum);
    end
    
    
    x = inputdlg('How many particles would you like to remove? To remove all: enter 0', 'Remove particles');
    y = str2double(x);
    
    %If the input is greaterequal to the number of particles, this
    %all the particles get removed also.
    if y == length(handles.particleList) - 1
        y = 0;
    end
    
    %Removes all particles.
    if y == 0
        handles.particleList(2:end) = [];
        guidata(hObject, handles);
        
    %Removes the particles at the index specified by the user.
    elseif y < length(handles.particleList)-1
        indexes = zeros(1, y);
        for i = 1:y
            in = str2double(inputdlg('Particle index you would like to remove:', 'Removal'));
            indexes(i) = in + 1;
        end
        handles.particleList(indexes(:)) = [];
        guidata(hObject, handles);
    else
        waitfor(msgbox('There are not enough particles.'));
        handles.StartStop.Value = 1;
    end
    
    %This code redraws everything before the simulation is resumed.
    %calculate all circles
    toPlotX = zeros(length(handles.particleList),101);
    toPlotY = toPlotX;
    
    if length(handles.particleList) ~= 1
        for i = 2:length(handles.particleList)
            [toPlotX(i-1,:),toPlotY(i-1,:)] = createCircle(handles.particleList(i).xPos,handles.particleList(i).yPos,handles.particleList(i).radius);
        end
        %plot and draw everything
        plot(0:100, 0:100, '-w',toPlotX', toPlotY');
    else
        plot(0:100, 0:100, '-w');
    end
       
    ax = gca;
    set(gca,'XTickLabel',[]);
    set(gca,'YTickLabel',[]);
    ax.TickLength = [0 0];
    axis square;
    drawnow
    
% --- Executes on button press in StartStop.
function StartStop_Callback(hObject, eventdata, handles)
% hObject    handle to StartStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StartStop
    while get(hObject, 'Value')
        hObject.String = 'Uncheck to Pause';
        if length(handles.particleList) ~= 1
            %updates while box is checked
            run(hObject, eventdata, handles);
            handles = guidata(hObject);

            %calculate all circles
            toPlotX = zeros(length(handles.particleList),101);
            toPlotY = toPlotX;
            for i = 2:length(handles.particleList)
                [toPlotX(i-1,:),toPlotY(i-1,:)] = createCircle(handles.particleList(i).xPos,handles.particleList(i).yPos,handles.particleList(i).radius);
            end

            %plot and draw everything

            plot(0:100, 0:100, '-w',toPlotX', toPlotY');
            ax = gca;
            set(gca,'XTickLabel',[]);
            set(gca,'YTickLabel',[]);
            ax.TickLength = [0 0];
            axis square;
            drawnow
        else
            hObject.Value = 0;
        end
    end
    
    hObject.String = 'Check to Resume';
    
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
        handles.particleList(i).angle = mod(handles.particleList(i).angle,360);
        cir = handles.particleList(i);
        %if particle is bouncing on the right wall
        if cir.xPos >= handles.upper - cir.radius && (cir.angle < 90 || cir.angle > 270)
            handles.particleList(i).angle = 180 - cir.angle;
        %if particle is bouncing on the left wall
        elseif cir.xPos <= handles.lower + cir.radius && cir.angle > 90 && cir.angle < 270
            handles.particleList(i).angle = 180 - cir.angle;
        end
        %if particle is bouncing on the top wall
        if cir.yPos >= handles.upper - cir.radius && cir.angle < 180
           handles.particleList(i).angle = -1 * cir.angle;
        %if particle is bouncing on the bottom wall
        elseif cir.yPos <= handles.lower + cir.radius && cir.angle > 180 
            handles.particleList(i).angle = -1 * cir.angle;
        end
    end
    

    %Test for collision of all combinations of particles 
    if(length(handles.particleList)>2)
        for i = 2:length(handles.particleList)-1
            for j =i+1:length(handles.particleList)
                %Test if there is a collision between two particles
                if collisionTest(handles.particleList(i),handles.particleList(j))
                    [handles.particleList(i), handles.particleList(j)] = collision(handles.particleList(i), handles.particleList(j));
                end
            end
        end
    end
        
    %Find the time until particles hit walls or other particles
    if(length(handles.particleList)>2)
        for i = 2:length(handles.particleList)-1
            for j =i+1:length(handles.particleList)
                %This will find the time until two particles colide (tTCol)
                tTCol = timeToCollision(handles.particleList(i),handles.particleList(j),true);
                %If a collision will happen within a second and the tTCol
                %is smaller than the next planned step that the simulation
                %will take, set the next step to tTCol.
                %See handles.nextTimeStep declaration for more information.
                if isreal(tTCol)
                    if tTCol > 0 && tTCol < 1 && tTCol < handles.nextTimeStep && tTCol
                        handles.nextTimeStep = tTCol;
                    end
                end
            end
            tTCol = timeToCollision(handles.particleList(i),0,false,handles.lower,handles.upper);
            if tTCol < 1 && tTCol < handles.nextTimeStep && tTCol
                    handles.nextTimeStep = tTCol;
            end
        end
        tTCol = timeToCollision(handles.particleList(end),0,false,handles.lower,handles.upper);
        if tTCol < 1 && tTCol < handles.nextTimeStep && tTCol
                handles.nextTimeStep = tTCol;
        end
    else
        tTCol = timeToCollision(handles.particleList(2),0,false,handles.lower,handles.upper);
        if tTCol < 1 && tTCol < handles.nextTimeStep && tTCol
                    handles.nextTimeStep = tTCol;
        end
    end
    
    %update position of particles
    for i = 2:length(handles.particleList)
        handles.particleList(i) = particleUpdate(handles.particleList(i),handles.nextTimeStep);
    end
    handles.nextTimeStep = 1;
    
    guidata(hObject, handles);
