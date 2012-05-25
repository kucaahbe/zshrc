# vim ft:sh

# utility functions
reload!() {
source $ZDOTDIR/.zshrc
}

# zle
bindkey -e
# setup zle color
# document zle marks,yank and paste

# compsys
autoload  -U compinit
compinit
# context string :completion:function:completer:command:argument:tag
# function - named function, typically blank
# completer - curent completer function without leading `_` and with other underscores converted to hyphens. Defined how completion is to be performed, See the section `Control Functions' in zshcomsys man.
# command - or a special -context-, just at it appears following the #compdef tag or the compdef function.  Completion functions for commands that  have sub-commands usually modify this field to contain the name of the command followed by a minus sign and the sub-command.  For example, the completion function for the cvs command sets this field to cvs-add when completing arguments to the add subcommand.
# argument - this indicates which command line or option argument we are completing.  For command arguments this generally  takes  the  form argument-n,  where  n is the number of the argument, and for arguments to options the form option-opt-n where n is the number of the argument to option opt.
# tag - used to discriminate between the types of matches a completion function can generate in a certain context.  Any completion function may use any tag name it likes, but a list of the more common ones is given below.
# zstyle ':completion:function:completer:command:argument:tag' style style-options
zstyle ':completion:*:default' menu select=3

# local zshrc
[ -e $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local
