#!/bin/bash -ex

mkdir -p ~/github
cd ~/github

wget https://codeload.github.com/NixOS/patchelf/tar.gz/refs/tags/0.18.0

tar -xvf 0.18.0 -C /tmp

cd /tmp/patchelf-0.18.0

./bootstrap.sh
./configure
make -j $(nproc)
make check
sudo make install

echo "patchelf 安装完成"
