#!/bin/bash

# stop at the first error
set -e

if [ "$EXTERN_DIR" == "" ]; then
  echo ".::ERROR::. enviroment variable EXTERN_DIR was not set"
  echo ".::ERROR::. will exit"
  exit -1
fi

#if [ "$1" = "check" ]; then
  #if [ -f "/usr/include/fftw3.h" -o -f "$EXTERN_DIR/include/fftw3.h" ]; then
  #  echo "n"
  #  exit 0
  #else
  #  echo "y" 
  #  exit 1
  #fi
#elif [ "$1" = "install" ]; then
if [ "$1" = "install" ]; then
  #rm -Rf fftw-3.3.5
  tar xvzf ../downloads/premake-5.0.0-alpha12.tar.gz
  cd premake-5.0.0-alpha12/build/gmake.unix
  make Premake5
  cp ../../bin/release/premake5 $EXTERN_DIR/bin
  cd ..  
fi
