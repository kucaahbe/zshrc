#!/bin/zsh

ZSHDIR=$HOME/.zsh

if [ ! -L $ZSHDIR -a \( -d $ZSHDIR -o -f $ZSHDIR \) ]; then
  echo file $ZSHDIR exists, please remove it
  exit 1
fi

# on linux ln symlinks directories
# in some strange manner if destination exists
[ -L $ZSHDIR ] && rm -v $ZSHDIR
ln -svf $PWD/zsh $ZSHDIR
ln -svf $PWD/zshenv ~/.zshenv
ln -svf $PWD/zprofile ~/.zprofile
ln -svf $PWD/zshrc ~/.zshrc
ln -svf $PWD/zlogin ~/.zlogin
ln -svf $PWD/zlogout ~/.zlogout
# LS_COLORS
ln -svf $PWD/LS_COLORS/LS_COLORS ~/.ls_colors
