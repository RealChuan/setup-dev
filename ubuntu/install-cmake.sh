#!/bin/bash -e
################################################################################
##  File:  install-cmake.sh
##  Desc:  Install CMake
##  Supply chain security: CMake - checksum validation
################################################################################

# Source the helpers for use with the script
source install.sh

# Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if command -v cmake; then
    echo "cmake is already installed"
else
    # Download script to install CMake
    gcc_target=$(get_gcc_target)
    if [ "${gcc_target}" == "x86_64" ]; then
        cmake_arch="x86_64"
    elif [ "${gcc_target}" == "aarch64" ]; then
        cmake_arch="aarch64"
    else
        echo "${gcc_target}"
        exit 1
    fi

    # Download script to install CMake
    download_url=$(resolve_github_release_asset_url "Kitware/CMake" "endswith(\"inux-${cmake_arch}.sh\")" "latest")
    curl -fsSL "${download_url}" -o cmakeinstall.sh

    # Supply chain security - CMake
    hash_url=$(resolve_github_release_asset_url "Kitware/CMake" "endswith(\"SHA-256.txt\")" "latest")
    external_hash=$(get_checksum_from_url "$hash_url" "linux-${cmake_arch}.sh" "SHA256")
    use_checksum_comparison "cmakeinstall.sh" "$external_hash"

    # Install CMake and remove the install script
    sudo chmod +x cmakeinstall.sh &&
        ./cmakeinstall.sh --prefix=/usr/local --exclude-subdir &&
        rm cmakeinstall.sh
fi

# invoke_tests "Tools" "Cmake"
