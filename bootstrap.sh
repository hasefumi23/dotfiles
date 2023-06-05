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

if [[ $(cat /etc/os-release | grep -E 'NAME="Ubuntu.*"' -i) ]]; then
  sudo apt update && sudo apt install build-essential procps curl file git -y
fi

# install homebrew
if [[ ! -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# これがないと、github actions上でbrew install実行時にエラーになる
brew update
brew install zsh fzf neovim

# fzfのキーバインディングなどのセットアップを実行する
$(brew --prefix)/opt/fzf/install --all

echo setup zsh
# ここにインタラクティブな処理が入るので、環境変数CIを見て、CI上だったらスキップする
if [[ ${CI} != "true" ]]; then
  zsh -i -c exit
fi

echo setup neovim
nvim --headless -c 'qall'

echo "run this command to change login shell"
echo "chsh -s $(which zsh)"
