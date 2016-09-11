% This function checks whether there is a *.gfc file in the current directory or not
% It assumes that there is only one *.gfc file in the current directory
% that is so expected because the user will only check for one *.gfc at a time.
% After that it takes (moves the computed paramaters) from the current directory into other directory, namely (data_icgem).
%
%


NMAX 		= 360;
NMAX 		= 1e100;  				%it is possible to limit the maximum degree read from the gfc file 
adr_data 	= './';
adr_where 	= './data_icgem/';

file_list 	= dir(adr_data);
file 		= {file_list.name};   	% cell with filenames

for i = 1:length(file)
   jm = file{i};
	if length(jm) > 4 && strcmpi(jm(end-3:end),'.gfc')
      file1 	= jm(1:end-4);
      fprintf('gfc file processed: %s\n',file1);
      filename 	= [adr_data file1 '.gfc'];

      % Read header
      fid = fopen(filename);

      % Initializing our values..., '' for strings, 0 for numbers (float)
      modelname = ''; GM = 0; ae = 0; Lmax = 0; errors = ''; norm = ''; tide = '';

      s = fgets(fid); %Essentially s is a parameter to handle the ggm file
	while(strncmp(s, 'end_of_head', 11) == 0 && sum(s) >= 0)
		 if (strncmp(s, 'product_type', 12)), 			product_type	= strtrim(s(13:end))	; end;
		 if (strncmp(s, 'modelname', 9)), 				modelname 		= strtrim(s(10:end))	; end;
		 if (strncmp(s, 'earth_gravity_constant', 22)), GM 				= str2double(s(23:end))	; end;	% Here we catch the GM value from GGM
		 if (strncmp(s, 'radius', 6)), 					ae 				= str2double(s(7:end))	; end;					% The semimajor value from GGM
		 if (strncmp(s, 'max_degree', 10)), 			Lmax 			= str2double(s(11:end))	; end;			% The max_degree
		 if (strncmp(s, 'errors', 6)), 					errors			= strtrim(s(7:end))		; end;
		 if (strncmp(s, 'norm', 4)), 					norm 			= strtrim(s(5:end))		; end;
		 if (strncmp(s, 'tide_system', 11)), 			tide 			= strtrim(s(12:end))	; end;
		 s = fgets(fid);
         % s is taking ggm file values, just not to lose our data...
	end


	if sum(s) < 0
         handleError('Problem with reading the gfc file.')
	end

	% From the previous values we "Struct" our values, we just arrange them

	header 	= struct('product_type', product_type, 'modelname', modelname, 'earth_gravity_constant', GM, 'radius', ae, 'max_degree', Lmax, 'errors', errors, 'norm', norm, 'tide_system', tide);

	% read coefficients
      cnm 	= zeros(Lmax + 1);
      snm 	= zeros(Lmax + 1);
      ecnm 	= zeros(Lmax + 1);
      esnm 	= zeros(Lmax + 1);

      % These lines might be useless, however we may need them at some point.

      i_t0 		= 0;
      i_trnd 	= 0; %parameters appear in ICGEM official format. 
      i_acos 	= 0;  
      i_asin 	= 0; 
      i_gfc 	= 0;
      cnm_t0 	= []; cnm_trnd = []; snm_trnd = []; cnm_acos = []; snm_acos = []; cnm_asin = []; snm_asin = [];


      s = fgets(fid);
      while (s >= 0)
         x = str2num(s(5:end));
         n = x(1) + 1;
         m = x(2) + 1;
         if n > NMAX || m > NMAX
            s = fgets(fid);
            continue;
         end
%         disp(s(1:4))
         if strcmp(s(1:4),'gfct')
            if isempty(cnm_t0)
               [status, result] = system(['grep -c gfct ' filename]);
               i1 				= str2double(result);
               if i1 			== 0; 									handleError('Problem with t0'); end
               cnm_t0 			= zeros(i1,3);
            end

            i_t0 				= i_t0 + 1;
            cnm(n,m) 			= x(3);
            snm(n,m) 			= x(4);

            [yr,mn,dy] 			= ymd2cal(x(end)/1e4);
            yrd 				= jd2yr(cal2jd(yr,mn,dy));
            cnm_t0(i_t0,:) 		= [n m yrd];

            if (strcmp(header.errors, 'formal') || strcmp(header.errors,'calibrated') || strcmp(header.errors,'calibrated_and_formal')),
               ecnm(n,m) 		= x(5);
               esnm(n,m) 		= x(6);
            end
         elseif strcmp(s(1:3),'gfc')
            cnm(n,m) 			= x(3);
            snm(n,m)			= x(4);
            if (strcmp(header.errors, 'formal') || strcmp(header.errors,'calibrated') || strcmp(header.errors,'calibrated_and_formal')),
               ecnm(n,m)		= x(5);
               esnm(n,m)		= x(6);
            end
            i_gfc=i_gfc+1;
         elseif strcmp(s(1:4),'trnd') || strcmp(s(1:3),'dot') 
            if isempty(cnm_trnd)
               [status, result] = system(['grep -c trnd ' filename]);
               i1=str2double(result);
               if i1 	== 0; [status, result] = system(['grep -c dot ' filename]); i1=str2num(result); end
               if i1 	== 0; handleError('Problem with trnd'); end
               cnm_trnd = zeros(i1,3); snm_trnd=cnm_trnd;
            end
            i_trnd 		= i_trnd + 1;

            cnm_trnd(i_trnd,:) = [n m x(3)];
            snm_trnd(i_trnd,:) = [n m x(4)];

         elseif strcmp(s(1:4),'acos')
            if isempty(cnm_acos)
               [status, result] = system(['grep -c acos ' filename]);
               i1=str2double(result);
               if i1 == 0; handleError('Problem with acos'); end
               cnm_acos = zeros(i1,4); snm_acos = cnm_acos;
            end

            i_acos = i_acos + 1;
            cnm_acos(i_acos,:) 		= [n m x(3) x(end)];
            snm_acos(i_acos,:) 		= [n m x(4) x(end)];

         elseif strcmp(s(1:4),'asin')
            if isempty(cnm_asin)
               [status, result] 	= system(['grep -c asin ' filename]);
               i1 					= str2double(result);
               if i1 == 0; handleError('Problem with asin'); end
               cnm_asin 			= zeros(i1,4); snm_asin = cnm_asin;
            end

            i_asin=i_asin+1;
            cnm_asin(i_asin,:)		= [n m x(3) x(end)];
            snm_asin(i_asin,:)		= [n m x(4) x(end)];

         else
            handleError('A problem occured in gfc data.');
         end

         s = fgets(fid);
      end

      fclose(fid);


      modelname = header.modelname;

      %it is possible to limit the maximum degree read from the gfc file 
      n_gfc = i_gfc; n_t0 	= i_t0; n_trnd = i_trnd; n_acos = i_acos; n_asin = i_asin; 
      if n_t0; cnm_t0 		= cnm_t0(1:n_t0,:); end
      if n_trnd; cnm_trnd	= cnm_trnd(1:n_trnd,:); snm_trnd = snm_trnd(1:n_trnd,:); end
      if n_acos; cnm_acos 	= cnm_acos(1:n_acos,:); snm_acos = snm_acos(1:n_acos,:); end
      if n_asin; cnm_asin	= cnm_asin(1:n_asin,:); snm_asin = snm_asin(1:n_asin,:); end
      if n_t0 ~= n_trnd || n_acos ~= n_asin
         handleError('Problem with numbers of TVG terms.');
      end

%       fprintf('   gfc terms: %d, gfct: %d, trnd: %d, acos: %d, asin: %d\n',[n_gfc n_t0 n_trnd n_acos n_asin]);

      if ~exist(adr_where,'file'), mkdir(adr_where); end
      if ~exist([adr_where 'gfc'],'file'), mkdir([adr_where 'gfc']); end
      eval(sprintf('save %s%s.mat cnm snm ecnm esnm header modelname n_t0 n_trnd n_acos n_asin cnm_t0 cnm_trnd snm_trnd cnm_acos snm_acos cnm_asin snm_asin;',adr_where,file1));
      movefile([adr_data file1 '.gfc'],[adr_where 'gfc']);
      fprintf('  Resulting file %s.mat was moved into folder: %s\n',file1,adr_where);
      fprintf('  Original file  %s.gfc was moved into folder: %sgfc\n',file1,adr_where);
   end


	
end