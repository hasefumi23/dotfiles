#!/usr/bin/env bash

set -e

brew update
brew upgrade

fomulas=(
  act
  actionlint
  anyenv
  bat
  curl
  exa
  fd
  fzf
  gh
  ghq
  git-delta
  git-now
  git-secrets
  gron
  httpie
  jpeg
  jq
  kubernetes-cli
  lazygit
  itchyny/tap/mmv
  navi
  neovim
  ripgrep
  starship
  terraformer
  tfenv
  tflint
  tfsec
  unzip
  zip
  zsh
)

brew install ${fomulas[@]}

brew cleanup
