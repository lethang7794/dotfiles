#!/usr/bin/env bash
#
# nav: Configure nav.
#
# https://github.com/betafcc/nav/

if command -v gitop &>/dev/null; then
  zle -N gitop            # Define gitop as a new widget
  bindkey '^[[1;4A' gitop # alt + shift + up
fi

if command -v yy &>/dev/null; then
  zle -N yy            # Define yy as a new widget
  bindkey '^[[1;3B' yy # alt + down
fi

bindkey '^[[1;3A' nav-up      # alt + up
bindkey '^[[1;3C' nav-forward # alt + right
bindkey '^[[1;3D' nav-back    # alt + left
