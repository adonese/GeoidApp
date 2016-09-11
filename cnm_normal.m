function cnm_U=cnm(nmax)
% This function is related to what so called "tide system"
% In this case we've only use "tide_free", others are no tide, and something I forget. We'll count for them soon. But for
% now this might be good.

cnm_U 			= zeros(nmax+1,nmax+1);
cnm_U(1,1) 		= 1;
cnm_U(3,1) 		= -4.841669e-4; 
cnm_U(5,1) 		= 7.9030407e-7;
cnm_U(7,1) 		= 1.687251e-9; 
cnm_U(9,1) 		= 3.46098e-12;
cnm_U 			= cnm_U(1:nmax + 1 , 1:nmax + 1);
