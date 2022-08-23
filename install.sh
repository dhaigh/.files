#!/bin/sh

# make directories
mkdir -v ~/.config
mkdir -v ~/.config/nvim
mkdir -v ~/.config/nvim/lua
mkdir -v ~/.config/alacritty
mkdir -v ~/.config/tmuxinator

# neovim
ln -sw ~/.files/.config/nvim/init.vim ~/.config/nvim
ln -sw ~/.files/.config/nvim/lua/* ~/.config/nvim/lua

# alacritty
ln -sw ~/.files/.config/alacritty/alacritty.yml ~/.config/alacritty

# tmuxinator
ln -sw ~/.files/.config/tmuxinator/*.yml ~/.config/tmuxinator

# tmux
ln -sw ~/.files/.tmux.conf ~

[ ! -e ~/.tmux/plugins/tpm ] &&
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &&
    ~/.tmux/plugins/tpm/bindings/install_plugins

# zsh
ln -sw ~/.files/.zshrc ~
