 function checkegm2008( str )	 
     if strcmp(str,'egm2008')
         if isempty(which('geoidegm2008grid.mat','-ALL'))
             error(message('aero:geoidheight:noDownloadData',...
                 '<a href="matlab: aeroDataPackage">aeroDataPackage</a>'))
         end
     end
 end