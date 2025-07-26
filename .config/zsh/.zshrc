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
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && source ${ZDOTDIR:-$HOME}/.zstyles

#
# Theme
#
# Set prompt theme
# typeset -ga ZSH_THEME
# zstyle -a ':zephyr:plugin:prompt' theme ZSH_THEME ||
# ZSH_THEME=(starship mmc)

#
# Post libs
#
# Helpers for antidote.
is-theme-p10k()     { [[ "$ZSH_THEME" == (p10k|powerlevel10k)* ]] }
is-theme-starship() { [[ "$ZSH_THEME" == starship* ]] }

#
# Libs: Load antidote, history...
#
[[ -r ${ZDOTDIR:-$HOME}/lib ]] && for zlib in $ZDOTDIR/lib/*.zsh; source $zlib
unset zlib

#
# Prompt
#
setopt prompt_subst transient_rprompt
autoload -Uz promptinit && promptinit
# prompt "$ZSH_THEME[@]"

###############################################################################
###############################################################################
###############################################################################

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

# atac
export ATAC_MAIN_DIR=~/.config/atac

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

# tmux-cleanup-sessions() {
#   tmux list-sessions | grep -v attached | awk 'BEGIN{FS=\":\"}{print \"\$1\"}' | xargs -n 1 tmux kill-session -t 2>/dev/null || (echo 'Cleanup unattached sessions!' && tmux ls)
# }
# tmux-cleanup-windows() {
#   tmux list-windows | grep -v attached | awk 'BEGIN{FS=\":\"}{print $1}' | xargs -n 1 tmux kill-window -t 2>/dev/null || (echo 'Cleanup unattached windows!' && tmux ls)
# }

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
