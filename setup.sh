#!/usr/bin/env bash

# 请求 sudo 权限
echo "🔐 Requesting sudo password..."
sudo -v

# 定义 dotfiles 目录
DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

# 解析参数
AUTO_INSTALL=false
[[ "$1" == "-a" ]] && AUTO_INSTALL=true

# 询问是否安装（如果未启用 -a）
ask_install() {
  clear
  local package="$1"

  # 如果已安装，直接跳过
  if command -v "$package" &> /dev/null; then
    echo -e "\n\033[1;32m✅ $package 已安装，跳过...\033[0m"
    return 1
  fi

  if $AUTO_INSTALL; then
    echo -e "\n\033[1;36m🔹 正在安装 $package...\033[0m"
    return 0
  fi

  read -p "👉 是否安装 $package? (y/N) " choice
  [[ "$choice" == [Yy] ]] && echo -e "\n\033[1;36m🔹 正在安装 $package...\033[0m" && return 0
  return 1
}

# Stow 配置文件
install_stow_module() {
  stow -d "$DOTFILES_DIR" -t "$HOME" "$1"
}

# 安装依赖
ask_install "依赖" && chmod +x ./install_dependencies.sh && ./install_dependencies.sh
ask_install "stow" && sudo apt update && sudo apt install -y stow

# Zsh & 插件
if ask_install "zsh"; then
  sudo apt install -y zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom/plugins"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/zsh-autosuggestions"
  git clone https://github.com/jeffreytse/zsh-vi-mode.git "$ZSH_CUSTOM/zsh-vi-mode"

  rm -f ~/.zshrc
  install_stow_module "zsh"
  sudo chsh -s "$(command -v zsh)" "$USER"
fi

# Starship
ask_install "starship" && curl -sS https://starship.rs/install.sh | sh -s -- -y && install_stow_module "starship"

# Autojump
ask_install "autojump" && sudo apt install -y autojump

# Git、Vim、GDB 配置（仅 Stow）
install_stow_module "git"
install_stow_module "vim"
install_stow_module "gdb"

# Neovim
if ask_install "nvim"; then
  chmod +x ./install_nvim.sh && ./install_nvim.sh
  install_stow_module "nvim"
fi

# Tmux
if ask_install "tmux"; then
  rm -rf "$HOME/.tmux" "$HOME/.tmux.conf"
  install_stow_module "tmux"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# GDB 额外安装依赖
pip install --user pygments

echo -e "\n\033[1;32m✅ Dotfiles 配置完成！\033[0m"
