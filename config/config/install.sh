#!/bin/bash
cwd=`pwd`
ln -s $cwd/.gitconfig $HOME/.gitconfig
ln -s $cwd/.bashrc $HOME/.bashrc
ln -s $cwd/.bash_profile $HOME/.bash_profile
ln -s $cwd/.alias $HOME/.alias
ln -s $cwd/.screenrc $HOME/.screenrc
ln -s $cwd/.vimrc $HOME/.vimrc

mkdir $HOME/bin
