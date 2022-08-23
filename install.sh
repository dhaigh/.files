#!/bin/sh

# make directories
mkdir -pv ~/.config
mkdir -pv ~/.config/nvim
mkdir -pv ~/.config/alacritty

# make symlinks for dotfiles
[ ! -e ~/.config/nvim/init.vim ] && \
    ln -s ~/.files/.config/nvim/init.vim ~/.config/nvim/init.vim

[ ! -e ~/.config/nvim/lua ] && \
    ln -s ~/.files/.config/nvim/lua ~/.config/nvim/lua

[ ! -e ~/.config/alacritty/alacritty.yml ] && \
    ln -s ~/.files/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

[ ! -e ~/.tmux.conf ] && \
    ln -s ~/.files/.tmux.conf ~/.tmux.conf

[ ! -e ~/.zshrc ] && \
    ln -s ~/.files/.zshrc ~/.zshrc

# install tmux plugins
[ ! -e ~/.tmux/plugins/tpm ] &&
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &&
    ~/.tmux/plugins/tpm/bindings/install_plugins
