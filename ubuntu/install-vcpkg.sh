#!/bin/bash -ex
################################################################################
##  File:  install-vcpkg.sh
##  Desc:  Install vcpkg
################################################################################

# 确保脚本以root权限运行
if [ "$(id -u)" != "0" ]; then
    echo "请以root用户运行此脚本"
    exit 1
fi

# Source the helpers for use with the script
source install.sh

gcc_target=$(get_gcc_target)
if [ "${gcc_target}" != "x86_64" ]; then
    export VCPKG_USE_SYSTEM_BINARIES=1
fi

# Set env variable for vcpkg
VCPKG_INSTALLATION_ROOT=/usr/local/share/vcpkg
set_etc_environment_variable "VCPKG_INSTALLATION_ROOT" "${VCPKG_INSTALLATION_ROOT}"

# Install vcpkg
git clone https://github.com/Microsoft/vcpkg $VCPKG_INSTALLATION_ROOT

$VCPKG_INSTALLATION_ROOT/bootstrap-vcpkg.sh

# workaround https://github.com/microsoft/vcpkg/issues/27786

mkdir -p /root/.vcpkg/ $HOME/.vcpkg
touch /root/.vcpkg/vcpkg.path.txt $HOME/.vcpkg/vcpkg.path.txt

$VCPKG_INSTALLATION_ROOT/vcpkg integrate install
chmod 0777 -R $VCPKG_INSTALLATION_ROOT
ln -sf $VCPKG_INSTALLATION_ROOT/vcpkg /usr/local/bin

rm -rf /root/.vcpkg $HOME/.vcpkg

# invoke_tests "Tools" "Vcpkg"
