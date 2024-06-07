#!/bin/bash -ex

# 确保脚本以root权限运行
if [ "$(id -u)" != "0" ]; then
    echo "请以root用户运行此脚本"
    exit 1
fi

wget -c "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-aarch64.AppImage" -O /usr/local/bin/appimagetool
chmod a+x /usr/local/bin/appimagetool
