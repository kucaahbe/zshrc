#!/bin/zsh

ln -svf -T $PWD/zsh ~/.zsh
ln -svf $PWD/zshenv ~/.zshenv
ln -svf $PWD/zprofile ~/.zprofile
ln -svf $PWD/zshrc ~/.zshrc
ln -svf $PWD/zlogin ~/.zlogin
ln -svf $PWD/zlogout ~/.zlogout
# LS_COLORS
ln -svf $PWD/LS_COLORS/LS_COLORS ~/.ls_colors
