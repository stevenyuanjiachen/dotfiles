# YJC's dotfiles

My personal configuration files. They are designed for a ZSH + TMUX + NEOVIM stack.

- `install_dependencies.sh` - will install necessary tools include
    - build-essential
    - [cmake](https://cmake.org/files/) - to manually install tools like neovim
    - python3

- `install_nvim.sh` - will install neovim(v0.11.0) and the dependencies of its plugins include
    - [npm](https://github.com/npm/npm) - dependency of the LSP
    - unzip - dependency of the LSP 
    - [ripgrep](https://github.com/BurntSushi/ripgrep) - dependency of the telescope

- `setup.sh` - will bootstrap the shell environment including
    - install dependencies
    - autojump
    - oh-my-zsh - ZSH framework
    - zsh-syntax-highlighting
    - zsh-auto-suggestion
    - [powerlevel10k](https://github.com/romkatv/powerlevel10k) - ZSH prompt
    - install neovim
    - link dotfiles using `stow`
