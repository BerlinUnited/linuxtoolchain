#!/bin/bash

# stop at the first error
set -e

# current path is toolchain_native/extern/extracted

if [ "$EXTERN_DIR" == "" ]; then
  echo ".::ERROR::. enviroment variable EXTERN_DIR was not set"
  echo ".::ERROR::. will exit"
  exit -1
fi

if [ "$1" = "check" ]; then
  if [ -f "/usr/include/fftw3.h" -o -f "$EXTERN_DIR/include/fftw3.h" ]; then
    echo "n"
    exit 0
  else
    echo "y" 
    exit 1
  fi
elif [ "$1" = "install" ]; then
  rm -Rf fftw-3.3.5
  tar xvzf ../downloads/fftw-3.3.5.tar.gz
  cd fftw-3.3.5
  ./configure --prefix="$EXTERN_DIR" && make && make install
  cd ..  

  # move fftw headerfiles in separate folder as the naoth code expects
  cd ../include
  mkdir -p fftw3
  mv fftw3.h  fftw3/fftw3.h
  mv fftw3.f03 fftw3/fftw3.f03
  mv fftw3.f fftw3/fftw3.f
  mv fftw3l.f03 fftw3/fftw3l.f03
  mv fftw3q.f03 fftw3/fftw3q.f03
  cd ../extracted
fi
