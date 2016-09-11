function [latbp, lonbp, grid, windowSize] = geoidUndulation(model,nmax,varargin)
% [lonbp,LATD,GEOPOT_GRID] = geoidUndulation(MODEL,NMAX,VARARGIN)
%   What this function does is calculating the geoid height of specific lon/ lat (location)
%   Parameters it takes:
%   1. 'model': Name of *.mat file that contains cnm & snm. It also should come with maximum degree.
%   All these steps are handled in ggmReader script, you should run it before. You can take the cnm & snm and pass them
%   as inputs.
%     
%    
%   2. nmax is maximum degree of model to be used in geoid height calculation. Highest degrees will get you fine results but requires
%   long time in computations (think of a good ram & cpu)
% 
%   3. Optional arguments: 
%     Comming soon!

%   'subtract_normal_field'=3 .. coefficients C00, C20 are put equal to zero
%
%   'cnm'..matrix of spherical harmonic coefficients
%   'snm'..matrix of spherical harmonic coefficients
%   'Re' = reference radius of the body (m)
%    6378136.3 m for Earth (default)/other value 
%
%   'gm'=geocentric gravitational constant (m3/s2)
%     3.986004415e14 m3/s2 for Earth (default)/other value 
%
%   The function tests, whether the grid has already been computed and stored.
%   In the folder 'temp', computed geopotential grids are stored for speeding up the execution of the function.
%   You may delete its contents if you wish.
%   We save only grids which took more than 'time_limit_to_save_grids' seconds to compute (default 1 sec).


%% Default parameters
functional                 = 'gh';
grav_const
subtract_normal_field      = 1;
grid_stepd                 = floor(360/nmax/4*60)/60;
time_limit_to_save_grids   = 1;

i = 1;
while i <= length(varargin),
   switch lower(varargin{i})
      case 'functional'
         functional  = varargin{i+1};
      case 'grid_stepd'
         grid_stepd  = varargin{i+1};
      case 'subtract_normal_field'
         subtract_normal_field=varargin{i+1};
      case 're'
         Re          = varargin{i+1};
      case 'gm'
         gm          = varargin{i+1};
      case 'cnm'
         cnm         = varargin{i+1};
      case 'snm'
         snm         = varargin{i+1};
   end;
   i = i + 2;
end;
         
%% Check the path
% a simple way to check, whether also the subdirectories were added
if ~exist('asu-ch-0309.gfc' , 'file')
   mfile                   = mfilename('fullpath');
   [pathstr , name , ext]  = fileparts(mfile);
   addpath(genpath(pathstr));
end

%% Setting up 

grid_stepm  = grid_stepd*60;  % arcmin
nmax1       = nmax + 1;
if ~exist('cnm' , 'var')        % We check here if cnm (or snm!) is exist in workspace. If it's not exist

   eval(['load ' model ]);    % then we will upload it's value from a model!' 
end

% We could repeat this step for snm, but it doesn't matter. If we don't find either cnm, or snm then
% we will load coefficients from *.mat.

nmax_cnm = length(cnm) - 1;   % We substract 1 because we added one in file Reader section.
if nmax_cnm < nmax
   nmax     = nmax_cnm;
   nmax1    = nmax + 1;
end

tic
fprintf('\n-------------------------------\n');
fprintf('Model: %s, nmax=%d, half-wave: %.3g km\n' , model , nmax , 20e3/nmax);
fprintf('Grid step: %.3g deg = %.4g arcmin = %.3g km\n', grid_stepd, grid_stepm, grid_stepd/360*40e3);

if exist('functional' , 'var')
   if strcmpi(functional , 'gh')
      n_functional   = 1;
      label          = 'geoid heights (m)';

   % Here we could  add some other functions, gravity gradient for instance, so that to be calculated 
   % within the same function. But one at a time.   
   end
end

fprintf('Compute geoid grid: %s\n' , label);

if subtract_normal_field      == 1
   cnm(1:9 , 1:9) = cnm(1:9 , 1:9) - cnm_normal(8);
   fprintf('Normal field was subtracted.\n');
elseif subtract_normal_field  == 2
   cnm(1,1) = 0;
   fprintf('The central term C00 was zeroed.\n');
elseif subtract_normal_field  == 3
   cnm(1,1) = 0;
   cnm(3,1) = 0;
   fprintf('Coefficients C00, C20 were put equal to zero.\n');
else
   fprintf('Normal field was not subtracted.\n');
end

Nlon     = 360/grid_stepd; 
Nlat     = 180/grid_stepd;

latbp    = 90 - (0 : Nlat)*180/Nlat;
Nlat     = Nlat + 1;

colatd   = 90 - latbp;
Ngrid    = Nlon*Nlat;

fprintf('Number of points: %d = %.1f mil = %.1f mld\n' , Ngrid , Ngrid/1e6 , Ngrid/1e9);

%% Test, whether the grid is already computed
% In the folder 'temp' the computed geopotential grids are stored for speeding up the execution of the function.
% You may delete its contents if you wish.
% We save only grids which took more than 'time_limit_to_save_grids' seconds to compute.

filename             = mfilename('fullpath');
[pathstr, name, ext] = fileparts(filename);
temp_folder          = [pathstr '/temp/'];
if ~exist(temp_folder, 'file')
   mkdir(temp_folder);
   fid               = fopen([temp_folder 'readme.txt'] , 'w');

   fprintf(fid,'%% This folder was created by function: geoidUndulation.m\n');
   fprintf(fid,'%% In the folder ''temp'' the computed geopotential grids are stored for speeding up the execution of the function.\n');
   fprintf(fid,'%% You may delete its contents if you wish.\n');
   fprintf(fid,'%% We save only grids which took more than ''time_limit_to_save_grids'' seconds to compute.\n');
   fclose(fid);
end

addpath(temp_folder);

filename = sprintf('grid_%s_%d_%s_%03.3gm_subtr%d.mat', model, nmax, functional, grid_stepm, subtract_normal_field);
if exist(filename,'file')
   load(filename);
   fprintf('Loaded file: %s\n' , filename);
   return;
end

%% Computation
% The idea of this is to separate the equation into parts
% First we'll use the legendre function and pass to it the maximum degree, the order, and the geocentric latitute.
% Then we'll multiple the result, which we will assign it to some variable, by the cnm & snm coefficients.
%

h_waitbar      = waitbar(0 , sprintf('Computation: %s ...',label));

Am             = zeros(Nlat , nmax1);
Bm             = zeros(Nlat , nmax1);

for m = 0:nmax
   m1          = m + 1;
   Pnm         = associatedLegendreFunction(nmax, m, colatd);
   if n_functional      == 1      %label = 'geoid heights (m)';
      Am(:,m1) = Pnm*cnm(m1:nmax1 , m1);
      Bm(:,m1) = Pnm*snm(m1:nmax1 , m1);
      % Here we could pass functions like geoid disturbance, geoid anomaly, etc. It'd be great if we make the software
      % Have some of ICGEM calculation service features.
      % That might be added soon I guess. 

   end
      waitbar((m + 1)/nmax);
end

lonbp             = (0:Nlon)*360/Nlon;
lonbp             = lonbp - 180;
lon               = lonbp/rad;
cos_mlon          = cos((0:nmax)'*lon);
sin_mlon          = sin((0:nmax)'*lon);



if n_functional      == 1
   grid       = Re * (Am*cos_mlon + Bm*sin_mlon);
   % Here we should add some features like gravity disturbance, gravity anomaly, etc.
   % This basically why we use these ifs, which we can get rid of.
end

% This thing is for optimizing the function! we will use it to calculate the time that functions
% took to complete
% We have many ideas of how to optimize the function.
% One of them is to save the model that take more than *Time* to complete.

windowSize = 2000;
toc1 = toc;
close(h_waitbar);
fprintf('Time of computation: %.0f sec = %.1f min\n' , toc1 , toc1/60);

%if toc1 > time_limit_to_save_grids
   save([temp_folder filename], 'latbp' , 'lonbp' , 'grid', 'windowSize');
   fprintf('Saved file: %s\n' , filename);
%end
