#!/bin/bash -ex

# 安装列表中未安装的第一个软件包
install_first_uninstalled() {
    local package_list=("$@") # 将参数列表转换为数组
    local package

    # 遍历软件包列表
    for package in "${package_list[@]}"; do
        # 检查软件包是否已安装
        if ! dpkg -l | grep -qw "^ii\s\+$package"; then
            # 如果未安装，尝试安装它
            echo "安装 $package ..."
            sudo apt-get install -y "$package" || true
            break # 安装后退出循环
        else
            echo "$package 已安装。"
        fi
    done
}

sudo apt update
sudo apt install -y gcc g++ autoconf automake debhelper glslang-dev ladspa-sdk libasound2-dev \
    libarchive-dev libbluray-dev libbs2b-dev libcaca-dev libcdio-paranoia-dev libdrm-dev \
    libdav1d-dev libdvdnav-dev libegl1-mesa-dev libepoxy-dev libfontconfig-dev libfreetype6-dev \
    libfribidi-dev libgl1-mesa-dev libgbm-dev libgme-dev libgsm1-dev libharfbuzz-dev libjpeg-dev \
    libbrotli-dev liblcms2-dev liblircclient-dev libmodplug-dev libmp3lame-dev libopenal-dev \
    libopus-dev libopencore-amrnb-dev libopencore-amrwb-dev libpulse-dev librtmp-dev \
    librubberband-dev libsdl2-dev libsixel-dev libssh-dev libsoxr-dev libspeex-dev libtool \
    libuchardet-dev libv4l-dev libva-dev libvdpau-dev libvorbis-dev libvo-amrwbenc-dev \
    libunwind-dev libvpx-dev libvulkan-dev libwayland-dev libx264-dev libx11-dev libxext-dev \
    libxkbcommon-dev libxpresent-dev libxrandr-dev libxss-dev libxv-dev libxvidcore-dev \
    linux-libc-dev nasm ninja-build pkg-config python3 python3-docutils wayland-protocols \
    x11proto-core-dev zlib1g-dev libfdk-aac-dev libtheora-dev libwebp-dev libx265-dev \
    unixodbc-dev libpq-dev libxxhash-dev libaom-dev

install_first_uninstalled libgnutls-dev libgnutls28-dev
install_first_uninstalled libjack-jackd2-dev libjack-dev
install_first_uninstalled liblua5.2-dev liblua5.1-0-dev

pip3 install meson

MPV_BUILD_PATH=/tmp/mpv_build
rm -rf ${MPV_BUILD_PATH}
git clone https://github.com/mpv-player/mpv-build.git ${MPV_BUILD_PATH}
git config --global --add safe.directory ${MPV_BUILD_PATH}

chmod -R +x ${MPV_BUILD_PATH}
cd ${MPV_BUILD_PATH}

printf "%s\n" --enable-gpl >>ffmpeg_options
printf "%s\n" --enable-version3 >>ffmpeg_options
printf "%s\n" --enable-nonfree >>ffmpeg_options
printf "%s\n" --enable-libass >>ffmpeg_options
printf "%s\n" --enable-vdpau >>ffmpeg_options
printf "%s\n" --enable-vaapi >>ffmpeg_options
printf "%s\n" --enable-opengl >>ffmpeg_options
printf "%s\n" --enable-libbluray >>ffmpeg_options
printf "%s\n" --enable-libdrm >>ffmpeg_options
printf "%s\n" --enable-libfontconfig >>ffmpeg_options
printf "%s\n" --enable-libfreetype >>ffmpeg_options
printf "%s\n" --enable-libgsm >>ffmpeg_options
printf "%s\n" --enable-libmodplug >>ffmpeg_options
printf "%s\n" --enable-libmp3lame >>ffmpeg_options
printf "%s\n" --enable-libopus >>ffmpeg_options
printf "%s\n" --enable-libpulse >>ffmpeg_options
printf "%s\n" --enable-libsoxr >>ffmpeg_options
printf "%s\n" --enable-libspeex >>ffmpeg_options
printf "%s\n" --enable-libssh >>ffmpeg_options
printf "%s\n" --enable-libtheora >>ffmpeg_options
printf "%s\n" --enable-libv4l2 >>ffmpeg_options
printf "%s\n" --enable-libvorbis >>ffmpeg_options
printf "%s\n" --enable-libwebp >>ffmpeg_options
printf "%s\n" --enable-libx264 >>ffmpeg_options
printf "%s\n" --enable-libx265 >>ffmpeg_options
printf "%s\n" --enable-libfdk-aac >>ffmpeg_options
printf "%s\n" --enable-gnutls >>ffmpeg_options
printf "%s\n" --enable-libvpx >>ffmpeg_options
printf "%s\n" --enable-pic >>ffmpeg_options
printf "%s\n" --enable-libaom >>ffmpeg_options

printf "%s\n" -Dlibmpv=true >mpv_options

./use-ffmpeg-release
./use-libass-master
./use-libplacebo-release
./use-mpv-release

./rebuild -j$(nproc)
