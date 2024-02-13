# vim ft:sh

# utility functions
reload!() {
exec $SHELL
}

# custom completions
fpath=($ZDOTDIR/.zsh/completion $fpath)

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
source ~/.zsh/zsh-syntax-highlighting.zsh

# compsys
autoload -U compinit
compinit
# context string :completion:function:completer:command:argument:tag
# function - named function, typically blank
# completer - current completer function without leading `_` and with other underscores converted to hyphens. Defined how completion is to be performed, See the section `Control Functions' in zshcomsys man.
# command - or a special -context-, just at it appears following the #compdef tag or the compdef function.  Completion functions for commands that  have sub-commands usually modify this field to contain the name of the command followed by a minus sign and the sub-command.  For example, the completion function for the cvs command sets this field to cvs-add when completing arguments to the add subcommand.
# argument - this indicates which command line or option argument we are completing.  For command arguments this generally  takes  the  form argument-n,  where  n is the number of the argument, and for arguments to options the form option-opt-n where n is the number of the argument to option opt.
# tag - used to discriminate between the types of matches a completion function can generate in a certain context.  Any completion function may use any tag name it likes, but a list of the more common ones is given below.
# zstyle ':completion:function:completer:command:argument:tag' style style-options
zstyle ':completion:*:default' menu select=3
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# aliases

alias ssh='TERM=xterm-256color ssh'

# file system listing commands
case $(uname) in
  Linux)
    alias ls='ls --color=always -h'
    ;;
  Darwin)
    alias ls='ls -G -h'
    ;;
esac
alias ll='ls -l'
alias la='ls -la'
alias dir='dir --color=auto -h -p'
alias vdir='vdir --color=auto -h -p'
alias t='tree'

alias df='df -h'
alias du='du -h'

alias -g L='| less'

alias -g H='--help 2>&1 | less'

alias grep='noglob grep --color=auto'
alias -g G='| grep'
alias -g Wc='| wc'
alias -g Xargs='| xargs'
alias -g Gsed='| xargs gsed'

alias find='noglob find'
alias task='noglob task'
alias rake='noglob rake'
alias dpkg='noglob dpkg'
alias gem='noglob gem'
alias ansible='noglob ansible'
alias git='noglob git'

alias pgrep='pgrep -l -f'
alias tmux='tmux -2'

alias c++17='c++ -std=gnu++17 -g -Wall -Wextra -pedantic'

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
# the \033]7;file://localhost/${PWD}\033\\ are escape sequences to advise the terminal of the working directory
PS1=$'\033]7;file:///${PWD}\033\\%B[%b%F{green}%n%f%B%F{white}@%f%b%F{green}%m%f %F{yellow}%~%f%B]%b ${vcs_info_msg_0_}%E\n%F{red}%(?..%?)%f %B%(!.%F{red}.%F{magenta})%#%f%b%E '
RPS1=$'%1(j.[%j].) %F{green}%T%f'
# VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats \
  '%s:%F{magenta}[%f%F{green}%b%f%F{red}|%a%f%F{magenta}]%f'
zstyle ':vcs_info:*' formats       \
  '%s:%F{magenta}[%f%F{green}%b%f%F{magenta}]%f'

# --- libnotify notifications for high duration commands ---

# notification initialization:
_current_cmd=""
_current_cmd_start_time=0
_long_running_cmd=60 # 1 minute

# should be called from preexec hook in following form:
__user_notification_save_start_time() {
  _current_cmd_start_time="`date +%s`"
  _current_cmd="$1"
}

# should be called first in precmd hook
__user_notification_notify() {
  local exit_status=$?
  if [[ ( -n $_current_cmd ) && ( $((`date +%s`-_current_cmd_start_time)) -ge $_long_running_cmd ) ]]; then
    __user_notification_perform $exit_status $_current_cmd
  fi
  _current_cmd=""
}

__user_notification_perform() {
  local exit_status=$1
  local body="'$2'"
  local summary="Z shell - $TTY"
  local icon

  if [[ $exit_status -eq 0 ]]; then
    body="$body SUCCESS"
    icon="finish"
  else
    body="$body FAILURE"
    icon="stop"
  fi

  case $(uname) in
    Linux)
      # keep notification for 20 seconds, could not work for some reason
      notify-send -t 20000 -i $icon -a zsh $summary $body
      ;;
    Darwin)
      osascript -e "$(cat <<eof
display notification "$body" with title "$summary" sound name "Glass"
eof
)"
      ;;
  esac
}

__user_term_title_dir="%1~"
__user_term_title_pts="%y%1(j.:%j.)"
__user_set_xterm_title() {
  case $TERM in
    xterm*)
      print -Pn "\e]0;$__user_term_title_dir($__user_term_title_pts)\a"
      ;;
  esac
}
__user_set_xterm_title_for_cmd() {
  local cmd="$1"

  case $TERM in
    xterm*)
      print -Pn "\e]0;($__user_term_title_dir) %20>..>$cmd%<< \a"
      ;;
  esac
}

# sends actual notification
# usage:
# send-notification exit_status 'command being executed'

# --- end of libnotify notifications for high duration commands ---

# bundler

__user_chpwd_bundler() {
  if [[ -d $PWD/bin && $PWD != $HOME ]] {
    PATH=$PWD/bin:${PATH#$PWD/bin:}
  } elif [[ $OLDPWD != $HOME ]] {
    PATH=${PATH#$OLDPWD/bin:}
  }
}

#chpwd_functions=(__user_chpwd_bundler)

# hooks
# executed before each prompt
precmd() {
  __user_notification_notify
  __user_set_xterm_title

  vcs_info
}
# executed just after a command has been read and is about to be executed
preexec() {
  __user_notification_save_start_time "$1"
  __user_set_xterm_title_for_cmd "$1"
}

autoload -U add-zsh-hook

# 1password cli
if [[ -x /usr/local/bin/op ]]; then
  eval "$(op completion zsh)"; compdef _op op
fi

# local zshrc
[ -e $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local || :

PYTHONSTARTUP=$HOME/.pythonrc
[ -f "$PYTHONSTARTUP" ] && export PYTHONSTARTUP

# ~/bin should be before any other path (but only in interactive shell)
__user_path_prepend ~/bin
