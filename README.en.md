# Setup Dev

-   [Simplified Chinese](README.md)
-   [English](README.en.md)

## introduce

-   This is a tool for building`C++`A collection of scripts for the development environment;
-   Part of the script comes from[runner-images](https://github.com/actions/runner-images)；

## Table of contents

1.  [ubuntu](ubuntu)——Installation script in ubuntu
    1.  [build-qt5](/ubuntu/build-qt5)——Qt5 source code compilation and installation
        1.  [build.sh](/ubuntu/build-qt5/build.sh)——`qt5`Download the source code and compile it based on the current gcc target information;
        2.  [install-dep](/ubuntu/build-qt5/install-dep.sh)——Install and build`qt`required dependencies;
    2.  [build-mpv.sh](/ubuntu/build-mpv.sh)——Compile libmpv.so from mpv source code;
    3.  [configure-apt-sources.sh](/ubuntu/configure-apt-sources.sh)——Configuration`apt`Source is`ustc`of`mirrors`；
    4.  [configure-git.sh](/ubuntu/configure-git.sh)——Configuration`git`information;
    5.  [export-vcpkg-path.sh](/ubuntu/export-vcpkg-path.sh)--integrated`vcpkg`libraries in to environment variables;
    6.  [install-appimagetool.sh](/ubuntu/install-appimagetool.sh)——Install appimagetool;
    7.  [install-cmake.sh](/ubuntu/install-cmake.sh)——Install cmake;
    8.  [install-linuxdeployqt.sh](/ubuntu/install-linuxdeployqt.sh)--Install`linuxdeployqt`, the x86_64 version can be considered directly from[github](https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage)Upload and download;
    9.  [install-patchelf.sh](/ubuntu/install-patchelf.sh)--Install`patchelf`, or you can install it directly using apt;
    10. [install-vcpkg.sh](/ubuntu/install-vcpkg.sh)--Install`vcpkg`, and configure environment variables;
    11. [install.sh](/ubuntu/install.sh)--Auxiliary`shell`function collection;
