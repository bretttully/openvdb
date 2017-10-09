#!/bin/bash
set -e

# NB: you may have to change the symlinks of boost python to point to the py3 versions
PACKAGES=""
PACKAGES+=" ninja-build"
PACKAGES+=" cmake-curses-gui"
PACKAGES+=" libblosc-dev"
PACKAGES+=" libtbb-dev"
PACKAGES+=" libz-dev"
PACKAGES+=" libcppunit-dev"
PACKAGES+=" liblog4cplus-dev "
PACKAGES+=" libglfw3-dev "
PACKAGES+=" libopenexr-dev"
PACKAGES+=" libilmbase-dev"
PACKAGES+=" libglu1-mesa-dev "
PACKAGES+=" xorg-dev"
sudo apt-get install ${PACKAGES}

rm -rf _build
mkdir -p _build
cd _build

PYTHON_SITE=`python -c 'from distutils.sysconfig import get_python_lib; print(get_python_lib())'`
echo ${PYTHON_SITE}

cmake \
     -Wno-dev \
    -D OPENVDB_BUILD_UNITTESTS=OFF \
    -D CMAKE_CXX_FLAGS="-std=c++11" \
 \
    -D BLOSC_LOCATION=/usr \
    -D Blosc_USE_STATIC_LIBS=OFF \
 \
    -D TBB_LOCATION=/usr \
    -D TBB_LIBRARYDIR=/usr/lib/x86_64-linux-gnu \
 \
    -D ILMBASE_LOCATION=/usr \
    -D ILMBASE_LIBRARYDIR=/usr/lib/x86_64-linux-gnu \
    -D Ilmbase_USE_STATIC_LIBS=OFF \
    -D ILMBASE_NAMESPACE_VERSIONING=OFF \
 \
    -D OPENEXR_LOCATION=/usr \
    -D OPENEXR_LIBRARYDIR=/usr/lib/x86_64-linux-gnu \
    -D Openexr_USE_STATIC_LIBS=OFF \
    -D OPENEXR_NAMESPACE_VERSIONING=OFF \
 \
    -D USE_GLFW3=ON \
    -D GLFW3_LOCATION=/usr \
    -D GFLW3_LIBRARYDIR=/usr/lib/x86_64-linux-gnu \
    -D GLFW3_USE_STATIC_LIBS=OFF \
 \
    -D PYOPENVDB_INSTALL_DIRECTORY=${PYTHON_SITE} \
    ..

#sudo ninja -j 1 install
make
sudo make install
