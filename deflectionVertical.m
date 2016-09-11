%% Computing Deflection of the vertical components
% This script will take some of Mehdi program, but a few modifications
% will be introduced.

%%% Loading the most important parameters, i.e., latitude, and longitude
% We commented the lats belows because our function handles these
% processes.

lat          = data(:,1);
long         = data(:,2);
lat_geodetic = lat;
%lat          = lat*pi/180;
e2           = 0.00669437999013;
%lat          = atan((1-e2)*tan(lat));
Ae           = 0.6378136460E+07 ; 
GM           = 0.3986004415E+15;
% This thing will be handled by Mehdis ALFs function.

Nmax = 10;
%[pnm,dP] = Pnm(lat*180/pi,Nmax + 3,Nmax + 3);

long = long*pi/180;

sum_eta = 0; sum_psi = 0;

% We need to count for Nmax, in the previous script it was something like
% this:
% for i = 0:5:240
% ## here goes some commands
% and then Nmax = i

% One way to get around this problem is just to ignore the loop, and solve
% it as we have already did that in our geoid function. And the way to do
% this is as follows:
% What we have done is just take this whole code from our previous code and
% pasted it in here, with very little modifications.
colatd = 90 - lat;

%% Computing of Geocentric distances

N = Ae/sqrt(1-e2*sin(lat).^2);
X = N*cos(lat)*cos(long);
Y = N*cos(lat)*sin(long);
Z =(N*(1-e2))*sin(lat);
r = sqrt(X.^2+Y.^2+Z.^2);


%% Summation over all values
for n = 3:Nmax + 1
    for m = 1:n
        CS = (cnm(n,m)*cos((m-1)*long)+snm(n,m)*sin((m-1)*long));
        %Let's translate this equation'
        %cnm*cos((m-1)long) + snm*sin((m-1)lat)
        AA = (Ae/r).^(n+2);
        %What does AA term means?
        %It is (a/r)^n+1
        AA1 = (Ae/r).^n;
        %What does AA1 means?
        %It is (a/r)^n-1
        CS1 = (-snm(n,m)*cos((m-1)*long)+cnm(n,m)*sin((m-1)*long));
        %What does CS1 means?
        %Its for deflection of the vertical components. Let us discuss its
        %(-snm*cos(m(long))) + cnm*sin((m*long))
        PNM = pnm(n,m);
        % Computing the summation due to the east-west components of
        %deflection of vertical
        sum_eta = sum_eta + AA1*(m - 1)*(-CS1)*PNM;
        % Computing the summation due to the north-south components of
        % deflection of vertical
%        sum_psi = sum_psi + AA1*CS*dP(n,m);
        %It does not take Pnm, it takes dP

    end % of n
end % of m

%  Computation of normal gravity and its derivative with respect to latitude
%  using somigliana formula
[ng , dgdfi] = ngrav(phi*180/pi);

% Multiplication of the gravitational constant and Earths mass
% and axis of semi major axis of GRS80 reference filed
GMS = 0.3986005e15; AXS = 6378137.0;

%% Computation of east-west components of deflection of vertical 

eta = -GM/ng/Ae/r/cos(phi)*sum_eta*206265;

%Computation of north-south components of deflection of vertical 
%psi = -(GM/Ae*sumpsi*ng-dgdfi*GM/Ae*sumN)/ng^2/r*206265;

% printing the results on the screen
fprintf('\n%g %g %2.4f %2.4f',lat_geodetic,long*180/pi,eta);



