    function checklatitude()
        % Wrap latitude and longitude if necessary
        [latwrapped,lat,lon] = wraplatitude(lat,lon,'deg');
        if latwrapped
            % Create function handle array to handle messages based on
            % action
            fhlat = {@() disp('')... % do nothing for 'none'
                  @() warning(message('aero:geoidheight:warnLatitudeWrap')), ...
                  @() error(message('aero:geoidheight:latitudeWrap'))};
            
           % Call appropriate function
           fhlat{actionidx}()
        end
    end