#!/usr/bin/env bash
#
# atuin: Configure atuin.
#

# https://github.com/atuinsh/atuin
if (( $+commands[atuin] )); then
  export ATUIN_NOBIND="true"
  cached-eval 'atuin-init-zsh' atuin init zsh

  bindkey '^r' atuin-search

  bindkey '^[[A' atuin-up-search
  bindkey '^[OA' atuin-up-search
fi
