#!/bin/bash -ex

source ./../install.sh

qt-everywhere-src="qt-everywhere-src-5.15.2"

if [ -f ~/Downloads/${qt-everywhere-src}.tar.xz ]; then
    echo "${qt-everywhere-src}.tar.xz 已经存在"
else
    echo "${qt-everywhere-src}.tar.xz 不存在"
    wget -P ~/Downloads https://mirrors.ustc.edu.cn/qtproject/archive/qt/5.15/5.15.2/single/${qt-everywhere-src}.tar.xz
fi

rm -rf /tmp/${qt-everywhere-src}

tar -xvf ~/Downloads/${qt-everywhere-src}.tar.xz -C /tmp

echo "获取当前gcc target 信息，配置QT路径"

gcc_target=$(get_gcc_target)

if [ "${gcc_target}" == "x86_64" ]; then
    qt_arch="gcc_64"
elif [ "${gcc_target}" == "aarch64" ]; then
    qt_arch="gcc_arm64"
else
    echo "${gcc_target}"
    exit 1
fi

qt_build_path=/tmp/qt5-build/${qt_arch}
qt_perfix_path=/opt/Qt5.15.2/${qt_arch}

echo "compile qt_arch: ${qt_arch}"
echo "tmp dir: ${qt_build_path}"
echo "qt5 dir: ${qt_perfix_path}"

mkdir -p ${qt_build_path}
cd ${qt_build_path}

echo "开始编译qt5"

./../../${qt-everywhere-src}/configure -opensource -confirm-license -prefix ${qt_perfix_path}

make -j $(nproc)

echo "编译完成"
echo "开始安装"

sudo make install

echo "安装完成"
echo "编译文档"

make docs

echo "文档编译完成"
