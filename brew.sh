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
brew install direnv
brew install dos2unix
brew install figlet
brew install fish
brew install fzf
brew install gibo
brew install gcc
brew install ghq
brew install hub
brew install jq
brew install jpeg
brew install libpng
brew install libxml2
brew install libxslt
brew install libyaml
brew install libevent
brew install libmpc
brew install mcrypt
brew install mpfr
brew install mercurial
brew install nkf
brew install openssl
brew install postgresql
brew install pkgconfig
brew install q
brew install readline
brew install ripgrep
brew install socat
brew install tree
brew install thefuck
brew install tig
brew install tmux
brew install unixodbc
brew install vim
brew install w3m
brew install wget
brew install yarn
brew install zsh

brew cleanup

fi
