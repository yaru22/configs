#
# Colorful Terminal
#
source ~/.bash_colors
# Non-printing character has to be wrapped in \[ and \].
export PS1="\[${Yellow}\][ \u@\H:\[${Green}\]\w\[${Yellow}\]\$(__git_ps1 \" \[${Purple}\]{\[${Cyan}\]%s\[${Purple}\]}\")\[${Yellow}\] ]\$\[${Rst}\] "
export TERM="xterm-256color"

#
# Aliases
#
source ~/.bash_aliases

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
# Enable ctrl-s (forward history search).
stty -ixon
# This is super useful for navigating through history.
# Just write initial letters and press "up" and/or "down" arrow
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

#
# Flutter
#
PATH=~/workspace/flutter/bin:$PATH

#
# Git
#
# NOTE: brew install git bash-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

export GIT_PS1_SHOWDIRTYSTATE="1"
. ~/.git-prompt.sh

#
# Go Lang
#
export GOPATH=~/.go:~/workspace/go
export GOBIN=~/.go/bin
PATH=$GOBIN:$PATH

#
# Haskell
#
PATH=~/.cabal/bin:$PATH

#
# Node.js
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

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
# Wasmer
#
export WASMER_DIR="$HOME/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

#
# Modern Shell Utilities (Zoxide, FZF)
#
# brew install zoxide fzf
if [ -d "/usr/local/opt/fzf/shell" ]; then
  source "/usr/local/opt/fzf/shell/completion.bash"
  source "/usr/local/opt/fzf/shell/key-bindings.bash"
fi
command -v zoxide &> /dev/null && eval "$(zoxide init bash)"

#
# Direnv
#
# NOTE: brew install direnv
# NOTE: The following has to be placed at the end of bash_profile.
eval "$(direnv hook bash)"
# Restoring the PS1: https://github.com/direnv/direnv/wiki/Python
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
export -f show_virtual_env
PS1='$(show_virtual_env)'$PS1

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
# Bun
#
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

#
# pnpm
#
export PNPM_HOME="/Users/brianpark/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

