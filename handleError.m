function handleError()
		if ~usejava('Desktop')
			disp(str);
			exit; 
		else
			error(str);
		end
	end
