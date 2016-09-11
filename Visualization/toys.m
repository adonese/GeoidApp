%  Below are a set of matlab M-files, programs for matlab that
%  illustrate spherical harmonics by presenting images of various
%  multipole potentials.
%
%  Using an editor split this file into a set of separate files called
%        sh.m  rany.m  blob.m  turn.m
%  make the split at the lines %%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  function Ylm = sh(l, m);
%
%  Draw the equipotential surface of a multipole potential based on
%  Re Ylm, a spherical harmonic, degree l, order m
%  Returns numerical values evenly spaced in angle of Re Ylm.
%
%  To plot figure and ignore numerical values, just enter:    sh.m; 
%  without the = sign.

n = 6;  %  Number of samples per half wavelength
N = max([30, l*6]);
theta = [0 : N]' *pi/N;
phi   =[-N : N]  *pi/N;

%  Create the surface of Re Ylm(theta,phi)/r^(l+1) = 1;
%  Solves for r on a theta, phi grid
gamma = 1/(l+1);
all = legendre(l, cos(theta));
if (l == 0) all=all'; end         % Compensate for error in legendre 
Ylm = all(m+1, :)' * cos(m*phi);
r = abs(Ylm) .^ gamma;

%  Convert to Cartesian coordinates
X =  r.* (sin(theta)*cos(phi)) ;
Y =  r.* (sin(theta)*sin(phi));
Z =  r.* (cos(theta)*ones(size(phi)));

%  Color according to size and sign of Ylm
C = Ylm;

surf(X, Y, Z, C)
axis equal

colormap hot
ti=['Surface  Y_l^m/r^{l+1}=1  with l=' int2str(l) ', m=' int2str(m)];
title(ti);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Yl = rany(l)
%  function Yl = rany(l);
%  Generates and contours a lat-long grid matrix of values of 
%  a single degree SH with random contributions of all orders.

%  Note this is still an eigenfunction of grad_1^2

%  Plots an equipotential surface of the associated multipole
%  potential

n = 6;  %  Number of samples per half wavelength
N = max([30, l*6]);
theta = [0 : N]' *pi/N;
phi   =[-N : N]  *pi/N;

%  Generate degree  l   Schmidt normalized functions (equal
%  energy for each order)
all = legendre(l, cos(theta), 'sch');

%  Random coeffs, normally distributed
a =  randn(1, l+1);
b =  randn(1, l+1);

%  Sum the different orders - contour as we go
Yl = a(1)* all(1,:)' * ones(size(phi));
for m = 1 : l
contour(Yl); pause(0.5)
  Yl = Yl + all(m+1, :)'  ...
         *(a(m+1)* cos(m*phi) + b(m+1)*sin(m*phi));
end
contour(Yl)
pause(2)

% Display equipotential surface
gamma=1/(1+l);
r = abs(Yl) .^ gamma;
%  Convert to Cartesian coordinates
X =  r.* (sin(theta)*cos(phi)) ;
Y =  r.* (sin(theta)*sin(phi));
Z =  r.* (cos(theta)*ones(size(phi)));

%  Color according to size and sign of Yl
C = Yl;

surf(X, Y, Z, C)
axis equal

colormap hot
ti=['Surface random harmonic function of degree l=' int2str(l)];
title(ti);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function none=blob(Ylm, L, style)

%  Draw equipotential surface, based on possibly complex array Ylm
%  of size N+1, 2*N+1;  SH degree = L
%  style=1:  equipotential surface (default);  2: contours of intensity

C = real(Ylm);
[M N]=size(C);

N=M-1;
theta = [0 : N]' *pi/N;
phi   =[-N : N]  *pi/N;

if (style == 1)
%  Create the surface of Re Ylm(theta,phi)/r^(l+1) = 1;
%  Solves for r on a theta, phi grid
  gamma = 1;
  if (L > 0) gamma = 1/(L+1); end
  r = abs(C) .^ gamma;
else
  r=1;
end

%  Convert to Cartesian coordinates
X =  r.* (sin(theta)*cos(phi)) ;
Y =  r.* (sin(theta)*sin(phi));
Z =  r.* (cos(theta)*ones(size(phi)));

%  Color according to size and sign of Ylm

surf(X, Y, Z, C)
if (style > 1) shading interp; end
axis equal


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  turn
%  Rotates the viewing angle of the object in the current figure

dt=0.2;  % Pause time between frames in sec
az=-30;  % Initial azimuth, deg

pause(2) %  Gives time to move cursor into figure

% Rotate about horizontal axis
for elev = [-90 : 10 : 90] + 30
% disp([az, elev])
  view(az, elev)
  axis vis3d
  pause (dt)
end

% Rotate about vertical axis
elev=30;
for az = [0 : 10 : 360] + 30
% disp([az, elev])
  view(az, elev)
  axis vis3d
  pause (dt)
end
