#!/usr/bin/env bash

set -e
sudo -v

if [ "$(uname -s)" == "Linux" ]
then

brew doctor

brew update
brew upgrade

brew install ag
brew install anyenv
brew install autossh
brew install awscli
brew install coreutils
brew install ctags
brew install denisidoro/tools/navi
brew install direnv
brew install dos2unix
brew install exa
brew install fd
brew install figlet
brew install fish
brew install fzf
brew install gcc
brew install github/gh/gh
brew install ghq
brew install gibo
brew install git-extras
brew install git-now
brew install git-delta
brew install guumaster/tap/hostctl
brew install highlight
brew install hub
brew install jpeg
brew install jq
brew install libevent
brew install libffi
brew install libmpc
brew install libpng
brew install libxml2
brew install libxslt
brew install libyaml
brew install lua
brew install mcrypt
brew install mercurial
brew install mpfr
brew install ncurses
brew install nkf
brew install openssl
brew install patchelf
brew install pcre2
brew install peco
brew install pkgconfig
brew install postgresql
brew install pv
brew install python
brew install q
brew install readline
brew install ripgrep
brew install socat
brew install thefuck
brew install tig
brew install tmux
brew install tree
brew install unixodbc
brew install unzip
brew install vim
brew install nvim
brew install w3m
brew install wget
brew install xz
brew install yarn
brew install zlib
brew install zsh

brew tap cjbassi/gotop
brew install gotop

brew cleanup

fi
