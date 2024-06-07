#!/bin/bash -ex

# 确保脚本以root权限运行
if [ "$(id -u)" != "0" ]; then
    echo "请以root用户运行此脚本"
    exit 1
fi

# 安装构建Qt所需的依赖项
echo "安装依赖项..."
apt-get update

apt-get build-dep qtbase5-dev

apt-get install -y build-essential perl python3 git

apt-get install -y '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev

apt-get install -y flex bison gperf libicu-dev libxslt-dev ruby

apt-get install -y libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev libxtst-dev libxss-dev libdbus-1-dev libevent-dev libfontconfig1-dev libcap-dev libpulse-dev libudev-dev libpci-dev libnss3-dev libasound2-dev libegl1-mesa-dev gperf bison nodejs

apt-get install -y libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev

#libgstreamer-plugins-good1.0-dev

apt install -y clang libclang-dev

apt-get install -y libx11-xcb-dev

apt-get install -y libicu-dev

echo "依赖项安装完成"

# 退出脚本
exit 0
