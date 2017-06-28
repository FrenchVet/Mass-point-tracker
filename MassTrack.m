function varargout = MassTrack(varargin)
%MASSTRACK MATLAB code file for MassTrack.fig
%      MASSTRACK, by itself, creates a new MASSTRACK or raises the existing
%      singleton*.
%
%      H = MASSTRACK returns the handle to a new MASSTRACK or the handle to
%      the existing singleton*.
%
%      MASSTRACK('Property','Value',...) creates a new MASSTRACK using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to MassTrack_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MASSTRACK('CALLBACK') and MASSTRACK('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MASSTRACK.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MassTrack

% Last Modified by GUIDE v2.5 05-Apr-2017 01:28:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MassTrack_OpeningFcn, ...
                   'gui_OutputFcn',  @MassTrack_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before MassTrack is made visible.
function MassTrack_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for MassTrack
handles.output = hObject; %potrzebne zmienne
handles.isImage = false; %znacznik czy obrabiane jest zdjecie czy film
handles.Punkty = cell(10,1); %komorki dla punktow charakterystycznych
handles.SrodkiCiezkosci = cell(9,1); %srodki ciezkosci
handles.Sciezki = cell(10,1); %trajektorie punktow zaznaczonych
handles.sredniePunkty = zeros(10,2); 
handles.Polecenia = {'Wskaz czubek glowy', 'Wskaz bark','Wskaz lokiec', 'Wskaz nadgarstek', 'Wskaz koniec dloni', 'Wskaz biodro', 'Wskaz kolano','Wskaz kostke', 'Wskaz piete', 'Wskaz koniec stopy'};


% Update handles structure
guidata(hObject, handles); 

% UIWAIT makes MassTrack wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MassTrack_OutputFcn(hObject, eventdata, handles)
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
[FileName,PathName] = uigetfile({'*.asf;*.asx;*.avi;*.m4v;*.mj2;*.mov;*.mp4;*.mpg;*.wmv;'},'Wybierz plik wideo'); %wczytanie filmu
handles.videoSrc = vision.VideoFileReader(fullfile(PathName, FileName));
% guidata(hObject,handles)
handles.isImage = false; %zaznaczenie ze to nei obraz
handles.frame = step(handles.videoSrc); %pobranie ramki
% % Display input video frame on axis
        handles.hAxis  = axes('position',[0 0 1 1],'Parent',handles.uipanel2); %ustalenie miejsca do wyswietlania
        handles.hAxis .XTick = [];
        handles.hAxis .YTick = [];
        handles.hAxis .XColor = [1 1 1];
        handles.hAxis .YColor = [1 1 1];
 showFrameOnAxis(handles.hAxis , handles.frame); %pokazanie ramki na ramach
 handles.pushbutton3.Enable = 'on'; %wlaczenie przycisku do obrobki danych
 handles.text3.String = 'Poprawnie wczytano wideo';
 guidata(hObject,handles)
 

% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif', },'Wybierz obraz'); %tak samo jak z wideo, tylko z obrazem
handles.zdjecie = imread(fullfile(PathName, FileName));
handles.hAxis  = axes('position',[0 0 1 1],'Parent',handles.uipanel2);
handles.hAxis .XTick = [];
handles.hAxis .YTick = [];
handles.hAxis .XColor = [1 1 1];
handles.hAxis .YColor = [1 1 1];
imshow(handles.zdjecie);
 handles.pushbutton3.Enable = 'on';
 handles.text3.String = 'Poprawnie wczytano obraz';
handles.isImage = true;

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function pushbutton2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.isImage) %PROCEDURA DLA OBRAZU
    indeks = 1;
    handles.text3.String = handles.Polecenia(indeks); %co uzytkownik ma pokazac
    [x,y] = ginput(1); %zbierz punkt
    handles.Punkty(indeks) = {[x, y]};%zapisz go
    hold on;
    plot(x, y,'o', 'Color', 'cyan'); %narysuj go

    for indeks = 2:10 %zrob to co wyzej tylko dla calej reszty
        handles.text3.String = handles.Polecenia(indeks);
        [x,y] = ginput(1);
        handles.Punkty(indeks) = {[x, y]};
        plot(x, y,'o', 'Color', 'cyan');

        if(indeks == 6) %dla kazdego punktu poza narysowaniem punktu zarysuj linie do poprzendiego segmentu
            %w tym szczegolnynm przypadku trzeba narysowac linie
            %"biodro-ramie" zamiast linii "koniec dloni-biodro" zeby model
            %sie zgadzal
            plot([handles.Punkty{2}(1), handles.Punkty{6}(1)],[handles.Punkty{2}(2), handles.Punkty{6}(2)], 'Color', 'cyan'); 
        elseif (indeks == 9)
            %nie rysujemy nic, bo to jest polaczenie kotka-pieta
        else
            plot([handles.Punkty{indeks}(1), handles.Punkty{indeks-1}(1)],[handles.Punkty{indeks}(2), handles.Punkty{indeks-1}(2)], 'Color', 'cyan'); 
        end  
    end
    
    handles.SrodkiCiezkosci = WyznaczSrodkiCiezkoscidlaObrazu(handles.Punkty); %wyznaczamy srodki na podstawie punktow 
    
    imshow(handles.zdjecie); %reset zdjecia
    plot(handles.SrodkiCiezkosci{1}(1), handles.SrodkiCiezkosci{1}(2),'o', 'Color', 'cyan'); %pokaz srodki
    for indeks = 2:9
        if (indeks ~= 9)%pokaz wszystkie srodki mas poza ostatnim
            plot(handles.SrodkiCiezkosci{indeks}(1), handles.SrodkiCiezkosci{indeks}(2),'o', 'Color', 'cyan');
        else%ostatni pokaz na czerwono
            plot(handles.SrodkiCiezkosci{indeks}(1), handles.SrodkiCiezkosci{indeks}(2),'o', 'Color', 'red');
        end
    end
    for indeks = 2:10
        if(indeks == 6) %dla kazdego punktu poza narysowaniem punktu zarysuj linie do poprzendiego segmentu
            %w tym szczegolnynm przypadku trzeba narysowac linie
            %"biodro-ramie" zamiast linii "koniec dloni-biodro" zeby model
            %sie zgadzal
            plot([handles.Punkty{2}(1), handles.Punkty{6}(1)],[handles.Punkty{2}(2), handles.Punkty{6}(2)], 'Color', 'cyan'); 
        elseif (indeks == 9)
            %nie rysujemy nic, bo to jest polaczenie kotka-pieta
        else
            plot([handles.Punkty{indeks}(1), handles.Punkty{indeks-1}(1)],[handles.Punkty{indeks}(2), handles.Punkty{indeks-1}(2)], 'Color', 'cyan'); 
        end
    end
     handles.text3.String = 'Zakonczono pomyslnie';
else%GDY OBRABIANY JEST FILM
    indeks = 1;%start dla filmu
    handles.text3.String = handles.Polecenia(indeks);%pokaz uzytkownikowi co ma poakzac
    [x,y] = ginput(1);%wez punkt
    points = detectMinEigenFeatures(rgb2gray(handles.frame),'ROI',[x-10 y-10 20 20]);%znajdz punkty charakterystyczne w okolicy 20 pikseli
    handles.Punkty(indeks) = {points.Location};%wez ich lokalizacje
    handles.sredniePunkty(indeks,:) = mean(handles.Punkty{indeks});%zapisz ich srednia lokalizacje
    out = insertMarker(handles.frame,points.Location,'+');%wstaw markery dla znalezionych punktow charakterystycznych
    out = insertMarker(out,handles.sredniePunkty(indeks, :),'o', 'Color', 'cyan','Size', 5);%wstaw markery dla srednich punktow
    showFrameOnAxis(handles.hAxis , out);%pokaz ramke z nowymi ksztaltami

    for indeks = 2:10
        handles.text3.String = handles.Polecenia(indeks);%tak jak wczesniej tylko dla nastepnych
        [x,y] = ginput(1);
        points = detectMinEigenFeatures(rgb2gray(handles.frame),'ROI',[x-10 y-10 20 20]);
        handles.Punkty(indeks) = {points.Location};
        handles.sredniePunkty(indeks,:) = mean(handles.Punkty{indeks});
        out = insertMarker(out,points.Location,'+');
        out = insertMarker(out,handles.sredniePunkty(indeks,:),'o', 'Color', 'cyan', 'Size', 5);
        if(indeks == 6)%dochodzi rysowanie linii, tez z uwzglednieneim linii "ramie-biodro"
            out = insertShape(out, 'Line', [handles.sredniePunkty(6,:), handles.sredniePunkty(2,:)], 'Color', 'cyan');
        elseif(indeks == 9)
            %nie rysujemy nic, bo to jest polaczenie kotka-pieta
        else
            out = insertShape(out, 'Line', [handles.sredniePunkty(indeks,:), handles.sredniePunkty(indeks-1,:)], 'Color', 'cyan'); 
        end
        showFrameOnAxis(handles.hAxis , out);%pokaz ramke z nowymi ksztaltami
    end


    handles.pushbutton3.Enable = 'off';%wylacz wszystkie guziki zeby nei przeszkadzac
    handles.pushbutton1.Enable = 'off';
    handles.pushbutton2.Enable = 'off';
    handles.text3.String = 'Trwa obliczanie trajektorii...';
    h = waitbar(0,'Prosze czekac...');


    for indeks = 1:10%dla kazdego z punktow
        frame = handles.frame; %wez ramke
        points = handles.Punkty{indeks};
        sciezka = zeros(10000,2);%wymysl sciezke 1000pkt, jak bedzie trzeba to bedzie program dopisywal

        tracker = vision.PointTracker('MaxBidirectionalError',1);%inicjalizacja "trackera" dla punktow charakterystycznych
        initialize(tracker,handles.Punkty{indeks},handles.frame);
        i=1;
        while ~isDone(handles.videoSrc)%przejdz przez cale wideo
          frame = step(handles.videoSrc);%pobierz ramke
          [points, validity] = step(tracker,frame);%sledz punkty z ramki do ramki
          sciezka(i,:) = mean(points);%oblicz srednia z punktow po sledzeniu
          if(any(validity)) %ewentualnie zakomentowac linijkê wy¿ej i walczyc
              sciezka(i,:) = mean(points(validity, :));
          else
              close(h)
              handles.text3.String = handles.Polecenia(indeks);
              showFrameOnAxis(handles.hAxis , frame);
              sciezka(i,:) = ginput(1);
              h = waitbar(0,'Prosze czekac...');
              waitbar(indeks/10);
              handles.text3.String = 'Trwa obliczanie trajektorii...';
          end

          i = i + 1;
        end  
        sciezka(i,:) = sciezka(i-1,:);%dodaj punkt do ostatniej ramki, bo przez to 
        %ze wzielismy ramke na poczatku, bedzie punktow o 1 mniej do
        %liczenia trajektorii, wiec zeby liczba sie zgadzala, trzeba
        %powtorzyc wynik dla ostatniej ramki
        handles.Sciezki{indeks} = sciezka;%zapisz sciezke
        waitbar(indeks/10);%uaktualnij pasek
        handles.videoSrc.reset();%powrot do poczatku wideo
        handles.frame = step(handles.videoSrc);%pobierz ramke zeby sie zgadzalo z 1. punktem
    end 
    close(h) ;

    handles.SrodkiCiezkosci = WyznaczSrodkiCiezkosci(handles.Sciezki, length(handles.Sciezki{indeks}));%wyznacz srodki ciezkosci dla trajektorii

    handles.text3.String = 'Projekcja';
    i=1;
    while ~isDone(handles.videoSrc)
          punkty = zeros(8,2);%zmienna zerby lepiej chodzilo
          for indeks = 1:8%zapisz srodki ciezkosci konczyn
              punkty(indeks,:) = handles.SrodkiCiezkosci{indeks}(i,:);
          end
          handles.frame = step(handles.videoSrc); %pobierz ramke
          out = insertMarker(handles.frame,punkty,'o', 'Color', 'cyan', 'Size', 5);%wstaw srodki mas konczyn
          out = insertMarker(out,handles.SrodkiCiezkosci{9}(i,:),'o', 'Color', 'red', 'Size', 7);%dodaj ogolny srodek masy na czerwono
    %       polyline = [handles.Sciezki{indeks}(1, :), handles.Sciezki{indeks}(2, :), handles.Sciezki{indeks}(3, :), handles.Sciezki{indeks}(4, :), handles.Sciezki{indeks}(5, :);handles.Sciezki{indeks}(2, :), handles.Sciezki{indeks}(6, :), handles.Sciezki{indeks}(7, :), handles.Sciezki{indeks}(8, :), handles.Sciezki{indeks}(9, :)];
    %       out = insertShape(out,'Line',polyline,'LineWidth',5, 'Color', 'cyan');
    %       sprawdzic czemu nie dzia³a o_O
            i = i + 1;
          showFrameOnAxis(handles.hAxis , out); %pokaz

    end
    handles.pushbutton3.Enable = 'on';%wlacz guziki spowrotem
    handles.pushbutton1.Enable = 'on';
    handles.pushbutton2.Enable = 'on';
    handles.videoSrc.reset();
end

% --- Executes during object creation, after setting all properties.
function pushbutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function uipanel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
