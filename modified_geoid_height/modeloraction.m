    function modeloraction( str )
        switch lower( str )
            case 'egm2008'
                model = lower( str );
                datafile = 'geoidegm2008grid.mat';
            case 'egm96'
                model = lower( str );
                datafile = 'geoidegm96grid.mat';
            case { 'error', 'warning', 'none' }
                action = lower( str );
            otherwise
                error(message('aero:geoidheight:unknownString'));
        end
    end