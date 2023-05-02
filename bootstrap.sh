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
ln -snfv ${PWD}/.config/starship.toml ~/.config/starship.toml

if [[ "$(uname -r)" == *microsoft* ]]; then
  sudo apt update && sudo apt install build-essential procps curl file git -y
fi

# install homebrew
if [[ ! -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
brew install starship zsh fzf neovim

# init zinit plugins
echo setup zsh
zsh -i -c exit

# init noevim
echo setup noevim
nvim --headless -c 'qall'

echo "run this command to change login shell"
echo "chsh -s $(which zsh)"

