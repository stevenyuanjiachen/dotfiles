#!/usr/bin/env bash
set -e  # 在出现错误时停止脚本
# set -x  # 打印执行的命令（可选）

# 定义 dotfiles 目录
DOTFILES_DIR="$HOME/dotfiles"

# 确保 dotfiles 目录存在
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Dotfiles directory not found: $DOTFILES_DIR"
  exit 1
fi



###################################
# 安装依赖
###################################

echo "Installing dependencies..."
chmod +x ./install_dependencies.sh
./install_dependencies.sh

cd "$HOME/dotfiles"


###################################
# stow
###################################

# 检查并安装 stow（如果未安装）
if ! command -v stow &> /dev/null; then
  echo "stow is not installed. Installing stow..."
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update && sudo apt install -y stow
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install stow
  else
    echo "Please install 'stow' manually."
    exit 1
  fi
else
  echo "stow is already installed."
fi

# used to stow modules
stow_module() {
  local module="$1"
  echo "Stowing $module..."
  stow -d "$DOTFILES_DIR" -t "$HOME" "$module"
}

echo "-------------------------------------------"



##################################################
# zsh
##################################################

# 检查并安装 Zsh（如果未安装）
if ! command -v zsh &> /dev/null; then
  echo "Zsh is not installed. Installing Zsh..."
  sudo apt update && sudo apt install -y zsh
else
  echo "Zsh is already installed."
fi

# 安装 oh-my-zsh
install_ohmyzsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    echo "oh-my-zsh is already installed."
  fi
}

# 安装 Powerlevel10k 主题
install_p10k() {
  if [ ! -d "$HOME/.oh-my-zsh/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/themes/powerlevel10k"
  else
    echo "Powerlevel10k is already installed."
  fi
}

# 安装 zsh 插件
install_zsh_plugins() {
  local ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
  local PLUGINS_DIR="$ZSH_CUSTOM/plugins"

  # 安装 zsh-syntax-highlighting
  if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR/zsh-syntax-highlighting"
  else
    echo "zsh-syntax-highlighting is already installed."
  fi

  # 安装 zsh-autosuggestions
  if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
  else
    echo "zsh-autosuggestions is already installed."
  fi

   # 安装 zsh-vi-mode
  if [ ! -d "$PLUGINS_DIR/zsh-vi-mode" ]; then
    git clone https://github.com/jeffreytse/zsh-vi-mode.git "$PLUGINS_DIR/zsh-vi-mode"
  else
    echo "zsh-vi-mode is already installed."
  fi
}

# 链接 zsh 配置并安装插件
install_ohmyzsh
rm ~/.zshrc
stow_module "zsh"
install_zsh_plugins
install_p10k

# 确保 zsh 是默认 shell
if [ "$SHELL" != "$(command -v zsh)" ]; then
  echo "Changing default shell to zsh..."
  chsh -s "$(command -v zsh)"
fi

echo "-------------------------------------------"



#################################################
# autojump
#################################################

install_autojump() {
  if ! command -v autojump &> /dev/null; then
    echo "Installing autojump..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      git clone https://github.com/wting/autojump.git /tmp/autojump
      cd /tmp/autojump
      chmod +x install.py  # 确保脚本可执行
      ./install.py
      cd -
      rm -rf /tmp/autojump  # 清理临时目录
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      brew install autojump
    else
      echo "Please install 'autojump' manually."
      exit 1
    fi
  else
    echo "autojump is already installed."
  fi
}

install_autojump

echo "-------------------------------------------"



##################################################
# Git 
##################################################

# 链接 Git 配置
stow_module "git"  

echo "-------------------------------------------"



#################################################
# Vim
#################################################

# 链接 Vim 配置
stow_module "vim"

echo "-------------------------------------------"



#################################################
# Neovim
#################################################

# 检查并调用 Neovim 安装脚本
if ! command -v nvim &> /dev/null; then
    echo "Neovim is not installed. Running install_nvim.sh..."
    chmod +x ./install_nvim.sh
    ./install_nvim.sh
else
  echo "Neovim is already installed."
fi

# 链接 Neovim 配置
cd "$HOME/dotfiles"
stow_module "nvim"

echo "-------------------------------------------"



#################################################
# Tmux
#################################################

# 链接 Tmux 配置
stow_module "tmux"

echo "-------------------------------------------"



# 结束
echo "Dotfiles configuration completed successfully!"


