//
// MATLAB Compiler: 6.0 (R2015a)
// Date: Mon Jan 04 01:36:49 2016
// Arguments: "-B" "macro_default" "-W" "cpplib:geoid_height" "-T" "link:lib"
// "-d" "C:\Users\mohamed\Desktop\Graduation Project\Source
// Code\geoid_height\for_testing" "-v" "C:\Users\mohamed\Desktop\Graduation
// Project\Source Code\geoid_height.m" 
//

#ifndef __geoid_height_h
#define __geoid_height_h 1

#if defined(__cplusplus) && !defined(mclmcrrt_h) && defined(__linux__)
#  pragma implementation "mclmcrrt.h"
#endif
#include "mclmcrrt.h"
#include "mclcppclass.h"
#ifdef __cplusplus
extern "C" {
#endif

#if defined(__SUNPRO_CC)
/* Solaris shared libraries use __global, rather than mapfiles
 * to define the API exported from a shared library. __global is
 * only necessary when building the library -- files including
 * this header file to use the library do not need the __global
 * declaration; hence the EXPORTING_<library> logic.
 */

#ifdef EXPORTING_geoid_height
#define PUBLIC_geoid_height_C_API __global
#else
#define PUBLIC_geoid_height_C_API /* No import statement needed. */
#endif

#define LIB_geoid_height_C_API PUBLIC_geoid_height_C_API

#elif defined(_HPUX_SOURCE)

#ifdef EXPORTING_geoid_height
#define PUBLIC_geoid_height_C_API __declspec(dllexport)
#else
#define PUBLIC_geoid_height_C_API __declspec(dllimport)
#endif

#define LIB_geoid_height_C_API PUBLIC_geoid_height_C_API


#else

#define LIB_geoid_height_C_API

#endif

/* This symbol is defined in shared libraries. Define it here
 * (to nothing) in case this isn't a shared library. 
 */
#ifndef LIB_geoid_height_C_API 
#define LIB_geoid_height_C_API /* No special import/export declaration */
#endif

extern LIB_geoid_height_C_API 
bool MW_CALL_CONV geoid_heightInitializeWithHandlers(
       mclOutputHandlerFcn error_handler, 
       mclOutputHandlerFcn print_handler);

extern LIB_geoid_height_C_API 
bool MW_CALL_CONV geoid_heightInitialize(void);

extern LIB_geoid_height_C_API 
void MW_CALL_CONV geoid_heightTerminate(void);



extern LIB_geoid_height_C_API 
void MW_CALL_CONV geoid_heightPrintStackTrace(void);

extern LIB_geoid_height_C_API 
bool MW_CALL_CONV mlxGeoid_height(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[]);


#ifdef __cplusplus
}
#endif

#ifdef __cplusplus

/* On Windows, use __declspec to control the exported API */
#if defined(_MSC_VER) || defined(__BORLANDC__)

#ifdef EXPORTING_geoid_height
#define PUBLIC_geoid_height_CPP_API __declspec(dllexport)
#else
#define PUBLIC_geoid_height_CPP_API __declspec(dllimport)
#endif

#define LIB_geoid_height_CPP_API PUBLIC_geoid_height_CPP_API

#else

#if !defined(LIB_geoid_height_CPP_API)
#if defined(LIB_geoid_height_C_API)
#define LIB_geoid_height_CPP_API LIB_geoid_height_C_API
#else
#define LIB_geoid_height_CPP_API /* empty! */ 
#endif
#endif

#endif

extern LIB_geoid_height_CPP_API void MW_CALL_CONV geoid_height(int nargout, mwArray& N, const mwArray& lat, const mwArray& lon, const mwArray& varargin);

#endif
#endif
