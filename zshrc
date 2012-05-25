# vim ft:sh

# utility functions
reload!() {
source $ZDOTDIR/.zshrc
}

# ZLE
bindkey -e

# local zshrc
[ -e $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local
