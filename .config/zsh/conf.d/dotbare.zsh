#!/usr/bin/env bash
#
# dotbare: Configure dotbare.
#
# https://github.com/kazhala/dotbare

if [ ! "$(command -v dotbare)" ]; then
  return 1
fi

export DOTBARE_DIR="$HOME/.dotfiles"
