# vim ft:sh
ZDOTDIR=$HOME

# comment file /etc/zsh/zprofile in ArchLinux
PATH=/bin:/usr/bin

# local zshenv
[ -e $ZDOTDIR/.zshenv.local ] && source $ZDOTDIR/.zshenv.local

# ~/bin should be before any other path
export PATH=$HOME/bin:$PATH
