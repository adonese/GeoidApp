MATLAB .NET Assembly (.NET Component)


1. Prerequisites for Deployment 

. Verify the MATLAB runtime is installed and ensure you
  have installed version 8.5 (R2015a).   

. If the MATLAB runtime is not installed, do the following:
  (1) enter
  
      >>mcrinstaller
      
      at MATLAB prompt. The MCRINSTALLER command displays the 
      location of the MATLAB runtime installer.

  (2) run the MATLAB runtime installer.

Or download the Windows 64-bit version of the MATLAB runtime for R2015a 
from the MathWorks Web site by navigating to

   http://www.mathworks.com/products/compiler/mcr/index.html
   

For more information about the MATLAB runtime and the MATLAB runtime installer, see 
Package and Distribute in the MATLAB Compiler SDK documentation  
in the MathWorks Documentation Center.  
      
NOTE: You will need administrator rights to run MCRInstaller.

2. Files to Deploy and Package

-geoid_height.dll
   -contains the generated component using MWArray API. 
-geoid_heightNative.dll
   -contains the generated component using native API.
-This readme file

. If the target machine does not have the version 8.5 of the MATLAB runtime installed, 
  and the end users are unable to download the MATLAB runtime using the above link, 
  include MCRInstaller.exe.



Auto-generated Documentation Templates:

MWArray.xml - This file contains the code comments for the MWArray data conversion 
              classes and their methods. This file can be found in either the component 
              distrib directory or in
              <mcr_root>*\toolbox\dotnetbuilder\bin\win64\v2.0

geoid_height_overview.html - HTML overview documentation file for the generated 
                             component. It contains the requirements for accessing the 
                             component and for generating arguments using the MWArray 
                             class hierarchy.

geoid_height.xml - This file contains the code comments for the geoid_height component 
                             classes and methods. Using a third party documentation tool, 
                             this file can be combined with either or both of the 
                             previous files to generate online documentation for the 
                             geoid_height component.

                 


3. Resources

To learn more about:               See:
===================================================================
MWArray classes                    <matlab_root>*\help\toolbox\
                                   dotnetbuilder\MWArrayAPI\
                                   MWArrayAPI.chm  
Examples of .NET Web Applications  Web Deployment in the MATLAB   
                                   .NET Assembly documentation in the  
                                   MathWorks Documentation Center


4. Definitions

For information on deployment terminology, go to 
http://www.mathworks.com/help. Select MATLAB Compiler >   
Getting Started > About Application Deployment > 
Application Deployment Terms in the MathWorks Documentation 
Center.



* NOTE: <mcr_root> is the directory where the MATLAB runtime is installed on the target 
        machine.
        <matlab_root> is the directory where MATLAB is installed on the target machine.

