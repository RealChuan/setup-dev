#!/bin/bash -e

# 确保脚本以root权限运行
if [ "$(id -u)" != "0" ]; then
    echo "请以root用户运行此脚本"
    exit 1
fi

sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

apt update -y && apt full-upgrade -y && apt autoremove -y && apt autoclean -y
