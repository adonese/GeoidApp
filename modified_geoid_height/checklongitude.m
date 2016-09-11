    function checklongitude()
        [lonwrapped, lon] = wraplongitude(lon,'deg','360');

        if lonwrapped
            % Create function handle array to handle messages based on
            % action
            fhlon = {@() disp('')... % do nothing for 'none'
                @() warning(message('aero:geoidheight:warnLongitudeWrap')), ...
                @() error(message('aero:geoidheight:longitudeWrap'))};

            % Call appropriate function
            fhlon{actionidx}()
        end
    end