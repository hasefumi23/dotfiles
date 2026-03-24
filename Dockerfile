FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list

# timezone setting
RUN apt update && apt install -y tzdata
ENV TZ=Asia/Tokyo

RUN apt update \
    && apt install -y \
    build-essential \
    curl \
    file \
    git \
    procps \
    sudo \
    vim \
    zsh

# 非rootユーザーの作成（homebrew用）
RUN useradd -m -s /bin/bash linuxbrew \
    && echo "linuxbrew ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER linuxbrew

# install homebrew
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

RUN eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) && \
  brew install starship && \
  brew install zsh && \
  brew install fzf && \
  brew install neovim

USER root

RUN mkdir -p /var/dotfiles
WORKDIR /var/dotfiles

CMD ["/bin/bash"]
