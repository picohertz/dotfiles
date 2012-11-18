#!/bin/sh
SRC=${HOME}/.dotfiles
FILES="vim vimrc zshrc"

cd ${SRC} && git pull

for file in $FILES; do
  if [ -L ${HOME}/.${file} ]; then
    continue
  fi
  if [ -f ${HOME}/.${file} ] || [ -d ${HOME}/.${file} ]; then
    mv ${HOME}/.${file} ${HOME}/.${file}.`date +%Y%m%d%H%M%S`
  fi
    ln -s ${SRC}/${file} ${HOME}/.${file}
done
