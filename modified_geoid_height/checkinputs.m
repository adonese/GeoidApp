    function checkinputs()
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
    end