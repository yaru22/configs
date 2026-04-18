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
# Colorful Terminal
#
source ~/.bash_colors
# Non-printing character has to be wrapped in \[ and \].
export PS1="${debian_chroot:+($debian_chroot)}\[${Yellow}\][ \u@\H:\[${Green}\]\w\[${Yellow}\]\$(__git_ps1 \" \[${Purple}\]{\[${Cyan}\]%s\[${Purple}\]}\")\[${Yellow}\] ]\$\[${Rst}\] "
export TERM="xterm-256color"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#
# Aliases
#
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#
# Custom Scripts
#
PATH=~/bin:$PATH

#
# Emacs
#
PATH=~/.emacs.d/bin:$PATH

#
# History
#
# No dup commands in history.
export HISTCONTROL=ignoreboth:erasedups
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# Enable ctrl-s (forward history search).
stty -ixon
# This is super useful for navigating through history.
# Just write initial letters and press "up" and/or "down" arrow
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

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
# Git
#
export GIT_PS1_SHOWDIRTYSTATE="1"
[ -f ~/.git-prompt.sh ] && . ~/.git-prompt.sh
[ -f ~/.git-completion.sh ] && . ~/.git-completion.sh

#
# Node.js
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
# Python / uv
#
if command -v uv &> /dev/null; then
    eval "$(uv generate-shell-completion bash)"
fi

#
# Perl
#
if [ -d "$HOME/perl5" ]; then
    export PATH="$HOME/perl5/bin${PATH:+:${PATH}}"
    export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
    export PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
    export PERL_MB_OPT="--install_base \"$HOME/perl5\""
    export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
fi

#
# Modern Shell Utilities (Zoxide, FZF)
#
# sudo apt install zoxide fzf
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && . /usr/share/doc/fzf/examples/key-bindings.bash
[ -f /usr/share/doc/fzf/examples/completion.bash ] && . /usr/share/doc/fzf/examples/completion.bash
command -v zoxide &> /dev/null && eval "$(zoxide init bash)"

#
# Direnv
#
eval "$(direnv hook bash)"

#
# Bun
#
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

#
# pnpm
#
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

#
# Emacs Tramp Mode Support
#
[[ $TERM == "dumb" ]] && PS1='$ '
