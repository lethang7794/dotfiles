#!/usr/bin/env zsh
#
# homebrew: Configure homebrew.
#
# https://brew.sh/

## Brew
HOMEBREW_BIN=/home/linuxbrew/.linuxbrew/bin/brew
if [ ! -f "$HOMEBREW_BIN" ]; then
  return
fi

# Brew auto-update
export HOMEBREW_AUTO_UPDATE_SECS="86400"

# Instead of running 'eval "$($HOMEBREW_BIN shellenv)"'
# - manually set the environment variables to have control over PATH
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"
# fpath[1,0]="/home/linuxbrew/.linuxbrew/share/zsh/site-functions";
# export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}";

# Add brewed Zsh to fpath
if [[ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]]; then
  fpath+=("$HOMEBREW_PREFIX/share/zsh/site-functions")
fi

# Set up homebrew-command-not-found as command-not-found-handler
HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER"
fi
