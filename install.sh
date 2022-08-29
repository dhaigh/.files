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

# ------------------------------------------------------------------------------
# other things to do:
# ------------------------------------------------------------------------------

# make sure ~/.npmrc includes:
# prefix=/Users/deco/.npm-global

# stylua: https://github.com/johnnymorganz/stylua
# cargo install stylua

# ts language server: https://github.com/typescript-language-server/typescript-language-server
# npm install -g typescript-language-server typescript

# eslint_d: https://github.com/mantoni/eslint_d.js
# npm install -g eslint_d

# fd: https://github.com/sharkdp/fd
# brew install fd
