#!/bin/bash

module purge

echo "==============================================================================="
echo "=======================EXPORTING PATHS===================================="
echo 'export HOME=$(pwd)'
echo 'export DIR=${HOME}/build'
echo 'export PATH=$DIR/bin:$PATH'
echo 'export LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH'
echo 'export CPPFLAGS=-I$DIR/include'
echo 'export LDFLAGS=-L$DIR/lib'
sleep 5
export HOME=$(pwd)
export DIR=${HOME}/build 
export PATH=$DIR/bin:$PATH
export LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH
export CPPFLAGS=-I$DIR/include
export LDFLAGS=-L$DIR/lib
echo "==============================================================================="
echo "=======================EXPORTING PARAMETERS===================================="
echo "export CC=gcc"
echo "export CXX=g++"
echo "export FC=gfortran"
echo "export F77=gfortran"
echo "export cdo=libs4cdo-0.0.11"
sleep 5
export CC=gcc
export CXX=g++
export FC=gfortran
export F77=gfortran
export cdo=cdo-1.8.2

echo "==============================================================================="
echo "=======================DOWNLOADING SOURCE CODE===================================="
if [ -f "$HOME/$cdo.tar.gz" ]; then
    echo "$HOME/$cdo.tar.gz already exists!"
else
    echo 'wget -q 'https://code.mpimet.mpg.de/attachments/download/14686/{cdo}.tar.gz' -O $HOME/$cdo.tar.gz'
    sleep 5
    wget -q "https://code.mpimet.mpg.de/attachments/download/14686/${cdo}.tar.gz" -O $HOME/${cdo}.tar.gz
fi
sleep 5
echo "==============================================================================="
echo "=======================COMPILING===================================="
echo 'tar -xvzf $cdo.tar.gz'
echo 'cd $cdo'
echo './configure --prefix=$DIR --with-netcdf=$DIR --with-hdf5=$DIR --with-grib_api=$DIR --with-proj=$DIR'
echo "make"
echo "make install"
sleep 5
tar -xvzf $cdo.tar.gz
cd $cdo
./configure --prefix=$DIR --with-netcdf=$DIR --with-hdf5=$DIR --with-grib_api=$DIR --with-proj=$DIR
#make
#make install
