#!/usr/bin/env bash

# symlinks
PWD=`pwd`
DOTFILES=$(find . -maxdepth 1 -type f -name ".*")

for DOTFILE in ${DOTFILES[@]}; do
  SYMLINK="${HOME}/${DOTFILE}"
  ln -snfv ${PWD}/${DOTFILE} ${SYMLINK}
done

# ~/.config
mkdir -p ~/.config/fish
ln -snfv ${PWD}/.config/fish/config.fish ~/.config/fish/config.fish
ln -snfv ${PWD}/.config/fish/fishfile ~/.config/fish/fishfile
mkdir -p ~/.config/nvim/ && ln -snfv ${PWD}/.vimrc ~/.config/nvim/init.vim
mkdir -p ~/.vim/rc && ln -snfv ${PWD}/.vim/rc/dein.toml ~/.vim/rc/dein.toml
ln -snfv ${PWD}/starship.toml ~/.config/starship.toml

