                              

% *******************************************************************************************************
% 
%  This program computes the anomalies quantities such as geoidal height, gravity naomaly
%  east-west and north-south components of deflection of verticals, using a geopotential
%  model
% 
%                              Mehdi Eshagh and Ramin Kiamehr
%                                    Division of Geodesy 
%                               Royal Institude of Technology
%                                     Stockholm, Sweden
% 
%                                  Last upadate 29/11/2006
%                                  
%                     The program can be runned in three differents modes
%                     
%       1-Point-wise mode
%         For computing the quantities in any point
%       
%        
%       
%       2-Block-wise mode
%         For computing the quantities in a region
%         
%         
%       
%       3-Data file mode 
%         For computing the quantities on some special points, which are entered as a 
%         data file
% 
% 
% REFERENCE
% M. Eshagh and Kiamehr. R (2006):EGMLAB: a MATLAB software for determining the gravity field parameters from 
%                                         global geopotential models 
% 
%  ******************************************************************************************************
%         
%  
%  INPUT
%          1-Input in Point-wise mode
%            In this model the user should enter the latitude and longitude of the point, 
%            as well as the name of output file comprising the results.
%            
%          2-Input in Block-wise model
%            In this mode user should enter the the most upper latitude and the least lower 
%            latitude, as well as the least western and the most eastern longitudes of the 
%            desired area. Also the name of the output file should be entered by user
%           
%          3-Input in Data file model
%            In this model the user should enter the name of the data file including 
%            two columns, the first one is the latitude of the points and the second
%            one is the longitude of the points. Both of the latitudes and longitudes
%            are in degree. The name of output file is also requested from the user. 
%            
%            In all modes user should enter the name of the Earth gravity model. The
%            Earth gravity model should have the following format
%            
%            Nmax  Ae  GM   
%            n   m    Cnm   Snm   dCnm   dSnm
%            .   .     .     .      .      .
%            .   .     .     .      .      .
%            
%            where,
%                  Nmax=maximum degree and order of model
%                  Ae= Semi major axis of reference ellipsoid for this model
%                  GM= product of the gravitational constant and Earth\s mass
%                  n/m= degree/order
%                  Cnm/Snm= Geopotentail harmonic coefficeints
%                  dCnm/dSnm= Geopotential harmonic coefficients errors
%                  
%                  
%  OUTPUT  
%            format of the output file in all three modes is the same as follow
%            
%            phi  lambda   N   dg   eta    ksi
%            
%            where, 
%                   
%                 phi/lambda=latitude/longitude (in degrees)
%                 N=Geoidal height              (in meters)
%                 dg=gravity anomaly            (in mgals)
%                 eta=east-west components      (in arc seconds)
%                 ksi=north-south components    (in arc seconds)
%                 
%             in block-wise mode the isarithmic maps of the quantitie are generated
%             and presented too.
%  
% *************************************************************************************************





for j=10:5:240
    Ae=0.6378136460E+07 ; 
    GM=0.3986004415E+15;

F=load('G:\GGM_2015\GPS_data.txt');
    Nmax=j
OUT=(sprintf('%g_go_cons_gcf_2_dir_r2.DAT',Nmax));
    
fid=fopen(OUT,'wt');

%Reading the Geopotential Model
filename1='go_cons_gcf_2_dir_r2-Copy.gfc' ;
% fprintf('reading the Earth garvity Model, wait \n');
% load GRACE


[CC,SS,dCC,dSS]=Modelread2(filename1);
%Generating the Normal gravity field
fprintf('Computing the Normal gravity field, wait\n');
CN=Normal(GM,Ae,Nmax);
%Geration of the Potetial Anomaly
CC(3:11,1)=CC(3:11,1)-CN(3:11)';
LF=length(F);  
tic;
% This loop is just for the case where the Data file mode is selected
% The for below can be omitted, it'll give even better results
for i=1:LF
    phi=F(i,1);
    lambda=F(i,2);
    phigeodetic=phi;
    phi=phi*pi/180;
    
        % Computing the Geocentric latitude via geodetic latitute
        e2=.00669437999013;
        phi=atan((1-e2)*tan(phi));
    
        %Computing the Associated Legendre functions and their derivatives
        [pnm,dP]=Pnm(phi*180/pi,Nmax+3,Nmax+3);
   
        % loop due to the longitude
        lambda=lambda*pi/180;

            % Creating some variables for summations
            sumeta=0;sumpsi=0;
        
            % Computation of geocenric distance 
            N=Ae/sqrt(1-e2*sin(phi)^2);
            X=N*cos(phi)*cos(lambda);
            Y=N*cos(phi)*sin(lambda);
            Z=(N*(1-e2))*sin(phi);
            r=sqrt(X^2+Y^2+Z^2);
            [sumN,sumdg]=looop(lambda,CC,SS,Ae,Nmax,r,pnm);

             for n=3:Nmax+1
                 for m=1:n
%         
%  
                     CS=(CC(n,m)*cos((m-1)*lambda)+SS(n,m)*sin((m-1)*lambda));
%                       Let's translate this equation'
%                       cnm*cos((m-1)long) + snm*sin((m-1)lat)
                     AA=(Ae/r)^(n+2);
%                       What does AA term means?
%                       It is (a/r)^n+1
                     AA1=(Ae/r)^n;
%                       What does AA1 means?
%                       It is (a/r)^n-1
                     CS1=(-SS(n,m)*cos((m-1)*lambda)+CC(n,m)*sin((m-1)*lambda));
%                       What does CS1 means?
%                       Its for deflection of the vertical components. Let us discuss its
%                       (-snm*cos(m(long))) + cnm*sin((m*long))
                     PNM=pnm(n,m);
%        
%                     % Computing the summation due to Geoid Undulation 
                     sumN=sumN+AA1*CS*PNM;
%      
%                     % Computing the summation due to the gravity anomaly
                     sumdg=sumdg+AA1*(n-2)/r*CS*PNM;
%         
% %                     % Computing the summation due to the east-west components of
% %                     % deflection of vertical
% %                     sumeta=sumeta+AA1*(m-1)*(-CS1)*PNM;
% %        
% %                     % Computing the summation due to the north-south components of
% %                     % deflection of vertical
% %                     sumpsi=sumpsi+AA1*CS*dP(n,m);
%                       It does not take Pnm, it takes dP
%        
                 end % of n
             end % of m


            %  Computation of normal gravity and its derivative with respect to latitude
            %  using somigliana formula
            [ng,dgdfi]=ngrav(phi*180/pi);
 
            % Multiplication of the gravitational constant and Earth's mass
            % and axis of semi major axis of GRS80 reference filed
            GMS=0.3986005e15; AXS=6378137.0;
 
            % Computation of Geoid
            N=(GM/Ae*(1-GMS/GM*Ae/AXS)+GM/Ae*sumN)/ng;

            % Computation of gravity anomaly
            dg=(GM/Ae*sumdg-GM/r^2*(1-GMS/GM*Ae/AXS))*100000; 
 
%             % Computation of east-west components of deflection of vertical 
%             eta=-GM/ng/Ae/r/cos(phi)*sumeta*206265;
%  
%             % Computation of north-south components of deflection of vertical 
%             psi=-(GM/Ae*sumpsi*ng-dgdfi*GM/Ae*sumN)/ng^2/r*206265;

 
            % printing the results in the file 
            fprintf(fid,'\n%g %g %2.4f %2.4f',phigeodetic,lambda*180/pi,N,dg);
            
            % printing the results on the screen
            fprintf('\n%g %g %2.4f %2.4f',phigeodetic,lambda*180/pi,N,dg);
               
     
end % of i
toc;
%Closing the results file
fclose(fid);

result=load(OUT);
N2=result(:,3);
N=F(:,3);
dn=N2-N;
g=[N N2 dn];
stat=[min(dn);max(dn);mean(dn);std(dn)];
st=(sprintf('stat_%g_go_cons_gcf_2_dir_r2.TXT',Nmax));
dlmwrite(st, stat, 'delimiter', '\t','precision', 6)
dnn=(sprintf('compr_%g_go_cons_gcf_2_dir_r2.TXT',Nmax));
dlmwrite(dnn, g, 'delimiter', '\t','precision', 6)
% c
end
% % in1 = [1:10]';
%  hrms = dsp.RMS;
%  dn_rms= step(hrms, dn)
 





