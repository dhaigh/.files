#!/bin/sh

# make directories
mkdir -v ~/.config
mkdir -v ~/.config/nvim

# neovim
ln -sw ~/.files/.config/nvim/init.vim ~/.config/nvim
ln -sw ~/.files/.config/nvim/lua ~/.config/nvim

# alacritty
ln -sw ~/.files/.config/alacritty ~/.config

# tmuxinator
ln -sw ~/.files/.config/tmuxinator ~/.config

# stylua
ln -sw ~/.files/stylua.toml ~/.config

# tmux
ln -sw ~/.files/.tmux.conf ~

[ ! -e ~/.tmux/plugins/tpm ] &&
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &&
    ~/.tmux/plugins/tpm/bindings/install_plugins

# zsh
ln -sw ~/.files/.zshrc ~

# other things to do:
# cargo install stylua
