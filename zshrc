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
# completer - current completer function without leading `_` and with other underscores converted to hyphens. Defined how completion is to be performed, See the section `Control Functions' in zshcomsys man.
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

alias -g L='| less'

alias -g H='-h | less'
alias -g He='--help | less'

alias grep='grep --color=auto'
alias -g G='| grep'

alias gt='git'

alias find='noglob find'
alias task='noglob task'
alias rake='noglob rake'

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
HISTFILE=$ZDOTDIR/.zhistory
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
# keyboard
#KEYBOARD_HACK='\' # to replace annoying characters from the end of commandline
# chars that are part of the word, default: '*?_-.[]~=/&;!#$%^(){}<>' (removed "/")
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# zsh prompt
setopt PROMPT_SUBST
PS1=$'%B[%b%F{green}%n%f%B%F{white}@%f%b%F{green}%m%f %F{yellow}%~%f%B]%b ${vcs_info_msg_0_}\n%F{red}%(?..%?)%f %B%(!.%F{red}.%F{magenta})%#%f%b%E '
RPS1=$'%1(j.[%j].) %F{green}%T%f'
# VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats \
  '%s:%F{magenta}[%f%F{green}%b%f%F{red}|%a%f%F{magenta}]%f'
zstyle ':vcs_info:*' formats       \
  '%s:%F{magenta}[%f%F{green}%b%f%F{magenta}]%f'

# hooks
# set xterm title
term_title_dir="%1~"
term_title_pts="%y%1(j.:%j.)"
precmd() {
  case $TERM in
    xterm*)
      print -Pn "\e]0;$term_title_dir - $term_title_pts\a"
      ;;
  esac

  vcs_info
}
preexec() {
  case $TERM in
    xterm*)
      print -Pn "\e]0;($term_title_dir) %20>..>$1%<< \a"
      ;;
  esac
}

# local zshrc
[ -e $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local
