#!/usr/bin/env bash

set -e
sudo -v

if [ "$(uname -s)" == "Linux" ]
then

# brew doctor

brew update
brew upgrade

brew install ag
# brew install ansible
brew install anyenv
brew install autossh
brew install awscli
brew install coreutils
brew install ctags
brew install direnv
brew install figlet
brew install fish
brew install gibo
brew install gcc
# brew install git
# brew install git-extras
brew install ghq
brew install hub
brew install imagemagick
brew install jq
brew install jpeg
brew install libpng
brew install libxml2
brew install libxslt
brew install libyaml
brew install libevent
brew install libmpc
brew install mcrypt
brew install mongodb
brew install mpfr
brew install mercurial
brew install memcached
brew install mysql
brew install nginx
brew install nkf
brew install openssl
brew install ossp-uuid
brew install postgresql
brew install pkgconfig
brew install q
brew install qt@5.5
brew install readline
brew install redis
brew install ripgrep
brew install rmtrash
brew install sqlite
brew install socat
brew install tree
brew install thefuck
brew install tmux
brew install unixodbc
brew install unar
brew install lua
brew install vim --with-lua
brew install w3m
brew install wget
brew install yarn
brew install zsh

brew link --force qt@5.5

brew cleanup

fi
