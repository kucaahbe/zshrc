# vim ft:sh

# utility functions
reload!() {
source $ZDOTDIR/.zshrc
}

# zle
bindkey -e
# setup zle color
zle_highlight=(
  default:fg=cyan,bg=default,bold
  isearch:fg=green,bg=default,standout
  region:fg=cyan,bg=default,bold,standout
  suffix:fg=default,bg=default,standout
  special:fg=red,bg=default,bold
  )

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

# aliases
#coolls() {
#  ls --color=always -h $* | less
#}
alias ls='ls --color=always -h'
alias ll='ls -l'
alias la='ls -la'

alias df='df -h'
alias du='du -h'

alias -g Less='| less'

alias -g H='-h | less'
alias -g Help='--help | less'

alias grep='grep --color=auto --line-number'
alias -g Grep='| grep'

# environment variables and zsh parameters
export LESS='--no-init --quit-if-one-screen --ignore-case --RAW-CONTROL-CHARS --chop-long-lines'
# coloring man pages for `less`
export LESS_TERMCAP_mb=$'\E[01;31m'      # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'      # begin bold
export LESS_TERMCAP_me=$'\E[0m'          # end mode
export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'   # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'          # end underline
export LESS_TERMCAP_us=$'\E[01;32m'      # begin underline
# editor
if [ -n $DISPLAY ]
then
  EDITOR=gvim
else
  EDITOR=vim
fi
export EDITOR
# history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
# zsh prompt

# local zshrc
[ -e $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local
