#!/usr/bin/env zsh

# Load .zshenv from ZDOTDIR
export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
[[ -r $ZDOTDIR/.zshenv ]] && . $ZDOTDIR/.zshenv

# print "🪝$0: loading .zshenv"
# if [[ -o login ]]; then
#   print "  Login shell"
# else
#   print "  Not a login shell"
# fi
# if [[ -o interactive ]]; then
#   print "  Interactive shell"
# else
#   print "  Not an interactive shell"
# fi

## Environment variables https://wiki.archlinux.org/title/Environment_variables
# XDG https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"

# Editor
export EDITOR="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"

# Ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/rc"

# fd
# export FD_IGNORE_PATH="$XDG_CONFIG_HOME/fd/ignore" # fd always looks at this location

# lazygit
export LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/themes/macchiato/teal.yml"
export LAZYGIT_NEW_DIR_FILE="$ZSH_CACHE_DIR/lazygit/newdir"

# Bat
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/config"
export BAT_THEME="Catppuccin Macchiato" # Use by other apps

# gobrew: Golang version manager
export GOROOT="$HOME/.gobrew/current/go"

# rip2: a safer rm (not compatible with XDG Trash Spec)
# export RIP_GRAVEYARD="$XDG_DATA_HOME/Trash" # ~/.local/share/Trash

## Setup PATH
export PATH="$HOME/go/bin:$PATH"                                # Golang's binary
export PATH="$HOME/.gobrew/current/bin:$HOME/.gobrew/bin:$PATH" # gobrew

## Other setup
# Cargo - Rust
. "$HOME/.cargo/env"
export PKG_CONFIG_PATH="/usr/lib64/pkgconfig"

## Brew
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}"

if [ -f "$HOME/.zshsecret" ]; then
  . "$HOME/.zshsecret"
fi
