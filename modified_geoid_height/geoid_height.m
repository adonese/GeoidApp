function N = geoid_height( lat, lon, varargin )


persistent astgeoiddata astgeoidCustomError

narginchk(2, 5);
% Check inputs
if ~isnumeric(lat)
    % Latitude should be a numeric array.  Otherwise error.
    error(message('aero:geoidheight:latitudeNotNumeric'));
end
if ~isnumeric(lon)
    % Altitude should be a numeric array.  Otherwise error.
    error(message('aero:geoidheight:longitudeNotNumeric'));
end
if ~all(size(lat) == size(lon))
    error(message('aero:geoidheight:arraySize'));
end
if ~isfloat(lat) || ~isfloat(lon)
    error(message('aero:geoidheight:notFloat'));
end
if ~strcmpi(class(lat),class(lon))
    error(message('aero:geoidheight:differentInputType'));
end

% set default values
model  = 'EGM96';
action = 'warning';
datafile = 'geoidegm96grid.mat';

switch nargin                                                              
    case 3
        if ~ischar( varargin{1} )
            error(message('aero:geoidheight:inputTypeVar3'));
        end
        if strcmpi( varargin{1}, 'custom')
            narginchk(4, 5);
        else
            % check that the 2008 model is in the path	 
            checkegm2008( varargin{1} );
            % assign model or action
            modeloraction( varargin{1} );
        end       
    case 4
        if ~ischar( varargin{1} ) || ~ischar( varargin{2} ) 
            error(message('aero:geoidheight:inputTypeVar4'));
        end
        if strcmpi( varargin{1}, 'custom')
            % custom model with datafile
            model = lower( varargin{1} );
            datafile = varargin{2};
        else
            % check that the 2008 model is in the path	 
            checkegm2008( varargin{1} );
            % assign model and action
            checkmodel( varargin{1} );
            checkaction( varargin{2} );
        end
    case 5
        if ~ischar( varargin{1} ) || ~ischar( varargin{2} ) || ~ischar( varargin{3} )
            error(message('aero:geoidheight:inputTypeVar5'));
        end
        % set action for custom model with datafile
        if strcmpi( varargin{1}, 'custom')
            % custom model with datafile
            model = lower( varargin{1} );
            datafile = varargin{2};
            checkaction( varargin{3} );
        else
            % This option is only for 'custom'
            error(message('aero:geoidheight:wrongModel'));
        end
end

actionstr = {'none' 'warning' 'error'};
actionidx = find(strcmp(actionstr, action));

checklatitude();
checklongitude();

if ( isempty(astgeoiddata) || ~strcmp( astgeoiddata.type, model ) || ...
                   ~strcmpi( astgeoiddata.file, datafile ) || ~isempty(astgeoidCustomError))
    % data needs to be initialized
    try
        astgeoiddata = load(datafile);
    catch MECustomFileLoad
        throwAsCaller(MECustomFileLoad)
    end
    astgeoiddata.type = model;
    astgeoiddata.file = datafile;
    if strcmp('custom', astgeoiddata.type)
        % check for the existence of correct variables in mat-file
        fieldsExist = ~isfield(astgeoiddata,{'latbp' 'lonbp' 'grid' 'windowSize'});
        
        fhFields = { @() disp(''), ... % all fields exist
            @() error(message('aero:geoidheight:noLatitudeBP', datafile)), ...
            @() error(message('aero:geoidheight:noLongitudeBP', datafile)), ...
            @() error(message('aero:geoidheight:noGrid', datafile)), ...
            @() error(message('aero:geoidheight:noWindowSize', datafile))};
        
        idx = find(fieldsExist,1);
        if isempty(idx)
            idx = 0;
        end
        
        % allow same custom filename to run through check if had previous error
        astgeoidCustomError = 1;
        
        % Call appropriate function
        fhFields{idx+1}()    
        
        % check data type and sizes of custom data
        if  ~isnumeric( astgeoiddata.latbp ) || ~isnumeric( astgeoiddata.lonbp ) || ...
                ~isnumeric( astgeoiddata.grid ) || ~isnumeric( astgeoiddata.windowSize )
            error(message('aero:geoidheight:notNumeric'))
        end
        if  ~isscalar( astgeoiddata.windowSize )
            error(message('aero:geoidheight:notScalar'))
        end
        if  ~isvector( astgeoiddata.latbp ) || ~isvector( astgeoiddata.lonbp ) 
            error(message('aero:geoidheight:not1DArray'))
        end
         if ~all( size( astgeoiddata.grid ) == [ numel(astgeoiddata.latbp) numel(astgeoiddata.lonbp) ] ) 
            error(message('aero:geoidheight:wrongMatrixSize'))
        end
        if  any(~isfinite( astgeoiddata.latbp )) || any(~isfinite( astgeoiddata.lonbp )) || ...
             any(any(~isfinite( astgeoiddata.grid ))) || any(~isfinite( astgeoiddata.windowSize ))
            error(message('aero:geoidheight:notFinite'))
        end
        if (mod(astgeoiddata.windowSize,2) || (astgeoiddata.windowSize <= 2))
            error(message('aero:geoidheight:notEvenInteger'))
        end
        % successful custom file read
        astgeoidCustomError = [];
     end
end

% checkinputs above should ensure lat and lon are of equal dimension
n = numel(lat);

% Preallocate
N  = zeros(1,n,'single');

halfWindowSize = astgeoiddata.windowSize/2;

% Get lat data type to set output later
latType = class(lat);

% Convert to single for interpolation
if ~isa(latType,'single')
    lat = single(lat);
    lon = single(lon);
end

% Loop through all of the lon/lat input pairs
for k = 1:n
    % Find indices for window of height data. If there is an exact match,
    % it will be in the middle of the window (i.e. vector will be of size
    % windowSize+1-by-windowsize+1 with matching index in the middle).
    lonbpi = [find(astgeoiddata.lonbp<lon(k),halfWindowSize,'last'), ...
        find(astgeoiddata.lonbp==lon(k)), ...
        find(astgeoiddata.lonbp>lon(k),halfWindowSize,'first')];
    latbpi = [find(astgeoiddata.latbp<lat(k),halfWindowSize,'last'), ...
        find(astgeoiddata.latbp==lat(k)), ...
        find(astgeoiddata.latbp>lat(k),halfWindowSize,'first')];

    % As mentioned above, if there are windowSize+1 elements in lonbpi, the
    % middle value is the index for an exact value of lon.
    if numel(lonbpi) == astgeoiddata.windowSize+1
        % Pull out the lat window values for the exact lon value.
        latsforlon = astgeoiddata.grid(latbpi,lonbpi(astgeoiddata.windowSize/2 + 1));

        % Otherwise perform interpolation to find height values for given lon
        % at each lat in window.
    else
        % This transpose is here because interp1 will interp down each
        % column of the input matrix, and in this instance we want it to
        % interp across each row of grid(latbpi,lonbpi).
        latsforlon = interp1(astgeoiddata.lonbp(lonbpi),astgeoiddata.grid(latbpi,lonbpi)',lon(k),'spline');
    end

    % As mentioned above, if there are windowSize+1 elements in latbpi, the
    % middle value is the index for an exact value of lat.
    if numel(latbpi) == astgeoiddata.windowSize+1
        % Pull out the height value for exact value of lat from range of
        % height possibilities determined above from lon.
        N(k) = latsforlon(halfWindowSize + 1);

        % Otherwise perform interpolation to find height value.
    else
        N(k) = interp1(astgeoiddata.latbp(latbpi),latsforlon,lat(k),'spline');
    end
end

% Expand to double for unit changes and truncating.
N = double(N);

if strcmp(astgeoiddata.type,'egm2008')
    N = fix(N.*1000)*0.001;
else
    N = fix(N.*100)*0.01;
end

% Cast to desired output data type
N = cast(N,latType);

% %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
%     function checkinputs()
%         if ~isnumeric(lat)
%             % Latitude should be a numeric array.  Otherwise error.
%             error(message('aero:geoidheight:latitudeNotNumeric'));
%         end
%         if ~isnumeric(lon)
%             % Altitude should be a numeric array.  Otherwise error.
%             error(message('aero:geoidheight:longitudeNotNumeric'));
%         end
%         if ~all(size(lat) == size(lon))
%             error(message('aero:geoidheight:arraySize'));
%         end
%         if ~isfloat(lat) || ~isfloat(lon)
%             error(message('aero:geoidheight:notFloat'));
%         end
%         if ~strcmpi(class(lat),class(lon))
%             error(message('aero:geoidheight:differentInputType'));
%         end
%     end
% %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
%     function checklatitude()
%         % Wrap latitude and longitude if necessary
%         [latwrapped,lat,lon] = wraplatitude(lat,lon,'deg');
%         if latwrapped
%             % Create function handle array to handle messages based on
%             % action
%             fhlat = {@() disp('')... % do nothing for 'none'
%                   @() warning(message('aero:geoidheight:warnLatitudeWrap')), ...
%                   @() error(message('aero:geoidheight:latitudeWrap'))};
%             
%            % Call appropriate function
%            fhlat{actionidx}()
%         end
%     end
% 
% %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
%     function checklongitude()
%         [lonwrapped, lon] = wraplongitude(lon,'deg','360');
% 
%         if lonwrapped
%             % Create function handle array to handle messages based on
%             % action
%             fhlon = {@() disp('')... % do nothing for 'none'
%                 @() warning(message('aero:geoidheight:warnLongitudeWrap')), ...
%                 @() error(message('aero:geoidheight:longitudeWrap'))};
% 
%             % Call appropriate function
%             fhlon{actionidx}()
%         end
%     end
% %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
%     function checkmodel( str )
%         switch lower( str )
%             case 'egm2008'
%                 model = lower( str );
%                 datafile = 'geoidegm2008grid.mat';
%             case 'egm96'
%                 model = lower( str );
%                 datafile = 'geoidegm96grid.mat';
%             otherwise
%                 error(message('aero:geoidheight:unknownModel'));
%         end
%     end
% %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
%     function checkaction( str )
%         switch lower( str )
%             case { 'error', 'warning', 'none' }
%                 action = lower( str );
%             otherwise
%                 error(message('aero:geoidheight:unknownAction'));
%         end
%     end
% %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
%     function modeloraction( str )
%         switch lower( str )
%             case 'egm2008'
%                 model = lower( str );
%                 datafile = 'geoidegm2008grid.mat';
%             case 'egm96'
%                 model = lower( str );
%                 datafile = 'geoidegm96grid.mat';
%             case { 'error', 'warning', 'none' }
%                 action = lower( str );
%             otherwise
%                 error(message('aero:geoidheight:unknownString'));
%         end
%     end
% %=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
%  function checkegm2008( str )	 
%      if strcmp(str,'egm2008')
%          if isempty(which('geoidegm2008grid.mat','-ALL'))
%              error(message('aero:geoidheight:noDownloadData',...
%                  '<a href="matlab: aeroDataPackage">aeroDataPackage</a>'))
%          end
%      end
%  end
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
end
