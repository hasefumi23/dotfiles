#!/usr/bin/env bash

set -e

brew update
brew upgrade

fomulas=(
  act
  actionlint
  anyenv
  argo
  bat
  curl
  exa
  eza
  fd
  fzf
  gh
  ghq
  git
  git-delta
  git-now
  git-secrets
  gron
  helmfile
  httpie
  itchyny/tap/mmv
  jpeg
  jq
  krew
  kubectx
  kubernetes-cli
  lazygit
  navi
  neovim
  python@3.11
  ripgrep
  starship
  terraformer
  tfenv
  tflint
  tfsec
  tig
  tmux
  unzip
  yazi
  zip
  zsh
)

brew install ${fomulas[@]}

brew cleanup

