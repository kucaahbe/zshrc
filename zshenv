# vim ft:sh

ZDOTDIR=$HOME

if [ -e /etc/locale.conf ]; then
  source /etc/locale.conf
else
  LANG=en_US.UTF-8
fi
# 'export' should presents, it allows env. variables to be used by other programms
export LANG
export LC_CTYPE
export LC_NUMERIC
export LC_TIME
export LC_COLLATE
export LC_MONETARY
export LC_MESSAGES
export LC_PAPER
export LC_NAME
export LC_ADDRESS
export LC_TELEPHONE
export LC_MEASUREMENT
export LC_IDENTIFICATION
export LC_ALL

# comment file /etc/zsh/zprofile in ArchLinux
PATH=/bin:/usr/bin:/sbin:/usr/sbin

# local zshenv
[ -e $ZDOTDIR/.zshenv.local ] && source $ZDOTDIR/.zshenv.local

# ~/bin should be before any other path
[ -z "$HOME" ] || PATH=$HOME/bin:$PATH

export PATH
