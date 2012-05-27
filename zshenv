# vim ft:sh
ZDOTDIR=$HOME

# 'export' should presents, it allows env. variables to be used by other programms
export LANG=en_US.UTF-8

# comment file /etc/zsh/zprofile in ArchLinux
PATH=/bin:/usr/bin

# local zshenv
[ -e $ZDOTDIR/.zshenv.local ] && source $ZDOTDIR/.zshenv.local

# ~/bin should be before any other path
export PATH=$HOME/bin:$PATH
