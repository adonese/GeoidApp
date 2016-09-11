    function checkaction( str )
        switch lower( str )
            case { 'error', 'warning', 'none' }
                action = lower( str );
            otherwise
                error(message('aero:geoidheight:unknownAction'));
        end
    end