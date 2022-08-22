#!/bin/sh

# make directories
mkdir -pv ~/.config/nvim

# make symlinks for dotfiles
[ ! -e ~/.config/nvim/init.vim ] && \
    ln -s ~/.files/.config/nvim/init.vim ~/.config/nvim/init.vim

[ ! -e ~/.config/nvim/lua ] && \
    ln -s ~/.files/.config/nvim/lua ~/.config/nvim/lua

[ ! -e ~/.tmux.conf ] && \
    ln -s ~/.files/.tmux.conf ~/.tmux.conf

[ ! -e ~/.zshrc ] && \
    ln -s ~/.files/.zshrc ~/.zshrc

[ ! -e ~/.alacritty.yml ] && \
    ln -s ~/.files/.alacritty.yml ~/.alacritty.yml

# install tmux plugins
[ ! -e ~/.tmux/plugins/tpm ] &&
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &&
    ~/.tmux/plugins/tpm/bindings/install_plugins
