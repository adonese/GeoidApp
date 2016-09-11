/*
* MATLAB Compiler: 6.0 (R2015a)
* Date: Tue Jan 05 22:38:13 2016
* Arguments: "-B" "macro_default" "-W" "dotnet:geoid_height,Class1,0.0,private" "-T"
* "link:lib" "-d" "C:\Users\mohamed\Desktop\Graduation Project\Source
* Code\geoid_height\for_testing" "-v" "class{Class1:C:\Users\mohamed\Desktop\Graduation
* Project\Source Code\geoid_height.m}" 
*/
using System;
using System.Reflection;
using System.IO;
using MathWorks.MATLAB.NET.Arrays;
using MathWorks.MATLAB.NET.Utility;

#if SHARED
[assembly: System.Reflection.AssemblyKeyFile(@"")]
#endif

namespace geoid_height
{

  /// <summary>
  /// The Class1 class provides a CLS compliant, MWArray interface to the MATLAB
  /// functions contained in the files:
  /// <newpara></newpara>
  /// C:\Users\mohamed\Desktop\Graduation Project\Source Code\geoid_height.m
  /// </summary>
  /// <remarks>
  /// @Version 0.0
  /// </remarks>
  public class Class1 : IDisposable
  {
    #region Constructors

    /// <summary internal= "true">
    /// The static constructor instantiates and initializes the MATLAB runtime instance.
    /// </summary>
    static Class1()
    {
      if (MWMCR.MCRAppInitialized)
      {
        try
        {
          Assembly assembly= Assembly.GetExecutingAssembly();

          string ctfFilePath= assembly.Location;

          int lastDelimiter= ctfFilePath.LastIndexOf(@"\");

          ctfFilePath= ctfFilePath.Remove(lastDelimiter, (ctfFilePath.Length - lastDelimiter));

          string ctfFileName = "geoid_height.ctf";

          Stream embeddedCtfStream = null;

          String[] resourceStrings = assembly.GetManifestResourceNames();

          foreach (String name in resourceStrings)
          {
            if (name.Contains(ctfFileName))
            {
              embeddedCtfStream = assembly.GetManifestResourceStream(name);
              break;
            }
          }
          mcr= new MWMCR("",
                         ctfFilePath, embeddedCtfStream, true);
        }
        catch(Exception ex)
        {
          ex_ = new Exception("MWArray assembly failed to be initialized", ex);
        }
      }
      else
      {
        ex_ = new ApplicationException("MWArray assembly could not be initialized");
      }
    }


    /// <summary>
    /// Constructs a new instance of the Class1 class.
    /// </summary>
    public Class1()
    {
      if(ex_ != null)
      {
        throw ex_;
      }
    }


    #endregion Constructors

    #region Finalize

    /// <summary internal= "true">
    /// Class destructor called by the CLR garbage collector.
    /// </summary>
    ~Class1()
    {
      Dispose(false);
    }


    /// <summary>
    /// Frees the native resources associated with this object
    /// </summary>
    public void Dispose()
    {
      Dispose(true);

      GC.SuppressFinalize(this);
    }


    /// <summary internal= "true">
    /// Internal dispose function
    /// </summary>
    protected virtual void Dispose(bool disposing)
    {
      if (!disposed)
      {
        disposed= true;

        if (disposing)
        {
          // Free managed resources;
        }

        // Free native resources
      }
    }


    #endregion Finalize

    #region Methods

    /// <summary>
    /// Provides a single output, 0-input MWArrayinterface to the geoid_height MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// GEOIDHEIGHT Implement a geopotential model to calculate geoid height
    /// N = GEOIDHEIGHT( LAT, LON, MODEL ) calculates the geoid height as
    /// determined from a selected geopotential model, MODEL. An array of M
    /// geoid heights, N, are interpolated at M geocentric latitude, LAT, and M
    /// geocentric longitude, LON, from a grid of point values in the tide-free
    /// system, using the selected geopotential model, MODEL.  
    /// The GEOIDHEIGHT function calculates geoid heights to 0.01 meters for
    /// EGM96 and custom.  The GEOIDHEIGHT function calculates geoid heights to
    /// 0.001 meters for EGM2008.
    /// The interpolation scheme wraps over the poles to allow for geoid height
    /// calculations at and near these locations.
    /// Alternate formats for calling geoid height are:
    /// N = GEOIDHEIGHT( LAT, LON )
    /// N = GEOIDHEIGHT( LAT, LON, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, MODEL, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE, ACTION )
    /// Inputs for GEOIDHEIGHT are:
    /// LAT      :an array of M geocentric latitudes in degrees where north
    /// latitude is positive, and south latitude is negative. LAT
    /// must be of type single or double. If LAT is not in the range
    /// of [-90,90] it is wrapped to be within the range.
    /// LON      :an array of M geocentric longitude in degrees where east
    /// longitude is positive, west is negative. LON must be of type
    /// single or double. If LON is not in the range of [0,360] it is
    /// wrapped to be within the range.
    /// MODEL    :a string specifying the geopotential model: 'EGM2008' (Earth),
    /// 'EGM96' (Earth), or 'Custom'.  The default is 'EGM96'.  
    /// 'EGM96' uses a 15-minute grid of point values in the
    /// tide-free system, using EGM96 Geopotential Model to degree
    /// and order 360.  The EGM2008 MODEL uses a 2.5-minute grid of
    /// point values in the tide-free system, using the EGM2008
    /// Geopotential Model to degree and order 2159. The geoid
    /// undulations for EGM96 and EGM2008 are with respect to the
    /// WGS84 ellipsoid. 
    /// DATAFILE :a mat-file containing an array of geocentric
    /// latitude breakpoints, 'latbp', an array of geocentric
    /// longitude breakpoints, 'lonbp', a table of geoid height
    /// values,'grid' and a even integer scalar greater than 2 for
    /// number of interpolation points, 'windowSize'.  This is only
    /// needed for a 'Custom' geopotential model.     
    /// ACTION   :a string to determine action for out of range latitude or
    /// longitude. Specify if out of range input invokes a 'Warning',
    /// 'Error', or no action ('None'). The default is 'Warning'.
    /// Output for GEOIDHEIGHT is:
    /// N        :an array of M geoid heights in meters with the same data type
    /// as the input LAT.
    /// Limitations:
    /// This function using the 'EGM96' MODEL has the limitations of the 1996
    /// Earth Geopotential Model.  For more information see the documentation.
    /// The WGS84 EGM96 geoid undulations have an error range of +/- 0.5 to
    /// +/- 1.0 meters worldwide.
    /// This function using the 'EGM2008' MODEL has the limitations of the 2008
    /// Earth Geopotential Model.  For more information see the documentation.
    /// Examples:
    /// Calculate the EGM96 geoid height at 42.4 degrees N latitude and 71.0 degrees 
    /// W longitude with warning actions:
    /// N = geoidheight( 42.4, -71.0 )
    /// Calculate the EGM2008 geoid height at two different locations with
    /// error actions.
    /// N = geoidheight( [39.3, 33.4], [77.2, 36.5], 'egm2008','error')
    /// Calculate a custom geoid height at two different locations with
    /// no actions.
    /// N = geoidheight( [39.3, 33.4], [-77.2, 36.5], 'custom', ...
    /// 'geoidegm96grid','none')
    /// Note: This function uses geoid data that can be obtained using the
    /// aeroDataPackage command.
    /// See also GRAVITYWGS84, GRAVITYSPHERICALHARMONIC
    /// </remarks>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray geoid_height()
    {
      return mcr.EvaluateFunction("geoid_height", new MWArray[]{});
    }


    /// <summary>
    /// Provides a single output, 1-input MWArrayinterface to the geoid_height MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// GEOIDHEIGHT Implement a geopotential model to calculate geoid height
    /// N = GEOIDHEIGHT( LAT, LON, MODEL ) calculates the geoid height as
    /// determined from a selected geopotential model, MODEL. An array of M
    /// geoid heights, N, are interpolated at M geocentric latitude, LAT, and M
    /// geocentric longitude, LON, from a grid of point values in the tide-free
    /// system, using the selected geopotential model, MODEL.  
    /// The GEOIDHEIGHT function calculates geoid heights to 0.01 meters for
    /// EGM96 and custom.  The GEOIDHEIGHT function calculates geoid heights to
    /// 0.001 meters for EGM2008.
    /// The interpolation scheme wraps over the poles to allow for geoid height
    /// calculations at and near these locations.
    /// Alternate formats for calling geoid height are:
    /// N = GEOIDHEIGHT( LAT, LON )
    /// N = GEOIDHEIGHT( LAT, LON, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, MODEL, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE, ACTION )
    /// Inputs for GEOIDHEIGHT are:
    /// LAT      :an array of M geocentric latitudes in degrees where north
    /// latitude is positive, and south latitude is negative. LAT
    /// must be of type single or double. If LAT is not in the range
    /// of [-90,90] it is wrapped to be within the range.
    /// LON      :an array of M geocentric longitude in degrees where east
    /// longitude is positive, west is negative. LON must be of type
    /// single or double. If LON is not in the range of [0,360] it is
    /// wrapped to be within the range.
    /// MODEL    :a string specifying the geopotential model: 'EGM2008' (Earth),
    /// 'EGM96' (Earth), or 'Custom'.  The default is 'EGM96'.  
    /// 'EGM96' uses a 15-minute grid of point values in the
    /// tide-free system, using EGM96 Geopotential Model to degree
    /// and order 360.  The EGM2008 MODEL uses a 2.5-minute grid of
    /// point values in the tide-free system, using the EGM2008
    /// Geopotential Model to degree and order 2159. The geoid
    /// undulations for EGM96 and EGM2008 are with respect to the
    /// WGS84 ellipsoid. 
    /// DATAFILE :a mat-file containing an array of geocentric
    /// latitude breakpoints, 'latbp', an array of geocentric
    /// longitude breakpoints, 'lonbp', a table of geoid height
    /// values,'grid' and a even integer scalar greater than 2 for
    /// number of interpolation points, 'windowSize'.  This is only
    /// needed for a 'Custom' geopotential model.     
    /// ACTION   :a string to determine action for out of range latitude or
    /// longitude. Specify if out of range input invokes a 'Warning',
    /// 'Error', or no action ('None'). The default is 'Warning'.
    /// Output for GEOIDHEIGHT is:
    /// N        :an array of M geoid heights in meters with the same data type
    /// as the input LAT.
    /// Limitations:
    /// This function using the 'EGM96' MODEL has the limitations of the 1996
    /// Earth Geopotential Model.  For more information see the documentation.
    /// The WGS84 EGM96 geoid undulations have an error range of +/- 0.5 to
    /// +/- 1.0 meters worldwide.
    /// This function using the 'EGM2008' MODEL has the limitations of the 2008
    /// Earth Geopotential Model.  For more information see the documentation.
    /// Examples:
    /// Calculate the EGM96 geoid height at 42.4 degrees N latitude and 71.0 degrees 
    /// W longitude with warning actions:
    /// N = geoidheight( 42.4, -71.0 )
    /// Calculate the EGM2008 geoid height at two different locations with
    /// error actions.
    /// N = geoidheight( [39.3, 33.4], [77.2, 36.5], 'egm2008','error')
    /// Calculate a custom geoid height at two different locations with
    /// no actions.
    /// N = geoidheight( [39.3, 33.4], [-77.2, 36.5], 'custom', ...
    /// 'geoidegm96grid','none')
    /// Note: This function uses geoid data that can be obtained using the
    /// aeroDataPackage command.
    /// See also GRAVITYWGS84, GRAVITYSPHERICALHARMONIC
    /// </remarks>
    /// <param name="lat">Input argument #1</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray geoid_height(MWArray lat)
    {
      return mcr.EvaluateFunction("geoid_height", lat);
    }


    /// <summary>
    /// Provides a single output, 2-input MWArrayinterface to the geoid_height MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// GEOIDHEIGHT Implement a geopotential model to calculate geoid height
    /// N = GEOIDHEIGHT( LAT, LON, MODEL ) calculates the geoid height as
    /// determined from a selected geopotential model, MODEL. An array of M
    /// geoid heights, N, are interpolated at M geocentric latitude, LAT, and M
    /// geocentric longitude, LON, from a grid of point values in the tide-free
    /// system, using the selected geopotential model, MODEL.  
    /// The GEOIDHEIGHT function calculates geoid heights to 0.01 meters for
    /// EGM96 and custom.  The GEOIDHEIGHT function calculates geoid heights to
    /// 0.001 meters for EGM2008.
    /// The interpolation scheme wraps over the poles to allow for geoid height
    /// calculations at and near these locations.
    /// Alternate formats for calling geoid height are:
    /// N = GEOIDHEIGHT( LAT, LON )
    /// N = GEOIDHEIGHT( LAT, LON, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, MODEL, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE, ACTION )
    /// Inputs for GEOIDHEIGHT are:
    /// LAT      :an array of M geocentric latitudes in degrees where north
    /// latitude is positive, and south latitude is negative. LAT
    /// must be of type single or double. If LAT is not in the range
    /// of [-90,90] it is wrapped to be within the range.
    /// LON      :an array of M geocentric longitude in degrees where east
    /// longitude is positive, west is negative. LON must be of type
    /// single or double. If LON is not in the range of [0,360] it is
    /// wrapped to be within the range.
    /// MODEL    :a string specifying the geopotential model: 'EGM2008' (Earth),
    /// 'EGM96' (Earth), or 'Custom'.  The default is 'EGM96'.  
    /// 'EGM96' uses a 15-minute grid of point values in the
    /// tide-free system, using EGM96 Geopotential Model to degree
    /// and order 360.  The EGM2008 MODEL uses a 2.5-minute grid of
    /// point values in the tide-free system, using the EGM2008
    /// Geopotential Model to degree and order 2159. The geoid
    /// undulations for EGM96 and EGM2008 are with respect to the
    /// WGS84 ellipsoid. 
    /// DATAFILE :a mat-file containing an array of geocentric
    /// latitude breakpoints, 'latbp', an array of geocentric
    /// longitude breakpoints, 'lonbp', a table of geoid height
    /// values,'grid' and a even integer scalar greater than 2 for
    /// number of interpolation points, 'windowSize'.  This is only
    /// needed for a 'Custom' geopotential model.     
    /// ACTION   :a string to determine action for out of range latitude or
    /// longitude. Specify if out of range input invokes a 'Warning',
    /// 'Error', or no action ('None'). The default is 'Warning'.
    /// Output for GEOIDHEIGHT is:
    /// N        :an array of M geoid heights in meters with the same data type
    /// as the input LAT.
    /// Limitations:
    /// This function using the 'EGM96' MODEL has the limitations of the 1996
    /// Earth Geopotential Model.  For more information see the documentation.
    /// The WGS84 EGM96 geoid undulations have an error range of +/- 0.5 to
    /// +/- 1.0 meters worldwide.
    /// This function using the 'EGM2008' MODEL has the limitations of the 2008
    /// Earth Geopotential Model.  For more information see the documentation.
    /// Examples:
    /// Calculate the EGM96 geoid height at 42.4 degrees N latitude and 71.0 degrees 
    /// W longitude with warning actions:
    /// N = geoidheight( 42.4, -71.0 )
    /// Calculate the EGM2008 geoid height at two different locations with
    /// error actions.
    /// N = geoidheight( [39.3, 33.4], [77.2, 36.5], 'egm2008','error')
    /// Calculate a custom geoid height at two different locations with
    /// no actions.
    /// N = geoidheight( [39.3, 33.4], [-77.2, 36.5], 'custom', ...
    /// 'geoidegm96grid','none')
    /// Note: This function uses geoid data that can be obtained using the
    /// aeroDataPackage command.
    /// See also GRAVITYWGS84, GRAVITYSPHERICALHARMONIC
    /// </remarks>
    /// <param name="lat">Input argument #1</param>
    /// <param name="lon">Input argument #2</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray geoid_height(MWArray lat, MWArray lon)
    {
      return mcr.EvaluateFunction("geoid_height", lat, lon);
    }


    /// <summary>
    /// Provides a single output, 3-input MWArrayinterface to the geoid_height MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// GEOIDHEIGHT Implement a geopotential model to calculate geoid height
    /// N = GEOIDHEIGHT( LAT, LON, MODEL ) calculates the geoid height as
    /// determined from a selected geopotential model, MODEL. An array of M
    /// geoid heights, N, are interpolated at M geocentric latitude, LAT, and M
    /// geocentric longitude, LON, from a grid of point values in the tide-free
    /// system, using the selected geopotential model, MODEL.  
    /// The GEOIDHEIGHT function calculates geoid heights to 0.01 meters for
    /// EGM96 and custom.  The GEOIDHEIGHT function calculates geoid heights to
    /// 0.001 meters for EGM2008.
    /// The interpolation scheme wraps over the poles to allow for geoid height
    /// calculations at and near these locations.
    /// Alternate formats for calling geoid height are:
    /// N = GEOIDHEIGHT( LAT, LON )
    /// N = GEOIDHEIGHT( LAT, LON, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, MODEL, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE, ACTION )
    /// Inputs for GEOIDHEIGHT are:
    /// LAT      :an array of M geocentric latitudes in degrees where north
    /// latitude is positive, and south latitude is negative. LAT
    /// must be of type single or double. If LAT is not in the range
    /// of [-90,90] it is wrapped to be within the range.
    /// LON      :an array of M geocentric longitude in degrees where east
    /// longitude is positive, west is negative. LON must be of type
    /// single or double. If LON is not in the range of [0,360] it is
    /// wrapped to be within the range.
    /// MODEL    :a string specifying the geopotential model: 'EGM2008' (Earth),
    /// 'EGM96' (Earth), or 'Custom'.  The default is 'EGM96'.  
    /// 'EGM96' uses a 15-minute grid of point values in the
    /// tide-free system, using EGM96 Geopotential Model to degree
    /// and order 360.  The EGM2008 MODEL uses a 2.5-minute grid of
    /// point values in the tide-free system, using the EGM2008
    /// Geopotential Model to degree and order 2159. The geoid
    /// undulations for EGM96 and EGM2008 are with respect to the
    /// WGS84 ellipsoid. 
    /// DATAFILE :a mat-file containing an array of geocentric
    /// latitude breakpoints, 'latbp', an array of geocentric
    /// longitude breakpoints, 'lonbp', a table of geoid height
    /// values,'grid' and a even integer scalar greater than 2 for
    /// number of interpolation points, 'windowSize'.  This is only
    /// needed for a 'Custom' geopotential model.     
    /// ACTION   :a string to determine action for out of range latitude or
    /// longitude. Specify if out of range input invokes a 'Warning',
    /// 'Error', or no action ('None'). The default is 'Warning'.
    /// Output for GEOIDHEIGHT is:
    /// N        :an array of M geoid heights in meters with the same data type
    /// as the input LAT.
    /// Limitations:
    /// This function using the 'EGM96' MODEL has the limitations of the 1996
    /// Earth Geopotential Model.  For more information see the documentation.
    /// The WGS84 EGM96 geoid undulations have an error range of +/- 0.5 to
    /// +/- 1.0 meters worldwide.
    /// This function using the 'EGM2008' MODEL has the limitations of the 2008
    /// Earth Geopotential Model.  For more information see the documentation.
    /// Examples:
    /// Calculate the EGM96 geoid height at 42.4 degrees N latitude and 71.0 degrees 
    /// W longitude with warning actions:
    /// N = geoidheight( 42.4, -71.0 )
    /// Calculate the EGM2008 geoid height at two different locations with
    /// error actions.
    /// N = geoidheight( [39.3, 33.4], [77.2, 36.5], 'egm2008','error')
    /// Calculate a custom geoid height at two different locations with
    /// no actions.
    /// N = geoidheight( [39.3, 33.4], [-77.2, 36.5], 'custom', ...
    /// 'geoidegm96grid','none')
    /// Note: This function uses geoid data that can be obtained using the
    /// aeroDataPackage command.
    /// See also GRAVITYWGS84, GRAVITYSPHERICALHARMONIC
    /// </remarks>
    /// <param name="lat">Input argument #1</param>
    /// <param name="lon">Input argument #2</param>
    /// <param name="varargin">Array of MWArrays representing the input arguments 3
    /// through varargin.length+2</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray geoid_height(MWArray lat, MWArray lon, params MWArray[] varargin)
    {
      MWArray[] args = {lat, lon};
      int nonVarargInputNum = args.Length;
      int varargInputNum = varargin.Length;
      int totalNumArgs = varargInputNum > 0 ? (nonVarargInputNum + varargInputNum) : nonVarargInputNum;
      Array newArr = Array.CreateInstance(typeof(MWArray), totalNumArgs);

      int idx = 0;

      for (idx = 0; idx < nonVarargInputNum; idx++)
        newArr.SetValue(args[idx],idx);

      if (varargInputNum > 0)
      {
        for (int i = 0; i < varargInputNum; i++)
        {
          newArr.SetValue(varargin[i], idx);
          idx++;
        }
      }

      return mcr.EvaluateFunction("geoid_height", (MWArray[])newArr );
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the geoid_height MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// GEOIDHEIGHT Implement a geopotential model to calculate geoid height
    /// N = GEOIDHEIGHT( LAT, LON, MODEL ) calculates the geoid height as
    /// determined from a selected geopotential model, MODEL. An array of M
    /// geoid heights, N, are interpolated at M geocentric latitude, LAT, and M
    /// geocentric longitude, LON, from a grid of point values in the tide-free
    /// system, using the selected geopotential model, MODEL.  
    /// The GEOIDHEIGHT function calculates geoid heights to 0.01 meters for
    /// EGM96 and custom.  The GEOIDHEIGHT function calculates geoid heights to
    /// 0.001 meters for EGM2008.
    /// The interpolation scheme wraps over the poles to allow for geoid height
    /// calculations at and near these locations.
    /// Alternate formats for calling geoid height are:
    /// N = GEOIDHEIGHT( LAT, LON )
    /// N = GEOIDHEIGHT( LAT, LON, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, MODEL, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE, ACTION )
    /// Inputs for GEOIDHEIGHT are:
    /// LAT      :an array of M geocentric latitudes in degrees where north
    /// latitude is positive, and south latitude is negative. LAT
    /// must be of type single or double. If LAT is not in the range
    /// of [-90,90] it is wrapped to be within the range.
    /// LON      :an array of M geocentric longitude in degrees where east
    /// longitude is positive, west is negative. LON must be of type
    /// single or double. If LON is not in the range of [0,360] it is
    /// wrapped to be within the range.
    /// MODEL    :a string specifying the geopotential model: 'EGM2008' (Earth),
    /// 'EGM96' (Earth), or 'Custom'.  The default is 'EGM96'.  
    /// 'EGM96' uses a 15-minute grid of point values in the
    /// tide-free system, using EGM96 Geopotential Model to degree
    /// and order 360.  The EGM2008 MODEL uses a 2.5-minute grid of
    /// point values in the tide-free system, using the EGM2008
    /// Geopotential Model to degree and order 2159. The geoid
    /// undulations for EGM96 and EGM2008 are with respect to the
    /// WGS84 ellipsoid. 
    /// DATAFILE :a mat-file containing an array of geocentric
    /// latitude breakpoints, 'latbp', an array of geocentric
    /// longitude breakpoints, 'lonbp', a table of geoid height
    /// values,'grid' and a even integer scalar greater than 2 for
    /// number of interpolation points, 'windowSize'.  This is only
    /// needed for a 'Custom' geopotential model.     
    /// ACTION   :a string to determine action for out of range latitude or
    /// longitude. Specify if out of range input invokes a 'Warning',
    /// 'Error', or no action ('None'). The default is 'Warning'.
    /// Output for GEOIDHEIGHT is:
    /// N        :an array of M geoid heights in meters with the same data type
    /// as the input LAT.
    /// Limitations:
    /// This function using the 'EGM96' MODEL has the limitations of the 1996
    /// Earth Geopotential Model.  For more information see the documentation.
    /// The WGS84 EGM96 geoid undulations have an error range of +/- 0.5 to
    /// +/- 1.0 meters worldwide.
    /// This function using the 'EGM2008' MODEL has the limitations of the 2008
    /// Earth Geopotential Model.  For more information see the documentation.
    /// Examples:
    /// Calculate the EGM96 geoid height at 42.4 degrees N latitude and 71.0 degrees 
    /// W longitude with warning actions:
    /// N = geoidheight( 42.4, -71.0 )
    /// Calculate the EGM2008 geoid height at two different locations with
    /// error actions.
    /// N = geoidheight( [39.3, 33.4], [77.2, 36.5], 'egm2008','error')
    /// Calculate a custom geoid height at two different locations with
    /// no actions.
    /// N = geoidheight( [39.3, 33.4], [-77.2, 36.5], 'custom', ...
    /// 'geoidegm96grid','none')
    /// Note: This function uses geoid data that can be obtained using the
    /// aeroDataPackage command.
    /// See also GRAVITYWGS84, GRAVITYSPHERICALHARMONIC
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] geoid_height(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "geoid_height", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the geoid_height MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// GEOIDHEIGHT Implement a geopotential model to calculate geoid height
    /// N = GEOIDHEIGHT( LAT, LON, MODEL ) calculates the geoid height as
    /// determined from a selected geopotential model, MODEL. An array of M
    /// geoid heights, N, are interpolated at M geocentric latitude, LAT, and M
    /// geocentric longitude, LON, from a grid of point values in the tide-free
    /// system, using the selected geopotential model, MODEL.  
    /// The GEOIDHEIGHT function calculates geoid heights to 0.01 meters for
    /// EGM96 and custom.  The GEOIDHEIGHT function calculates geoid heights to
    /// 0.001 meters for EGM2008.
    /// The interpolation scheme wraps over the poles to allow for geoid height
    /// calculations at and near these locations.
    /// Alternate formats for calling geoid height are:
    /// N = GEOIDHEIGHT( LAT, LON )
    /// N = GEOIDHEIGHT( LAT, LON, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, MODEL, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE, ACTION )
    /// Inputs for GEOIDHEIGHT are:
    /// LAT      :an array of M geocentric latitudes in degrees where north
    /// latitude is positive, and south latitude is negative. LAT
    /// must be of type single or double. If LAT is not in the range
    /// of [-90,90] it is wrapped to be within the range.
    /// LON      :an array of M geocentric longitude in degrees where east
    /// longitude is positive, west is negative. LON must be of type
    /// single or double. If LON is not in the range of [0,360] it is
    /// wrapped to be within the range.
    /// MODEL    :a string specifying the geopotential model: 'EGM2008' (Earth),
    /// 'EGM96' (Earth), or 'Custom'.  The default is 'EGM96'.  
    /// 'EGM96' uses a 15-minute grid of point values in the
    /// tide-free system, using EGM96 Geopotential Model to degree
    /// and order 360.  The EGM2008 MODEL uses a 2.5-minute grid of
    /// point values in the tide-free system, using the EGM2008
    /// Geopotential Model to degree and order 2159. The geoid
    /// undulations for EGM96 and EGM2008 are with respect to the
    /// WGS84 ellipsoid. 
    /// DATAFILE :a mat-file containing an array of geocentric
    /// latitude breakpoints, 'latbp', an array of geocentric
    /// longitude breakpoints, 'lonbp', a table of geoid height
    /// values,'grid' and a even integer scalar greater than 2 for
    /// number of interpolation points, 'windowSize'.  This is only
    /// needed for a 'Custom' geopotential model.     
    /// ACTION   :a string to determine action for out of range latitude or
    /// longitude. Specify if out of range input invokes a 'Warning',
    /// 'Error', or no action ('None'). The default is 'Warning'.
    /// Output for GEOIDHEIGHT is:
    /// N        :an array of M geoid heights in meters with the same data type
    /// as the input LAT.
    /// Limitations:
    /// This function using the 'EGM96' MODEL has the limitations of the 1996
    /// Earth Geopotential Model.  For more information see the documentation.
    /// The WGS84 EGM96 geoid undulations have an error range of +/- 0.5 to
    /// +/- 1.0 meters worldwide.
    /// This function using the 'EGM2008' MODEL has the limitations of the 2008
    /// Earth Geopotential Model.  For more information see the documentation.
    /// Examples:
    /// Calculate the EGM96 geoid height at 42.4 degrees N latitude and 71.0 degrees 
    /// W longitude with warning actions:
    /// N = geoidheight( 42.4, -71.0 )
    /// Calculate the EGM2008 geoid height at two different locations with
    /// error actions.
    /// N = geoidheight( [39.3, 33.4], [77.2, 36.5], 'egm2008','error')
    /// Calculate a custom geoid height at two different locations with
    /// no actions.
    /// N = geoidheight( [39.3, 33.4], [-77.2, 36.5], 'custom', ...
    /// 'geoidegm96grid','none')
    /// Note: This function uses geoid data that can be obtained using the
    /// aeroDataPackage command.
    /// See also GRAVITYWGS84, GRAVITYSPHERICALHARMONIC
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="lat">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] geoid_height(int numArgsOut, MWArray lat)
    {
      return mcr.EvaluateFunction(numArgsOut, "geoid_height", lat);
    }


    /// <summary>
    /// Provides the standard 2-input MWArray interface to the geoid_height MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// GEOIDHEIGHT Implement a geopotential model to calculate geoid height
    /// N = GEOIDHEIGHT( LAT, LON, MODEL ) calculates the geoid height as
    /// determined from a selected geopotential model, MODEL. An array of M
    /// geoid heights, N, are interpolated at M geocentric latitude, LAT, and M
    /// geocentric longitude, LON, from a grid of point values in the tide-free
    /// system, using the selected geopotential model, MODEL.  
    /// The GEOIDHEIGHT function calculates geoid heights to 0.01 meters for
    /// EGM96 and custom.  The GEOIDHEIGHT function calculates geoid heights to
    /// 0.001 meters for EGM2008.
    /// The interpolation scheme wraps over the poles to allow for geoid height
    /// calculations at and near these locations.
    /// Alternate formats for calling geoid height are:
    /// N = GEOIDHEIGHT( LAT, LON )
    /// N = GEOIDHEIGHT( LAT, LON, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, MODEL, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE, ACTION )
    /// Inputs for GEOIDHEIGHT are:
    /// LAT      :an array of M geocentric latitudes in degrees where north
    /// latitude is positive, and south latitude is negative. LAT
    /// must be of type single or double. If LAT is not in the range
    /// of [-90,90] it is wrapped to be within the range.
    /// LON      :an array of M geocentric longitude in degrees where east
    /// longitude is positive, west is negative. LON must be of type
    /// single or double. If LON is not in the range of [0,360] it is
    /// wrapped to be within the range.
    /// MODEL    :a string specifying the geopotential model: 'EGM2008' (Earth),
    /// 'EGM96' (Earth), or 'Custom'.  The default is 'EGM96'.  
    /// 'EGM96' uses a 15-minute grid of point values in the
    /// tide-free system, using EGM96 Geopotential Model to degree
    /// and order 360.  The EGM2008 MODEL uses a 2.5-minute grid of
    /// point values in the tide-free system, using the EGM2008
    /// Geopotential Model to degree and order 2159. The geoid
    /// undulations for EGM96 and EGM2008 are with respect to the
    /// WGS84 ellipsoid. 
    /// DATAFILE :a mat-file containing an array of geocentric
    /// latitude breakpoints, 'latbp', an array of geocentric
    /// longitude breakpoints, 'lonbp', a table of geoid height
    /// values,'grid' and a even integer scalar greater than 2 for
    /// number of interpolation points, 'windowSize'.  This is only
    /// needed for a 'Custom' geopotential model.     
    /// ACTION   :a string to determine action for out of range latitude or
    /// longitude. Specify if out of range input invokes a 'Warning',
    /// 'Error', or no action ('None'). The default is 'Warning'.
    /// Output for GEOIDHEIGHT is:
    /// N        :an array of M geoid heights in meters with the same data type
    /// as the input LAT.
    /// Limitations:
    /// This function using the 'EGM96' MODEL has the limitations of the 1996
    /// Earth Geopotential Model.  For more information see the documentation.
    /// The WGS84 EGM96 geoid undulations have an error range of +/- 0.5 to
    /// +/- 1.0 meters worldwide.
    /// This function using the 'EGM2008' MODEL has the limitations of the 2008
    /// Earth Geopotential Model.  For more information see the documentation.
    /// Examples:
    /// Calculate the EGM96 geoid height at 42.4 degrees N latitude and 71.0 degrees 
    /// W longitude with warning actions:
    /// N = geoidheight( 42.4, -71.0 )
    /// Calculate the EGM2008 geoid height at two different locations with
    /// error actions.
    /// N = geoidheight( [39.3, 33.4], [77.2, 36.5], 'egm2008','error')
    /// Calculate a custom geoid height at two different locations with
    /// no actions.
    /// N = geoidheight( [39.3, 33.4], [-77.2, 36.5], 'custom', ...
    /// 'geoidegm96grid','none')
    /// Note: This function uses geoid data that can be obtained using the
    /// aeroDataPackage command.
    /// See also GRAVITYWGS84, GRAVITYSPHERICALHARMONIC
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="lat">Input argument #1</param>
    /// <param name="lon">Input argument #2</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] geoid_height(int numArgsOut, MWArray lat, MWArray lon)
    {
      return mcr.EvaluateFunction(numArgsOut, "geoid_height", lat, lon);
    }


    /// <summary>
    /// Provides the standard 3-input MWArray interface to the geoid_height MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// GEOIDHEIGHT Implement a geopotential model to calculate geoid height
    /// N = GEOIDHEIGHT( LAT, LON, MODEL ) calculates the geoid height as
    /// determined from a selected geopotential model, MODEL. An array of M
    /// geoid heights, N, are interpolated at M geocentric latitude, LAT, and M
    /// geocentric longitude, LON, from a grid of point values in the tide-free
    /// system, using the selected geopotential model, MODEL.  
    /// The GEOIDHEIGHT function calculates geoid heights to 0.01 meters for
    /// EGM96 and custom.  The GEOIDHEIGHT function calculates geoid heights to
    /// 0.001 meters for EGM2008.
    /// The interpolation scheme wraps over the poles to allow for geoid height
    /// calculations at and near these locations.
    /// Alternate formats for calling geoid height are:
    /// N = GEOIDHEIGHT( LAT, LON )
    /// N = GEOIDHEIGHT( LAT, LON, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, MODEL, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE, ACTION )
    /// Inputs for GEOIDHEIGHT are:
    /// LAT      :an array of M geocentric latitudes in degrees where north
    /// latitude is positive, and south latitude is negative. LAT
    /// must be of type single or double. If LAT is not in the range
    /// of [-90,90] it is wrapped to be within the range.
    /// LON      :an array of M geocentric longitude in degrees where east
    /// longitude is positive, west is negative. LON must be of type
    /// single or double. If LON is not in the range of [0,360] it is
    /// wrapped to be within the range.
    /// MODEL    :a string specifying the geopotential model: 'EGM2008' (Earth),
    /// 'EGM96' (Earth), or 'Custom'.  The default is 'EGM96'.  
    /// 'EGM96' uses a 15-minute grid of point values in the
    /// tide-free system, using EGM96 Geopotential Model to degree
    /// and order 360.  The EGM2008 MODEL uses a 2.5-minute grid of
    /// point values in the tide-free system, using the EGM2008
    /// Geopotential Model to degree and order 2159. The geoid
    /// undulations for EGM96 and EGM2008 are with respect to the
    /// WGS84 ellipsoid. 
    /// DATAFILE :a mat-file containing an array of geocentric
    /// latitude breakpoints, 'latbp', an array of geocentric
    /// longitude breakpoints, 'lonbp', a table of geoid height
    /// values,'grid' and a even integer scalar greater than 2 for
    /// number of interpolation points, 'windowSize'.  This is only
    /// needed for a 'Custom' geopotential model.     
    /// ACTION   :a string to determine action for out of range latitude or
    /// longitude. Specify if out of range input invokes a 'Warning',
    /// 'Error', or no action ('None'). The default is 'Warning'.
    /// Output for GEOIDHEIGHT is:
    /// N        :an array of M geoid heights in meters with the same data type
    /// as the input LAT.
    /// Limitations:
    /// This function using the 'EGM96' MODEL has the limitations of the 1996
    /// Earth Geopotential Model.  For more information see the documentation.
    /// The WGS84 EGM96 geoid undulations have an error range of +/- 0.5 to
    /// +/- 1.0 meters worldwide.
    /// This function using the 'EGM2008' MODEL has the limitations of the 2008
    /// Earth Geopotential Model.  For more information see the documentation.
    /// Examples:
    /// Calculate the EGM96 geoid height at 42.4 degrees N latitude and 71.0 degrees 
    /// W longitude with warning actions:
    /// N = geoidheight( 42.4, -71.0 )
    /// Calculate the EGM2008 geoid height at two different locations with
    /// error actions.
    /// N = geoidheight( [39.3, 33.4], [77.2, 36.5], 'egm2008','error')
    /// Calculate a custom geoid height at two different locations with
    /// no actions.
    /// N = geoidheight( [39.3, 33.4], [-77.2, 36.5], 'custom', ...
    /// 'geoidegm96grid','none')
    /// Note: This function uses geoid data that can be obtained using the
    /// aeroDataPackage command.
    /// See also GRAVITYWGS84, GRAVITYSPHERICALHARMONIC
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="lat">Input argument #1</param>
    /// <param name="lon">Input argument #2</param>
    /// <param name="varargin">Array of MWArrays representing the input arguments 3
    /// through varargin.length+2</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] geoid_height(int numArgsOut, MWArray lat, MWArray lon, params 
                            MWArray[] varargin)
    {
      MWArray[] args = {lat, lon};
      int nonVarargInputNum = args.Length;
      int varargInputNum = varargin.Length;
      int totalNumArgs = varargInputNum > 0 ? (nonVarargInputNum + varargInputNum) : nonVarargInputNum;
      Array newArr = Array.CreateInstance(typeof(MWArray), totalNumArgs);

      int idx = 0;

      for (idx = 0; idx < nonVarargInputNum; idx++)
        newArr.SetValue(args[idx],idx);

      if (varargInputNum > 0)
      {
        for (int i = 0; i < varargInputNum; i++)
        {
          newArr.SetValue(varargin[i], idx);
          idx++;
        }
      }

      return mcr.EvaluateFunction(numArgsOut, "geoid_height", (MWArray[])newArr );
    }


    /// <summary>
    /// Provides an interface for the geoid_height function in which the input and output
    /// arguments are specified as an array of MWArrays.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// GEOIDHEIGHT Implement a geopotential model to calculate geoid height
    /// N = GEOIDHEIGHT( LAT, LON, MODEL ) calculates the geoid height as
    /// determined from a selected geopotential model, MODEL. An array of M
    /// geoid heights, N, are interpolated at M geocentric latitude, LAT, and M
    /// geocentric longitude, LON, from a grid of point values in the tide-free
    /// system, using the selected geopotential model, MODEL.  
    /// The GEOIDHEIGHT function calculates geoid heights to 0.01 meters for
    /// EGM96 and custom.  The GEOIDHEIGHT function calculates geoid heights to
    /// 0.001 meters for EGM2008.
    /// The interpolation scheme wraps over the poles to allow for geoid height
    /// calculations at and near these locations.
    /// Alternate formats for calling geoid height are:
    /// N = GEOIDHEIGHT( LAT, LON )
    /// N = GEOIDHEIGHT( LAT, LON, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, MODEL, ACTION )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE )
    /// N = GEOIDHEIGHT( LAT, LON, 'Custom', DATAFILE, ACTION )
    /// Inputs for GEOIDHEIGHT are:
    /// LAT      :an array of M geocentric latitudes in degrees where north
    /// latitude is positive, and south latitude is negative. LAT
    /// must be of type single or double. If LAT is not in the range
    /// of [-90,90] it is wrapped to be within the range.
    /// LON      :an array of M geocentric longitude in degrees where east
    /// longitude is positive, west is negative. LON must be of type
    /// single or double. If LON is not in the range of [0,360] it is
    /// wrapped to be within the range.
    /// MODEL    :a string specifying the geopotential model: 'EGM2008' (Earth),
    /// 'EGM96' (Earth), or 'Custom'.  The default is 'EGM96'.  
    /// 'EGM96' uses a 15-minute grid of point values in the
    /// tide-free system, using EGM96 Geopotential Model to degree
    /// and order 360.  The EGM2008 MODEL uses a 2.5-minute grid of
    /// point values in the tide-free system, using the EGM2008
    /// Geopotential Model to degree and order 2159. The geoid
    /// undulations for EGM96 and EGM2008 are with respect to the
    /// WGS84 ellipsoid. 
    /// DATAFILE :a mat-file containing an array of geocentric
    /// latitude breakpoints, 'latbp', an array of geocentric
    /// longitude breakpoints, 'lonbp', a table of geoid height
    /// values,'grid' and a even integer scalar greater than 2 for
    /// number of interpolation points, 'windowSize'.  This is only
    /// needed for a 'Custom' geopotential model.     
    /// ACTION   :a string to determine action for out of range latitude or
    /// longitude. Specify if out of range input invokes a 'Warning',
    /// 'Error', or no action ('None'). The default is 'Warning'.
    /// Output for GEOIDHEIGHT is:
    /// N        :an array of M geoid heights in meters with the same data type
    /// as the input LAT.
    /// Limitations:
    /// This function using the 'EGM96' MODEL has the limitations of the 1996
    /// Earth Geopotential Model.  For more information see the documentation.
    /// The WGS84 EGM96 geoid undulations have an error range of +/- 0.5 to
    /// +/- 1.0 meters worldwide.
    /// This function using the 'EGM2008' MODEL has the limitations of the 2008
    /// Earth Geopotential Model.  For more information see the documentation.
    /// Examples:
    /// Calculate the EGM96 geoid height at 42.4 degrees N latitude and 71.0 degrees 
    /// W longitude with warning actions:
    /// N = geoidheight( 42.4, -71.0 )
    /// Calculate the EGM2008 geoid height at two different locations with
    /// error actions.
    /// N = geoidheight( [39.3, 33.4], [77.2, 36.5], 'egm2008','error')
    /// Calculate a custom geoid height at two different locations with
    /// no actions.
    /// N = geoidheight( [39.3, 33.4], [-77.2, 36.5], 'custom', ...
    /// 'geoidegm96grid','none')
    /// Note: This function uses geoid data that can be obtained using the
    /// aeroDataPackage command.
    /// See also GRAVITYWGS84, GRAVITYSPHERICALHARMONIC
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of MWArray output arguments</param>
    /// <param name= "argsIn">Array of MWArray input arguments</param>
    ///
    public void geoid_height(int numArgsOut, ref MWArray[] argsOut, MWArray[] argsIn)
    {
      mcr.EvaluateFunction("geoid_height", numArgsOut, ref argsOut, argsIn);
    }



    /// <summary>
    /// This method will cause a MATLAB figure window to behave as a modal dialog box.
    /// The method will not return until all the figure windows associated with this
    /// component have been closed.
    /// </summary>
    /// <remarks>
    /// An application should only call this method when required to keep the
    /// MATLAB figure window from disappearing.  Other techniques, such as calling
    /// Console.ReadLine() from the application should be considered where
    /// possible.</remarks>
    ///
    public void WaitForFiguresToDie()
    {
      mcr.WaitForFiguresToDie();
    }



    #endregion Methods

    #region Class Members

    private static MWMCR mcr= null;

    private static Exception ex_= null;

    private bool disposed= false;

    #endregion Class Members
  }
}
