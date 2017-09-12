# ExternalDependencies

This is part of the native toolchain for Linux. 
The Ubuntu Toolchains from http://www2.informatik.hu-berlin.de/~naoth/ressources/toolchains/ are
currently not up to date. The files in this Repository have to replace the ones downloaded.  
  
The whole Linux Toolchain setup is about to change at the end of 2017.  


## Changelog
Version 0.5  
GCC Version 4.9.3  
Visual Studio 2013  

= Changes from 0.4 =  
 - fixed typo in protobuf version in last changelog  
 - recompiled protobuf with Visual Studio 2013 - only replace protoc.exe and protobuf.lib   
   the protobuf-lite.lib is not yet replaced  
 - compiled premake4 repo as it was on 2016-09-05 and used that binary  
   not need to change our premake files  
 - for adding mintty to the windows context menu you need the cygwin chere package  
   
   = Note: Flags needed for compiling OpenCV for Windows =  
        WITH_VTK:BOOL=0  
        BUILD_OPENEXR:BOOL=0  
        OPENCV_HAL_HEADERS:STRING=  
        BUILD_opencv_world:BOOL=0  
        BUILD_DOCS:BOOL=0  
        OPENCL_FOUND:BOOL=0  
        CMAKE_BUILD_TYPE:STRING=Debug  
        BUILD_opencv_ts:BOOL=0  
        BUILD_PERF_TESTS:BOOL=0  
        WITH_OPENCLAMDFFT:BOOL=0  
        WITH_CUDA:BOOL=0  
        WITH_MATLAB:BOOL=0  
        WITH_OPENEXR:BOOL=0  
        WITH_IPP:BOOL=0  
        WITH_OPENCL:BOOL=0  
        WITH_OPENCLAMDBLAS:BOOL=0  
        OPENCV_HAL_LIBS:STRING=  
        BUILD_PACKAGE:BOOL=1  
        BUILD_TESTS:BOOL=0  
        WITH_EIGEN:BOOL=0  
        WITH_CUFFT:BOOL=0   
   
 
= Changes from 0.3 =  
 - switched to the GCC 4.9.3 for the crosscompiler tool chain  
 - removed the gmoc and gtest libs  
 - updated to protobuf 2.6.1  
 - updated to opencv 3.1.0  
 
= Changes from 0.2 =  
 - compiled the OpenCV for windows, which fixes some crashes caused by OpenCV  
 - added the Eigen 3.2 library  

= Changes from 0.1 =
 - added toolchain_native/extern/readme.txt with a list of lib-versions  
 - removed toolchain_native/lib_release  
 - replaced toolchain_native/extern/protobuf.lib with a release version which doesn't require a *.pdb file (which caused some warnings)  
