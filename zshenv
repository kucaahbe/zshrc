# vim ft:sh

# unique path array (tied with PATH):
typeset -U path

__user_path_prepend() {
  local dir="$1"
  [ -d "$dir" ] && path=("$dir" "$path[@]")
}

__user_path_append() {
  local dir="$1"
  [ -d "$dir" ] && path+=("$dir")
}

ZDOTDIR=$HOME

export LC_ALL=en_US.UTF-8 # for OSX
export LANG=en_US.UTF-8
# make sure LC_CTYPE is not 'C' in order to vim and others could determine russian for example
# on ubuntu: apt-get install language-pack-ru language-pack-ru-base
export LC_TIME=ru_UA.UTF-8
export LC_MONETARY=ru_UA.UTF-8

# OS-specific zshenvs
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

__user_path_prepend /sbin
__user_path_prepend /usr/sbin
__user_path_prepend /bin
__user_path_prepend /usr/bin

export EDITOR
