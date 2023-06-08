# dotfiles

## Installation

```bash
# config and minimus packages
./bootstrap.sh

# install brew fomula
./brew.sh
```

## Docker

Dockerを使って、簡単に試行錯誤できるようにしている。  
このリポジトリに移動して、以下のコマンドを実行すると、sandbox環境のコンテナができる。  
作りとしては非常に単純で、ubuntu:22.10をベースにして、日本語化と最低限必要なパッケージとセットアップに時間がかかるパッケージをインストールしている。  
特に homebrew のインストールは、結構時間がかかるので、インストール済みの image にしている。  
カレントディレクトリを`/var/dotfiles`にマウントして、`/var/dotfiles`をワーキングディレクトリにしている。  
あとは、`./bootstrap.sh`や`./brew.sh`を実行するだけ。  

```sh
# imageを作って
docker build -t dotfiles-vm .

# 実行する
docker run -it --rm --name dotfiles-vm --mount type=bind,source="$(pwd)",target=/var/dotfiles -e CI=true dotfiles-vm \
    /bin/bash -c './bootstrap.sh && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) && ./brew.sh'

# コンテナに入って挙動を確認したいときは、コマンドの最後に `tail -f /dev/null` をつけるなどして、プロセスが終了しないようにする
docker run -it --rm --name dotfiles-vm --mount type=bind,source="$(pwd)",target=/var/dotfiles -e CI=true dotfiles-vm \
    /bin/bash -c './bootstrap.sh && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) && ./brew.sh && tail -f /dev/null'
```

## act

変な依存関係はないので、actを実行するだけ。

```bash
act
```
