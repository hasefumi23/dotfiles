FROM ubuntu:22.10

ENV DEBIAN_FRONTEND=noninteractive
# timezone setting
RUN apt-get update && apt-get install -y tzdata
ENV TZ=Asia/Tokyo

RUN apt-get update \
    && apt-get install -y \
    build-essential \
    curl \
    file \
    git \
    procps \
    sudo \
    vim \
    zsh

# install homebrew
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

RUN eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) && \
  brew install starship && \
  brew install zsh && \
  brew install fzf && \
  brew install neovim

RUN mkdir -p /var/dotfiles
WORKDIR /var/dotfiles
