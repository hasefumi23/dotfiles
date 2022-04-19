#!/usr/bin/env bash

# symlinks
PWD=`pwd`
DOTFILES=`ls -a`
IGNOREFILES=( . .. backup bootstrap.sh brew.sh .config README.md .git .gitignore .vim alacritty.yml profile.json )

BACKUPTIME=`date +%F-%H%M%S`

BACKUPDIR="${PWD}/backup/${BACKUPTIME}"

for DOTFILE in ${DOTFILES[@]}
do
  for IGNOREFILE in ${IGNOREFILES[@]}
  do
    if [ ${DOTFILE} == ${IGNOREFILE} ]
    then
      continue 2
    fi
  done

  SYMLINK="${HOME}/${DOTFILE}"
  if [ ! -d ${BACKUPDIR} ]
  then
    mkdir -p ${BACKUPDIR}
  fi

  if [ -f ${SYMLINK} ] && [ ! -L ${SYMLINK} ]
  then
    cp -pfa ${SYMLINK} ${BACKUPDIR}
    echo "Move: ${BACKUPDIR}/${SYMLINK}"
  fi

  if [ ! -L ${SYMLINK} ] || [ ! -e ${SYMLINK} ]
  then
    echo "Link: ${PWD}/${DOTFILE} => ${SYMLINK}"
    rm -Rf ${SYMLINK}
    ln -fs ${PWD}/${DOTFILE} ${SYMLINK}
  fi
done

# for .config/fish directory
FISHDIR=${HOME}/.config/fish
mkdir -p ${BACKUPDIR}/.config
if [ -d ${FISHDIR} ]
then
  cp -pfar ${FISHDIR} ${BACKUPDIR}/.config
  echo "Move: ${BACKUPDIR}${FISHDIR}"
fi

echo "Link: ${PWD}/.config/fish => ${FISHDIR}"
rm -Rf ${FISHDIR}
ln -fs ${PWD}/.config/fish ${HOME}/.config

# neovim config
ln -fs ${PWD}/.vimrc ~/.config/nvim/init.vim

# starship
ln -fs ${PWD}/starship.toml ~/.config/starship.toml

# for vim plugin config
VIMDIR=${HOME}/.vim/rc
mkdir -p ${BACKUPDIR}/.vim
if [ -d ${VIMDIR} ]; then
  cp -pfar ${VIMDIR} ${BACKUPDIR}/.vim
  echo "Move: ${BACKUPDIR}/.vim/rc"
fi

mkdir -p ~/.vim
rm -Rf ${VIMDIR}/rc
ln -fs ${PWD}/.vim/rc ~/.vim

