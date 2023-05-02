FROM ubuntu:22.10

# ENV DEBIAN_FRONTEND=noninteractive
# timezone setting
RUN apt-get update && apt-get install -y tzdata
ENV TZ=Asia/Tokyo

RUN apt-get update \
    && apt-get install -y \
    curl \
    git \
    vim \
    zsh \
    sudo

RUN mkdir -p /var/dotfiles
WORKDIR /var/dotfiles
