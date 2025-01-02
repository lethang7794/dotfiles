#!/usr/bin/env zsh

# Load .zshenv from ZDOTDIR
export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
[[ -r $ZDOTDIR/.zshenv ]] && . $ZDOTDIR/.zshenv
