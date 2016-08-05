#!/bin/sh

echo "Command to be run is:"
cat file_list | xargs -I % echo cp --backup=numbered % ~
read -p "Copy all dotfiles to ~?" -n 1 -r
echo #newline
if [[ $REPLY =~ ^[Yy] ]]
then
echo "Copying"
cat file_list | xargs -I % echo cp --backup=numbered % ~
#cat file_list | xargs -I % cp --backup=numbered % ~
else
echo "Skipping"
fi

read -p "Clone vundle to ~/.vim/bundle/?" -n 1 -r
echo #newline
if [[ $REPLY =~ ^[Yy] ]]
then
echo "Cloning"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
echo "Skipping"
fi


