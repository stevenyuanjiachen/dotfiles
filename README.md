# YJC's dotfiles

## ✨ 介绍
这是我的的个人代码环境自动化部署工具，为 Zsh + Noevim + Tmux 工作流而设计

## 🚀 功能
- `install_dependencies.sh` - will install necessary tools include
    - build-essential
    - [cmake](https://cmake.org/files/) - to manually install tools like neovim
    - python3 && pip

- `install_nvim.sh` - will install neovim(v0.11.0) and the dependencies of its plugins include
    - GetText - dependcy of Neovim
    - [npm](https://github.com/npm/npm) - dependency of the LSP
    - unzip - dependency of the LSP 
    - [ripgrep](https://github.com/BurntSushi/ripgrep) - dependency of the telescope

- `setup.sh` - will bootstrap the shell environment including
    - install dependencies
    - autojump
    - oh-my-zsh - ZSH framework
    - zsh-syntax-highlighting
    - zsh-auto-suggestion
    - starship
    - install neovim
    - link dotfiles using `stow`

## 📥 使用
使用下面的命令来部署环境，在安装各个模块前程序将会询问是否安装
```bash
./setup.sh
```
如果想一次性安装所有模块，不询问，则加上参数 `-a`
```bash
./setup.sh -a
```
如果在安装过程中遇到问题，需要重新安装，则加上参数 `-r`
```bash
./setup.sh -r
```

