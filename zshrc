# vim ft:sh

# utility functions
reload!() {
source $ZDOTDIR/.zshrc
}

# zle
bindkey -e
# setup zle color
# document zle marks,yank and paste

# local zshrc
[ -e $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local
