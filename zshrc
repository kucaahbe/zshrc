# vim ft:sh

# utility functions
reload!() {
source $ZDOTDIR/.zshrc
}

# local zshrc
[ -e $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local
