# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#
# Devbox
# Note: it has to come before common config as that needs devbox packages
if [[ "$(whoami)" == *agent* ]] && command -v devbox &> /dev/null; then
    eval "$(devbox global shellenv)"
fi

#
# Common Config
#
[ -f ~/.bash_shared ] && . ~/.bash_shared

#
# Agent Prompt
#
if [[ "$(whoami)" == *"agent"* ]]; then
    export PS1="\[${IPurple}\][ 🤖 AGENT:\[${IGreen}\]\w\[${IPurple}\]\$(__git_ps1 \" \[${Purple}\]{\[${Cyan}\]%s\[${Purple}\]}\")\[${IPurple}\] ]\$\[${Rst}\] "
fi

#
# Aliases
#
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#
# Emacs Tramp Mode Support
#
[[ $TERM == "dumb" ]] && PS1='$ '

#
# Direnv
#
eval "$(direnv hook bash)"

