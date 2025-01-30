#!/usr/bin/env bash
set -e  # 在出现错误时停止脚本

TMP_DIR="$HOME/tmp"

# 安装 build-essential
install_build_essential() {
    sleep 2
    clear
    echo -e "\033[1;36m🔹 正在安装 build_essential ...\033[0m"
    sudo apt install -y build-essential
}

# 安装 Python 3
install_python() {
    sleep 2
    clear
    if ! command -v python3 &> /dev/null; then
      echo -e "\033[1;36m🔹 正在安装 python3 ...\033[0m"
      sudo apt install -y python3 python3-pip
    else
      echo -e "\033[1;32m✅ python3 已安装，跳过...\033[0m"
    fi
}

# 安装 CMake
install_cmake() {
    sleep 2
    clear
    if ! command -v cmake &> /dev/null; then
        echo -e "\033[1;36m🔹 正在安装 cmake ...\033[0m"
        CMAKE_VERSION="3.30.1"  # 设置所需的 CMake 版本

        # 下载 CMake 源代码
        cd $TMP_DIR
        wget "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz"
        tar -zxvf "cmake-${CMAKE_VERSION}.tar.gz"
        
        # 进入解压目录并编译安装
        cd "cmake-${CMAKE_VERSION}"
        ./bootstrap  # 运行配置脚本
        make -j$(nproc)  # 使用多核编译
        sudo make install  # 安装到系统目录

        # 清理安装文件
        cd ..
        rm -rf "cmake-${CMAKE_VERSION}" "cmake-${CMAKE_VERSION}.tar.gz"
    else
        echo -e "\033[1;32m✅ cmake 已安装，跳过...\033[0m"
    fi
}

# Install Anaconda
install_conda(){
    sleep 2
    clear

    if ! command -v conda &> /dev/null; then
        echo -e "\033[1;36m🔹 正在安装 Anaconda Dependencies ...\033[0m"
        sudo apt install -y curl bzip2

        sleep 2
        clear
        echo -e "\033[1;36m🔹 正在安装 Anaconda ...\033[0m"

        # 设置 Anaconda 安装目录和下载链接
        ANACONDA_VERSION="2024.10-1"
        INSTALL_DIR="$HOME/tools/anaconda3"
        INSTALLER="Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh"
        ANACONDA_URL="https://repo.anaconda.com/archive/$INSTALLER"


        # 下载 Anaconda 安装脚本
        cd $TMP_DIR
        curl -O $ANACONDA_URL

        # 运行安装脚本
        bash $INSTALLER -b -p $INSTALL_DIR

        echo -e "\033[1;32m✅ conda success\033[0m"
    else
        echo -e "\033[1;32m✅ conda 已安装，跳过...\033[0m"
    fi
}

# 主执行流程
install_build_essential
install_python
install_cmake
install_conda
