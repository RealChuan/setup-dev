#!/bin/bash -ex

source install.sh

gcc_target=$(get_gcc_target) || true

if [ "${gcc_target}" == "x86_64" ]; then
    VCPKG_TARGET_TRIPLET="x64-linux"
elif [ "${gcc_target}" == "aarch64" ]; then
    VCPKG_TARGET_TRIPLET="arm64-linux"
else
    echo "${gcc_target}"
    exit 1
fi

VCPKG_ROOT=/usr/local/share/vcpkg
VCPKG_TARGET_PATH=${VCPKG_ROOT}/installed/${VCPKG_TARGET_TRIPLET}

export CXXFLAGS=-I${VCPKG_TARGET_PATH}/include
export CFLAGS=-I${VCPKG_TARGET_PATH}/include
export LDFLAGS=-L${VCPKG_TARGET_PATH}/lib
export PKG_CONFIG_PATH=${VCPKG_TARGET_PATH}/lib/pkgconfig:${VCPKG_TARGET_PATH}/share/pkgconfig:$PKG_CONFIG_PATH
