#!/usr/bin/env bash
set -e  # 在出现错误时停止脚本


###################################
# 安装 build-essential
###################################

install_build_essential() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Installing build-essential..."
    sudo apt update && sudo apt install -y build-essential
  else
    echo "build-essential is typically not needed on macOS."
  fi
}


###################################
# 安装 Python 3
###################################

install_python() {
  if ! command -v python3 &> /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      echo "Installing Python 3..."
      sudo apt install -y python3
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      echo "Installing Python 3 via Homebrew..."
      brew install python
    else
      echo "Please install Python 3 manually."
    fi
  else
    echo "Python 3 is already installed."
  fi
}


###################################
# 安装 CMake
###################################

install_cmake() {
  if ! command -v cmake &> /dev/null; then
    echo "Installing CMake..."
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
    
    echo "CMake installed successfully."
  else
    echo "CMake is already installed."
  fi
}

###################################
# 主执行流程
###################################

install_build_essential
install_python
install_cmake

echo "Dependencies installation completed successfully!"
