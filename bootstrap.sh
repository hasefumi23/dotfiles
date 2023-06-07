#!/usr/bin/env bash

sudo -v

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
  # homebrewniに必要なパッケージ
  sudo apt update && sudo apt install -y build-essential procps curl file git
  # その他パッケージ
  sudo apt install -y wslu
  # 日本語化
  sudo apt -y install language-pack-ja-base language-pack-ja
  sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
  echo setup git
  sudo chmod +x /usr/share/doc/git/contrib/diff-highlight/diff-highlight
  sudo ln -s /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
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
# ここにインタラクティブな処理が入るので、CI上だったらスキップする
if [[ ${CI} != "true" ]]; then
  zsh -i -c exit
fi

echo setup neovim
nvim --headless -c 'qall'

echo setup tpm for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "run this command to change login shell"
echo "chsh -s $(which zsh)"
