#!/bin/bash

set -e

if [ ! -e my-glslang/build/install/lib/libglslang.so ]; then
  if [ ! -d my-glslang ]; then
    git clone https://github.com/KhronosGroup/glslang.git my-glslang
  fi

  pushd my-glslang
  # Note: the master branch of ncnn is using the following commit
  git checkout 88fd417b0bb7d91755961c70e846d274c182f2b0

  mkdir -p build
  cd build

  if [ $(uname) == "Darwin" ]; then
    os=darwin
  elif [ $(uname) == "Linux" ]; then
    os=linux
  else
    echo "Unsupported system: $(uname -a)"
    exit 1
  fi

  cmake \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_INSTALL_PREFIX="$(pwd)/install" \
    -DCMAKE_BUILD_TYPE=Release \
    ..

  make -j4
  make install/strip
  ls -lh install/lib/

  echo "Finish building glslang"
  sleep 1

  popd
fi
