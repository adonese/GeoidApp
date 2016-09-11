    function checkmodel( str )
        switch lower( str )
            case 'egm2008'
                model = lower( str );
                datafile = 'geoidegm2008grid.mat';
            case 'egm96'
                model = lower( str );
                datafile = 'geoidegm96grid.mat';
            otherwise
                error(message('aero:geoidheight:unknownModel'));
        end
    end