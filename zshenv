# vim ft:sh

ZDOTDIR=$HOME

# 'export' should presents, it allows env. variables to be used by other programms
export LANG=en_US.UTF-8
# make sure LC_CTYPE is not 'C' in order vim and others could determine russion for example
export LC_TIME=ru_UA.UTF-8
export LC_MONETARY=ru_UA.UTF-8

# comment file /etc/zsh/zprofile in ArchLinux
PATH=/bin:/usr/bin:/sbin:/usr/sbin

# local zshenv
[ -e $ZDOTDIR/.zshenv.local ] && source $ZDOTDIR/.zshenv.local

# ~/bin should be before any other path
[ -z "$HOME" ] || PATH=$HOME/bin:$PATH

export PATH
