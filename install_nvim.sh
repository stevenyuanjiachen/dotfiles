#!/usr/bin/env bash
set -e  # 在出现错误时停止脚本

# 检查 Neovim 是否已安装
if command -v nvim &> /dev/null; then
  echo "Neovim is already installed."
  exit 0
fi

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


##############################################
# 安装依赖项
##############################################

# telescope 依赖 ripgrep
if ! command -v rg &> /dev/null; then
  echo "Installing ripgrep..."

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # 安装 ripgrep (Ubuntu/Debian)
    sudo apt update && sudo apt install -y ripgrep
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # 安装 ripgrep (macOS)
    brew install ripgrep
  else
    # 手动安装 ripgrep
    echo "Please install ripgrep manually for your system."
    exit 1
  fi

  echo "ripgrep installed successfully!"
else
  echo "ripgrep is already installed."
fi


echo "Neovim installed successfully!"
