#!/usr/bin/env bash
set -e  # 在出现错误时停止脚本
set -x  # 打印执行的命令

# 定义 dotfiles 目录，替换成你的 dotfiles 仓库路径
DOTFILES_DIR="$HOME/dotfiles"

# 确保 dotfiles 目录存在
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Dotfiles directory not found: $DOTFILES_DIR"
  exit 1
fi


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


##################################################
# zsh
##################################################

# 安装 oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "oh-my-zsh is already installed."
fi

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
}


##################################################
# 使用 stow 链接 dotfiles 中的各个模块
##################################################

stow_module() {
  local module="$1"
  echo "Stowing $module..."
  stow -d "$DOTFILES_DIR" -t "$HOME" "$module"
}

# 链接 zsh 配置并安装插件
stow_module "zsh"
install_zsh_plugins

# 安装 Powerlevel10k 主题
install_p10k

# 链接 Git 配置
stow_module "git"  # 确保 git 模块已在 dotfiles 中

# 链接 nvim 配置
stow_module "nvim"

# 链接 tmux 配置
stow_module "tmux"


# 确保 zsh 是默认 shell
if [ "$SHELL" != "$(command -v zsh)" ]; then
  echo "Changing default shell to zsh..."
  chsh -s "$(command -v zsh)"
fi


# 结束
echo "Dotfiles configuration completed successfully!"
