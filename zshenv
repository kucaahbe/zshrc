# vim ft:sh

ZDOTDIR=$HOME

export LC_ALL=en_US.UTF-8 # for OSX
export LANG=en_US.UTF-8
# make sure LC_CTYPE is not 'C' in order to vim and others could determine russian for example
# on ubuntu: apt-get install language-pack-ru language-pack-ru-base
export LC_TIME=ru_UA.UTF-8
export LC_MONETARY=ru_UA.UTF-8

# comment file /etc/zsh/zprofile in ArchLinux
PATH=/bin:/usr/bin:/sbin:/usr/sbin

# ~/bin should be before any other path
[ -z "$HOME" ] || PATH=$HOME/bin:$PATH

export PATH

# OS  specific zshenvs
case "$(uname)" in
  ("Darwin")
    source ~/.zshenv.osx
    ;;
  ("Linux")
    source ~/.zshenv.linux
    ;;
esac

# local zshenv
[ -e $ZDOTDIR/.zshenv.local ] && source $ZDOTDIR/.zshenv.local

export EDITOR

export PYTHONSTARTUP=$HOME/.pythonrc
