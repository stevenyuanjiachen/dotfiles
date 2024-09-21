#!/usr/bin/env bash
set -e  # 在出现错误时停止脚本

# 检查 Neovim 是否已安装
if command -v nvim &> /dev/null; then
    echo "Neovim is already installed."
else
    # 设置 Neovim 版本
    NEOVIM_VERSION="v0.11.0"  # 你可以根据需要修改版本号

    # 下载 Neovim 源代码
    echo "Downloading Neovim..."
    git clone --recurse-submodules https://github.com/neovim/neovim.git /tmp/neovim
    cd /tmp/neovim

    # 检出指定版本
    git checkout $NEOVIM_VERSION

    # 编译和安装 Neovim
    echo "Building and installing Neovim..."
    make CMAKE_BUILD_TYPE=Release
    sudo make install

    # 清理临时目录
    cd ~
    rm -rf /tmp/neovim

    echo "Neovim installed successfully!"
fi


##############################################
# 安装依赖项
##############################################

# telescope 依赖 ripgrep
if ! command -v rg &> /dev/null; then
    echo "Installing ripgrep..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update && sudo apt install -y ripgrep
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install ripgrep    
    else
        echo "Please install ripgrep manually for your system."
        exit 1
    fi

    echo "ripgrep installed successfully!"
else
    echo "ripgrep is already installed."
fi

# LSP 依赖 npm
if ! command -v npm &> /dev/null; then
    echo "Installing npm..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update && sudo apt install -y npm || { echo "Failed to install npm"; exit 1; }
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install npm || { echo "Failed to install npm"; exit 1; }
    else
        echo "Please install npm manually for your system."
        exit 1
    fi

    echo "npm installed successfully!"
else
    echo "npm is already installed."
fi

# LSP 依赖 unzip
if ! command -v unzip &> /dev/null; then
    echo "Installing unzip..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update && sudo apt install -y unzip || { echo "Failed to install unzip"; exit 1; }
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install unzip || { echo "Failed to install unzip"; exit 1; }
    else
        echo "Please install unzip manually for your system."
        exit 1
    fi

    echo "unzip installed successfully!"
else
    echo "unzip is already installed."
fi

echo "All required dependencies installed successfully!"
