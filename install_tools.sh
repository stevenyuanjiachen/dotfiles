#!/usr/bin/env bash
set -e  # 在出现错误时停止脚本


# 安装 build-essential
install_build_essential() {
  clear
  echo -e "\n\033[1;36m🔹 正在安装 build_essential ...\033[0m"
  sudo apt install -y build-essential
}

# 安装 Python 3
install_python() {
  clear
  if ! command -v python3 &> /dev/null; then
    echo -e "\n\033[1;36m🔹 正在安装 python3 ...\033[0m"
    sudo apt install -y python3
  else
    echo -e "\n\033[1;32m✅ python3 已安装，跳过...\033[0m"
  fi
}

# 安装 CMake
install_cmake() {
  clear
  if ! command -v cmake &> /dev/null; then
    echo -e "\n\033[1;36m🔹 正在安装 cmake ...\033[0m"
    CMAKE_VERSION="3.30.1"  # 设置所需的 CMake 版本

    # 下载 CMake 源代码
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
    echo -e "\n\033[1;32m✅ cmake 已安装，跳过...\033[0m"
  fi
}

# 主执行流程
install_build_essential
install_python
install_cmake

