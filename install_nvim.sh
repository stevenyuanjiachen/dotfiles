#!/usr/bin/env bash
set -e  # 在出现错误时停止脚本

# 安装依赖项
install_dependency() {
    local package=$1

    if ! command -v "$package" &> /dev/null; then
        echo -e "\n\033[1;36m🔹 正在安装 nvim 依赖项 $package...\033[0m"
        sudo apt install -y "$package"
    else
        echo -e "\n\033[1;32m✅ nvim 依赖项 $package 已安装，跳过...\033[0m"
    fi
}

sudo apt install -y gettext
install_dependency ripgrep
install_dependency npm
install_dependency unzip

# 设置 Neovim 版本
NEOVIM_VERSION="v0.10.1"  # 你可以根据需要修改版本号

# 下载 Neovim 源代码
echo "Downloading Neovim..."
rm -rf ~/tmp
git clone --recurse-submodules https://github.com/neovim/neovim.git ~/tmp/neovim
cd ~/tmp/neovim

# 检出指定版本
git checkout $NEOVIM_VERSION

# 编译和安装 Neovim
echo "Building and installing Neovim..."
make -j$(nproc) CMAKE_BUILD_TYPE=Release
sudo make install

# 清理临时目录
cd ~
rm -rf ~/tmp
