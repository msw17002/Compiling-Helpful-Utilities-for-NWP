#!/bin/bash

#compile w/png

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
export cdo=libs4cdo-0.0.11

echo "==============================================================================="
echo "===================CREATING DIRECTORY STRUCTURE================================"
#===Set directory structure
#-  apps directory
if [ -d "$DIR" ]; then
   echo "$DIR already exists!"
else
   echo 'mkdir $DIR'
   sleep 5
   mkdir $DIR
fi
sleep 5

echo "==============================================================================="
echo "=======================DOWNLOADING SOURCE CODE===================================="
#===conditionally download dependancies
#-  zlib source code
if [ -f "$HOME/libs4cdo-0.0.11.tar.gz" ]; then
    echo "$HOME/libs4cdo-0.0.11.tar.gz already exists!"
else
    echo 'wget -q 'https://code.mpimet.mpg.de/attachments/download/10301/libs4cdo-0.0.11.tar.gz' -O $HOME/libs4cdo-0.0.11.tar.gz'
    sleep $DT
    wget -q 'https://code.mpimet.mpg.de/attachments/download/10301/libs4cdo-0.0.11.tar.gz' -O $HOME/libs4cdo-0.0.11.tar.gz
fi
#-uncompress file
echo 'tar -xvzf $HOME/libs4cdo-0.0.11.tar.gz'
tar -xvzf $HOME/libs4cdo-0.0.11.tar.gz
#-copy libpng into libs4cdo 
#-  libpng source code
if [ -d "$HOME/libs4cdo-0.0.11/libpng" ]; then
    echo "$HOME/libs4cdo-0.0.11/libpng already exists!"
else
    cd $HOME/libs4cdo-0.0.11/
    git clone https://github.com/glennrp/libpng.git
    cd $HOME
    sleep 5
fi

echo "==============================================================================="
echo "==========================COMPILING ZLIB======================================="
echo 'cd $HOME/libs4cdo-0.0.11/zlib-1.2.3/'
echo './configure --prefix=$DIR --shared'
echo "make"
echo "make install"
echo "==============================================================================="
sleep 5
#===compile zlib
cd $HOME/libs4cdo-0.0.11/zlib-1.2.3/
./configure --prefix=$DIR --shared 
make
make install
echo "==============================================================================="
echo "==========================COMPILING SZIP======================================="
echo 'cd $HOME/libs4cdo-0.0.11/szip-2.1/'
echo './configure --prefix=$DIR'
echo "make"
echo "make install"
echo "==============================================================================="
sleep 5
#===compile szip
cd $HOME/libs4cdo-0.0.11/szip-2.1/
./configure --prefix=$DIR
make 
make install
echo "==============================================================================="
echo "==========================COMPILING JASPER======================================="
echo 'cd $HOME/libs4cdo-0.0.11/jasper-1.900.1/'
echo './configure --prefix=$DIR --enable-shared --with-pic'
echo "make"
echo "make install"
echo "==============================================================================="
sleep 5
#===compile jasper
cd $HOME/libs4cdo-0.0.11/jasper-1.900.1/
./configure --prefix=$DIR --enable-shared --with-pic
make
make install
echo "==============================================================================="
echo "==========================COMPILING PROJ======================================="
echo 'cd $HOME/libs4cdo-0.0.11/proj-4.8.0/'
echo './configure --prefix=$DIR --without-mutex --without-jni'
echo "make"
echo "make install"
echo "==============================================================================="
sleep 5
#===compile proj 
cd $HOME/libs4cdo-0.0.11/proj-4.8.0/
./configure --prefix=$DIR --without-mutex --without-jni
make 
make install
echo "==============================================================================="
echo "==========================COMPILING HDF5======================================="
echo 'cd $HOME/libs4cdo-0.0.11/hdf5-1.8.15/'
echo './configure --prefix=$DIR --with-zlib=$DIR'
echo "make"
echo "make install"
echo "==============================================================================="
sleep 5
#===compile proj
cd ../hdf5-1.8.15/
./configure --prefix=$DIR --with-zlib=$DIR
make 
make install
echo "==============================================================================="
echo "==========================COMPILING NETCDF-C======================================="
echo 'cd $HOME/libs4cdo-0.0.11/netcdf-3.6.3/'
echo './configure --prefix=$DIR --enable-c-only --enable-shared'
echo "make"
echo "make install"
echo "==============================================================================="
sleep 5
#===compile netcdf-c
cd $HOME/libs4cdo-0.0.11/netcdf-3.6.3/
./configure --prefix=$DIR --enable-c-only --enable-shared
make 
make install
echo "==============================================================================="
echo "==========================COMPILING NETCDF-FORTRAN======================================="
echo 'cd $HOME/libs4cdo-0.0.11/netcdf-4.3.3.1/'
echo 'CPPFLAGS=-I$DIR/include LDFLAGS=-L$DIR/lib ./configure --prefix=$DIR --enable-shared --enable-netcdf-4 --with-pic --disable-doxygen'
echo "make"
echo "make install"
echo "==============================================================================="
sleep 5
#===compile netcdf-fortran
cd $HOME/libs4cdo-0.0.11/netcdf-4.3.3.1/
CPPFLAGS=-I$DIR/include LDFLAGS=-L$DIR/lib ./configure --prefix=$DIR --enable-shared --enable-netcdf-4 --with-pic --disable-doxygen
make
make install
echo "==============================================================================="
echo "==========================GRIB-API======================================="
echo 'cd $HOME/libs4cdo-0.0.11/grib_api-1.13.1/'
echo 'autoreconf -ivf'
echo 'CFLAGS='-DPIC -fPIC' ./configure --prefix=$DIR --with-jasper=$DIR'
echo "make"
echo "make install"
echo "==============================================================================="
sleep 5
#===compile netcdf-fortran
cd $HOME/libs4cdo-0.0.11/grib_api-1.13.1/
autoreconf -ivf
CFLAGS='-DPIC -fPIC' ./configure --prefix=$DIR --with-jasper=$DIR
make 
make install
echo "==============================================================================="
echo "==========================LIBPNG======================================="
echo 'cd $HOME/libs4cdo-0.0.11/libpng/'
echo './configure --prefix=$DIR'
echo "make"
echo "make install"
echo "==============================================================================="
sleep 5
#===compile netcdf-fortran
cd $HOME/libs4cdo-0.0.11/libpng/
./configure --prefix=$DIR
make
make install



#./configure --prefix=$CDODIR --with-netcdf=$CDODIR --with-hdf5=$CDODIR --with-grib_api=$CDODIR --with-proj=$CDODIR
