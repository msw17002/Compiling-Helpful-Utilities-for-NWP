#!/bin/bash
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -p priority
#SBATCH --qos=stormlab
##SBATCH --time=02:00:00                               # Job should run for 10 hours


#===Parameters
echo "==============================================================================="
echo "=======================EXPORTING PARAMETERS===================================="
echo 'export HOME=$(pwd)'
echo 'export DIR=${HOME}/apps/Library'
echo "export CC=gcc"
echo "export CXX=g++"
echo "export FC=gfortran"
echo "export F77=gfortran"
echo 'export apps=${HOME}/apps'
echo "export ZLIB=zlib-1.2.13"
echo "export HDF5=hdf5-1.12.2"
echo "export NTCC=netcdf-c-4.9.0"
echo "export NTCF=netcdf-fortran-4.6.0"
echo "export LIBP=libpng-1.6.40"
echo "export JASP=jasper-1.900.1"
echo "==============================================================================="
sleep 5
export HOME=$(pwd)
export DIR=${HOME}/apps/Library
export CC=gcc
export CXX=g++
export FC=gfortran
export F77=gfortran
export apps=${HOME}/apps
export ZLIB=zlib-1.2.13
export HDF5=hdf5-1.12.2
export NTCC=netcdf-c-4.9.0
export NTCF=netcdf-fortran-4.6.0
export LIBP=libpng-1.6.37
export JASP=jasper-1.900.1
export CMAK=cmake-3.28.0-rc1-linux-x86_64
export LAEC=libaec-1.1.2
export DT=5

echo "==============================================================================="
echo "===================CREATING DIRECTORY STRUCTURE================================"
#===Set directory structure
#-  apps directory
if [ -d "$HOME/apps" ]; then 
   echo "$HOME/apps already exists!"
else
   echo 'mkdir $HOME/apps'
   sleep 5 
   mkdir $HOME/apps
fi 
#-  Downloads directory
if [ -d "$HOME/apps/Downloads" ]; then
   echo "$HOME/apps/Downloads already exists!"
else
   echo 'mkdir $HOME/apps/Downloads'
   sleep 5
   mkdir $HOME/apps/Downloads
fi
#-  Library directory
if [ -d "$HOME/apps/Library" ]; then
   echo "$HOME/apps/Library already exists!"
else
   echo 'mkdir $HOME/apps/Library'
   sleep 5
   mkdir $HOME/apps/Library
fi
echo "==============================================================================="

echo "==============================================================================="
echo "===================DOWNLOADING SOURCE BINARIES ================================"
#===conditionally download dependancies
#-  zlib source code
if [ -f "$HOME/apps/Downloads/$CMAK.tar.gz" ]; then
    echo "$HOME/apps/Downloads/$CMAK.tar.gz already exists!"
else
    echo 'wget -q 'https://github.com/Kitware/CMake/releases/download/v3.28.0-rc1/$CMAK.tar.gz' -O $HOME/apps/Downloads/$CMAK.tar.gz'
    sleep $DT
    wget -q 'https://github.com/Kitware/CMake/releases/download/v3.28.0-rc1/${CMAK}.tar.gz' -O $HOME/apps/Downloads/${CMAK}.tar.gz
fi
#-  zlib source code
if [ -d "$HOME/apps/Downloads/zlib" ]; then
    echo "$HOME/apps/Downloads/zlib already exists!"
else
    cd $HOME/apps/Downloads/
    git clone https://github.com/madler/zlib.git
    cd $HOME
    sleep $DT
fi
#-  HDF5 source code
if [ -f "$HOME/apps/Downloads/$HDF5.tar.gz" ]; then
    echo "$HOME/apps/Downloads/$HDF5.tar.gz already exists!"
else
    echo "wget -q 'https://www.hdfgroup.org/package/hdf5-1-12-2-tar-gz/?wpdmdl=16474&amp;refresh=64d28450662021691518032' -O "'$HOME/apps/Downloads/$HDF5.tar.gz'
    sleep $DT
    wget -q 'https://www.hdfgroup.org/package/hdf5-1-12-2-tar-gz/?wpdmdl=16474&amp;refresh=64d28450662021691518032' -O $HOME/apps/Downloads/$HDF5.tar.gz
fi
#-  netcdf4-C source code
if [ -f "$HOME/apps/Downloads/$NTCC.tar.gz" ]; then
    echo "$HOME/apps/Downloads/$NTCC.tar.gz already exists!"
else
    echo 'wget -q 'https://github.com/Unidata/netcdf-c/archive/refs/tags/v4.9.0.tar.gz' -O $HOME/apps/Downloads/$NTCC.tar.gz'
    sleep $DT
    wget -q https://github.com/Unidata/netcdf-c/archive/refs/tags/v4.9.0.tar.gz -O $HOME/apps/Downloads/$NTCC.tar.gz
fi
#-  netcdf4-gfortran source code
if [ -f "$HOME/apps/Downloads/$NTCF.tar.gz" ]; then
    echo "$HOME/apps/Downloads/$NTCF.tar.gz already exists!"
else
    echo 'wget -q 'https://downloads.unidata.ucar.edu/netcdf-fortran/4.6.0/netcdf-fortran-4.6.0.tar.gz' -O $HOME/apps/Downloads/$NTCF.tar.gz'
    sleep $DT
    wget -q https://downloads.unidata.ucar.edu/netcdf-fortran/4.6.0/netcdf-fortran-4.6.0.tar.gz -O $HOME/apps/Downloads/$NTCF.tar.gz
fi
#-  libpng source code
if [ -d "$HOME/apps/Downloads/libpng" ]; then
    echo "$HOME/apps/Downloads/libpng already exists!"
else
    cd $HOME/apps/Downloads/
    git clone https://github.com/glennrp/libpng.git
    cd $HOME
    sleep $DT
fi
#-  jasp source code
if [ -f "$HOME/apps/Downloads/$JASP.zip" ]; then
    echo "$HOME/apps/Downloads/$JASP.zip has been pre-downloaded and is ready for compilation!"
else
    echo 'wget -q 'http://www.ece.uvic.ca/~mdadams/jasper/software/$JASP.zip' -O $HOME/apps/Downloads/$JASP.zip'
    sleep $DT
    wget -q 'http://www.ece.uvic.ca/~mdadams/jasper/software/jasper-1.900.1.zip' -O $HOME/apps/Downloads/$JASP.zip
fi
#-libaec source code 
if [ -f "$HOME/apps/Downloads/$LAEC.tar.gz" ]; then
    echo "$HOME/apps/Downloads/$LAEC.tar.gz has been pre-downloaded and is ready for compilation!"
else
    echo 'wget -q 'https://gitlab.dkrz.de/k202009/libaec/uploads/3847727cd2e8c941f0d68f6822a73ed7/libaec-1.1.2.tar.gz' -O $HOME/apps/Downloads/$LAEC.tar.gz'
    sleep $DT
    wget -q 'https://gitlab.dkrz.de/k202009/libaec/uploads/3847727cd2e8c941f0d68f6822a73ed7/libaec-1.1.2.tar.gz' -O $HOME/apps/Downloads/$LAEC.tar.gz 
fi



wget https://gitlab.dkrz.de/k202009/libaec/uploads/3847727cd2e8c941f0d68f6822a73ed7/libaec-1.1.2.tar.gz
##===downloading cmake
#echo "==============================================================================="
#echo "==========================DOWNLOADING CMAKE======================================="
#echo 'cd $HOME/apps/Downloads'
#echo 'tar -xvzf ${CMAK}.tar.gz'
#echo 'cd ${CMAK}/bin'
#echo 'ln -sf * $DIR/bin/'
#echo "==============================================================================="
##===cmake
#sleep $DT
#cd $HOME/apps/Downloads
#tar -xvzf $CMAK.tar.gz
#cd ${CMAK}/bin
#mkdir $DIR/bin/
#ln -sf ${CMAK}/bin/* $DIR/bin/
echo "==============================================================================="
echo "==========================COMPILING ZLIB======================================="
echo 'cd $HOME/apps/Downloads/zlib'
echo './configure --prefix=$DIR'
echo "make"
echo "make install"
echo "==============================================================================="
sleep $DT
#===compile zlib
cd $HOME/apps/Downloads/zlib
./configure --prefix=$DIR
make
make install
echo "==============================================================================="
echo "==========================COMPILING HDF5======================================="
echo 'cd $HOME/apps/Downloads'
echo 'tar -xvzf ${HDF5}.tar.gz'
echo 'cd ${HDF5}'
echo './configure --prefix=$DIR --with-zlib=$DIR --enable-hl --enable-fortran'
echo "make"
echo "make install"
echo "==============================================================================="
sleep $DT
#===compile hdf5 library for netcdf4 functionality
cd $HOME/apps/Downloads
tar -xvzf ${HDF5}.tar.gz
cd ${HDF5}
./configure --prefix=$DIR --with-zlib=$DIR --enable-hl --enable-fortran
make
make check
make install
export HDF5=$DIR
export LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH
echo "==============================================================================="
echo "========================COMPILING NETCDF4-C===================================="
echo 'export HDF5=$DIR'
echo 'export LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH'
echo 'cd $HOME/apps/Downloads'
echo 'tar -xvzf ${NTCC}.tar.gz'
echo 'cd ${NTCC}/'
echo 'export CPPFLAGS=-I$DIR/include'
echo 'export LDFLAGS=-L$DIR/lib'
echo './configure --prefix=$DIR --disable-dap'
echo "make"
echo "make install"
echo "==============================================================================="
sleep $DT
#===compile netcdf4-C library
cd $HOME/apps/Downloads
tar -xvzf ${NTCC}.tar.gz
cd ${NTCC}/
export CPPFLAGS=-I$DIR/include 
export LDFLAGS=-L$DIR/lib
./configure --prefix=$DIR --disable-dap
make
make install
export PATH=$DIR/bin:$PATH
export NETCDF=$DIR
echo "==============================================================================="
echo "========================COMPILING NETCDF4-fortran=============================="
echo 'export PATH=$DIR/bin:$PATH'
echo 'export NETCDF=$DIR'
echo 'cd $HOME/apps/Downloads'
echo 'tar -xvzf ${NTCF}.tar.gz'
echo 'cd ${NTCF}/'
echo 'export LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH'
echo 'export CPPFLAGS=-I$DIR/include'
echo 'export LDFLAGS=-L$DIR/lib'
echo 'export LIBS="-lnetcdf -lhdf5_hl -lhdf5 -lz"'
echo './configure --prefix=$DIR --disable-shared'
echo "make check"
echo "make"
echo "make install"
echo "==============================================================================="
sleep $DT
#===compile netcdf4-gfortran library
cd $HOME/apps/Downloads
tar -xvzf ${NTCF}.tar.gz
cd ${NTCF}/
export LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH
export CPPFLAGS=-I$DIR/include 
export LDFLAGS=-L$DIR/lib
export LIBS="-lnetcdf -lhdf5_hl -lhdf5 -lz" 
./configure --prefix=$DIR --disable-shared
make
make check
make install
#====compiling libpng for grib compatibility
echo "==============================================================================="
echo "========================COMPILING LIBPNG=============================="
echo "cd $HOME/apps/Downloads/libpng"
echo "export CPPFLAGS=-I$DIR/include"
echo "export LDFLAGS=-L$DIR/lib"
echo "./configure --prefix=$DIR"
echo "make"
echo "make install"
echo "==============================================================================="
sleep $DT
cd $HOME/apps/Downloads/libpng
export CPPFLAGS=-I$DIR/include
export LDFLAGS=-L$DIR/lib
./configure --prefix=$DIR
make
make install
#====compiling jasper for grib compatibility
echo "==============================================================================="
echo "========================COMPILING JASPER=============================="
echo "cd $HOME/apps/Downloads"
echo "unzip ${JASP}.zip"
echo "cd ${JASP}/"
echo "autoreconf -i"
echo "./configure --prefix=$DIR"
echo "make"
echo "make install"
echo "export JASPERLIB=$DIR/lib"
echo "export JASPERINC=$DIR/include"
echo "==============================================================================="
sleep $DT
#===JasPer library
cd $HOME/apps/Downloads
unzip ${JASP}.zip
cd ${JASP}/
autoreconf -i
./configure --prefix=$DIR
make
make install
export JASPERLIB=$DIR/lib
export JASPERINC=$DIR/include
#====compiling jasper for grib compatibility
echo "==============================================================================="
echo "========================COMPILING JASPER=============================="
echo "cd $HOME/apps/Downloads"
echo "tar -xvzf libaec-1.1.2.tar.gz"
echo "cd ${LAEC}/"
echo "./configure --prefix=$DIR"
echo "make"
echo "make install"
echo "==============================================================================="
sleep $DT
#===libaec library
cd $HOME/apps/Downloads
tar -xvzf libaec-1.1.2.tar.gz
cd ${LAEC} 
./configure --prefix=$DIR
make
make install


