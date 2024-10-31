#!/usr/bin/env bash

##
## .zshrc - Run on interactive Zsh session.
##

# shellcheck disable=SC2155,SC1090

#
# Profiling
#

[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

#
# Zstyles
#

# Load .zstyles file with customizations.
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && source ${ZDOTDIR:-$HOME}/.zstyles

#
# Theme
#

# Set prompt theme
# typeset -ga ZSH_THEME
# zstyle -a ':zephyr:plugin:prompt' theme ZSH_THEME ||
# ZSH_THEME=(starship mmc)

# Set helpers for antidote.
is-theme-p10k()     { [[ "$ZSH_THEME" == (p10k|powerlevel10k)* ]] }
is-theme-starship() { [[ "$ZSH_THEME" == starship* ]] }

#
# Libs
#

# Load things from lib.
[[ -r ${ZDOTDIR:-$HOME}/lib ]] && for zlib in $ZDOTDIR/lib/*.zsh; source $zlib
unset zlib

#
# Aliases
#

[[ -r ${ZDOTDIR:-$HOME}/.zaliases ]] && source ${ZDOTDIR:-$HOME}/.zaliases

#
# Completions
#

# Uncomment to manually initialize completion system, or let Zephyr
# do it automatically in the zshrc-post hook.
ZSH_COMPDUMP=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump
[[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h
autoload -Uz compinit && compinit -i -d $ZSH_COMPDUMP

#
# Prompt
#
setopt prompt_subst transient_rprompt
autoload -Uz promptinit && promptinit
# prompt "$ZSH_THEME[@]"

###############################################################################
###############################################################################
###############################################################################

## Brew
HOMEBREW_BIN=/home/linuxbrew/.linuxbrew/bin/brew
if [ -f "$HOMEBREW_BIN" ]; then
  eval "$($HOMEBREW_BIN shellenv)"

  # Brew auto-update
  export HOMEBREW_AUTO_UPDATE_SECS="86400"
fi

## fzf-mark
export FZF_MARKS_JUMP="^[g"

# TODO: load brew completions after:
# - /usr/share/zsh/site-functions                                                                                                                                         ││
# - /usr/share/zsh/5.9/functions
#
# Brew completions

## Completions from command
# cached-eval 'kubeadm' kubeadm completion zsh

## AWS https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-linux
# complete -C "$(which aws_completer)" aws
# complete -C "$HOME/.local/share/mise/installs/awscli/latest/bin/aws_completer" aws

## Brew
if [ -f "$HOMEBREW_BIN" ]; then
  HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
  if [ -f "$HB_CNF_HANDLER" ]; then
    source "$HB_CNF_HANDLER"
  fi
fi

# Walk https://github.com/antonmedv/walk
export WALK_REMOVE_CMD=trash
function lk {
  cd "$(walk --icons --fuzzy --preview "$@")" || exit
}

# atac
export ATAC_MAIN_DIR=~/.config/atac

## Kubernetes
if [ "$(command -v kubecolor)" ]; then
  alias kubectl="kubecolor"
  compdef kubecolor=kubectl
fi

mk_running=$(minikube status | grep Running | wc -l)
((mk_running > 0)) && export MINIKUBE="Running"

# Go cover https://dave.cheney.net/2013/11/14/more-simple-test-coverage-in-go-1-2
go-cover() {
  t=$(mktemp)
  go test "$COVERFLAGS" -coverprofile="$t" "$@" && go tool cover -func="$t" && unlink "$t"
}
go-cover-web() {
  t=$(mktemp)
  go test "$COVERFLAGS" -coverprofile="$t" "$@" && go tool cover -html="$t" && unlink "$t"
}

# tmux
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

tmux-cleanup-sessions() {
  tmux list-sessions | grep -v attached | awk 'BEGIN{FS=\":\"}{print \"\$1\"}' | xargs -n 1 tmux kill-session -t 2>/dev/null || (echo 'Cleanup unattached sessions!' && tmux ls)
}
tmux-cleanup-windows() {
  tmux list-windows | grep -v attached | awk 'BEGIN{FS=\":\"}{print $1}' | xargs -n 1 tmux kill-window -t 2>/dev/null || (echo 'Cleanup unattached windows!' && tmux ls)
}

# alias open=xdg-open # Linux
function open() {
  handlr open "$@"
}

timezsh() {
  shell=${1-$SHELL}
  # shellcheck disable=SC2034
  for i in $(seq 1 10); do /usr/bin/time "$shell" -i -c exit; done
}

# Temp workaround to disable punycode deprecation logging to stderr
# https://github.com/bitwarden/clients/issues/6689
alias bw='NODE_OPTIONS="--no-deprecation" bw'

###############################################################################
###############################################################################
###############################################################################

#
# Wrap up
#

# Never start in the root file system. Looking at you, Zed.
[[ "$PWD" != "/" ]] || cd

# Manually call post_zshrc to bypass the hook
(( $+functions[run_post_zshrc] )) && run_post_zshrc

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC

# Always return success
true