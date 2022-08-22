#!/bin/sh

# make symlinks for dotfiles
mkdir -pv ~/.config/nvim
[ ! -e ~/.config/nvim   ] && ln -s ~/.files/.config/nvim         ~/.config/nvim
[ ! -e ~/.tmux.conf     ] && ln -s ~/.files/.tmux.conf           ~/.tmux.conf
[ ! -e ~/.vim           ] && ln -s ~/.files/.vim                 ~/.vim
[ ! -e ~/.vimrc         ] && ln -s ~/.files/.vimrc               ~/.vimrc
[ ! -e ~/.zshrc         ] && ln -s ~/.files/.zshrc               ~/.zshrc
[ ! -e ~/.alacritty.yml ] && ln -s ~/.files/.alacritty.yml       ~/.alacritty.yml

# install tmux plugins
[ ! -e ~/.tmux/plugins/tpm ] &&
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &&
    ~/.tmux/plugins/tpm/bindings/install_plugins
