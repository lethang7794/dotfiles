#!/usr/bin/env zsh

##
## .zshenv: Zsh environment file, loaded always.
##
# References:
# - Environment variables https://wiki.archlinux.org/title/Environment_variables

export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}

# XDG https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}
export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}

# Fish-like dirs
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${__zsh_user_data_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh}
: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
# export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"

# Ensure Zsh directories exist.
() {
  local zdir
  for zdir in $@; do
    [[ -d "${(P)zdir}" ]] || mkdir -p -- "${(P)zdir}"
  done
} __zsh_{config,user_data,cache}_dir XDG_{CONFIG,CACHE,DATA,STATE}_HOME XDG_{RUNTIME,PROJECTS}_DIR

# Make Terminal.app behave.
if [[ "$OSTYPE" == darwin* ]]; then
  export SHELL_SESSIONS_DISABLE=1
fi



###############################################################################
#                               Applications                                  #
###############################################################################

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

# rip2: a safer rm (not compatible with XDG Trash Spec)
# export RIP_GRAVEYARD="$XDG_DATA_HOME/Trash" # ~/.local/share/Trash


###############################################################################
#                           Programming languages                             #
###############################################################################
##
## Golang
export GOROOT="$HOME/.gobrew/current/go" # Current Golang bin managed by gobrew


##
## Rust
##
# Cargo
. "$HOME/.cargo/env"
# Use the system pkg-config tool (if available) to determine where a library is located. 
export PKG_CONFIG_PATH="/usr/lib64/pkgconfig"

###############################################################################
#                                   Misc                                      #
###############################################################################

# Brew
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}"
# TODO: Why brew is already added to PATH?

# Secrets
if [ -f "$HOME/.zshsecret" ]; then
  . "$HOME/.zshsecret"
fi