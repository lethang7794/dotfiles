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

# Inherit PATH from bash
export PATH=$HOME/bin:/usr/local/bin:$PATH
#
# dotfiles: Manage dotfiles with bare repository
#
# Usage:
# - dotty $IDE ~
# - dotty git status
# - dotfiles status
#
alias dotty='GIT_WORK_TREE=$HOME GIT_DIR=$HOME/.dotfiles'
alias dotfiles='git --work-tree=$HOME --git-dir=$HOME/.dotfiles'
export IDE=${VISUAL:-${EDITOR:-vim}}

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

## Other completions

## argc-completions: load after oh-my-zsh
# Load argc-completions first, so they can be override by others                    # ?
export ARGC_COMPLETIONS_ROOT="/home/lqt/go/src/github.com/sigoden/argc-completions" #
export ARGC_COMPLETIONS_PATH="$ARGC_COMPLETIONS_ROOT/completions"                   #
# export PATH="$ARGC_COMPLETIONS_ROOT/bin:$PATH"                                    # Use the one from brew
# To add a subset of completions only, change next line e.g. argc_scripts=( cargo git )
# argc_scripts=(
#   broot
#   fzf
#   kubeadm # Better then the builtin
#   minikube
#   ctrld
#   ttab
#   wmctrl
#   packer
# )
# shellcheck disable=SC2207,SC2012
argc_scripts_include=($(ls -p -1 "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p')) # All argc-completions
argc_scripts_exclude=(docker gem kubectl go brew npm pnpm openssl git make just cargo task)
argc_scripts_exclude_pattern=$(printf "|%s" "${argc_scripts_exclude[@]}")
argc_scripts_exclude_pattern=${argc_scripts_exclude_pattern:1} # Remove the leading '|'
argc_scripts_items=$(printf "%s\n" "${argc_scripts_include[@]}" | grep -v -E "${argc_scripts_exclude_pattern}")
argc_scripts=$(echo "$argc_scripts_items" | tr "\n" " ")
source <(argc --argc-completions zsh ${argc_scripts[*]})

# TODO: migrate away from oh-my-zsh to have full control
# Load completions the second time, which will make zsh startup a lot slower
# compinit -d $ZSH_COMPDUMP

# Plugins
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Globalias
# shellcheck disable=SC2034
GLOBALIAS_FILTER_VALUES=(ls which type z grep open rm rmdir rm-yes rmdir-yes mv dotty dotfiles)

## Brew
if [ -f "$HOMEBREW_BIN" ]; then
  HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
  if [ -f "$HB_CNF_HANDLER" ]; then
    source "$HB_CNF_HANDLER"
  fi
fi

## Bind Alt+R to reload shell config
# function source-shell {
#   echo "Source shell configuration"
#   # exec -l zsh
#   omz reload
# }
# zle -N source-shell        # Define source-shell as a new widget
# bindkey "^[r" source-shell # Bind Alt+R to source-shell
# TODO: The shell will be closed, not reload the current session

## Zsh plugin

# MichaelAquilina/zsh-you-should-use
# export YSU_MESSAGE_FORMAT="$(tput setaf 1)Hey! I found this %alias_type for %command: %alias$(tput sgr0)"

# Atuin
if [ "$(command -v atuin)" ]; then
  export ATUIN_NOBIND="true"
  cached-eval 'atuin' atuin init zsh
  # eval "$(atuin init zsh --disable-up-arrow)"
  # eval "$(atuin init zsh --disable-up-arrow --disable-ctrl-r)"

  # bindkey '^r' atuin-search
  bindkey '^r' atuin-search

  # bind to the up key, which depends on terminal mode
  bindkey '^[[A' atuin-up-search
  bindkey '^[OA' atuin-up-search
fi

# Thefuck
# cached-eval 'thefuck' thefuck --alias f
# zle -N f        # Define f as a new widget
# bindkey "^[f" f # Bind Alt+f to f

function cdd {
  br --only-folders
}
function treee {
  br -c :pt "$@"
}

## AWS https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-linux
# complete -C "$(which aws_completer)" aws
# complete -C "$HOME/.local/share/mise/installs/awscli/latest/bin/aws_completer" aws

## zoxide: smarter cd
# https://github.com/ajeetdsouza/zoxide/blob/main/src/cmd/query.rs
export _ZO_FZF_OPTS="
  --exact
  --no-sort
  --bind=ctrl-z:ignore,btab:up,tab:down
  --cycle
  --keep-right
  --border=sharp
  --color=label:italic
  --border-label='╢ Alt+Z: Search frequently directories ╟'
  --height=90%
  --info=inline-right
  --highlight-line
  --color='pointer:white'
  --layout=reverse
  --tabstop=1
  --exit-0
  --preview='tree -C --dirsfirst -L 1 {2..}'
  --preview-window=right
  --bind='alt-z:toggle-preview-wrap'
  --bind 'alt-x:toggle-wrap'
  --bind='ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)'
  --bind='ctrl-s:toggle-sort'
  --bind 'ctrl-/:toggle-preview'
  --bind 'alt-/:change-preview-window:right|down'
  --bind 'f11:change-preview-window:right|down'
"
# cached-eval "zoxide init zsh"
zle -N zi        # Define zi as a new widget
bindkey "^[z" zi # Bind Alt+z to zi

zle -N lg       # Define lg as a new widget
bindkey "^g" lg # Bind ctrl+g to lg

# Walk https://github.com/antonmedv/walk
export WALK_REMOVE_CMD=trash
function lk {
  cd "$(walk --icons --fuzzy --preview "$@")" || exit
}

#==========================================================================================================================
#                                                     fzf
#==========================================================================================================================
# fzf setup
if [ -d "$HOMEBREW_PREFIX/opt/fzf" ]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

export FZF_DEFAULT_COMMAND="fd --color=always --hidden"
export FZF_DEFAULT_OPTS="
  --ansi
  --border=sharp
  --highlight-line
  --tabstop=4
  --color='pointer:white,marker:#87ff00'
  --height=90%
  --info=inline-right
  --preview-window=right,55%,~1,+{0}+1/2
  --bind='alt-z:toggle-preview-wrap'
  --bind 'alt-x:toggle-wrap'
  --wrap-sign '    '
  --bind='ctrl-y:execute-silent(echo -n {} | xclip -selection clipboard)'
  --bind='ctrl-s:toggle-sort'
  --bind 'ctrl-/:toggle-preview'
  --bind 'alt-/:change-preview-window:right|down'
  --bind 'f11:change-preview-window:down,99%,~1,+{0}+1/2|down,~1,+{0}+1/2|hidden|'
  --marker='✓'
"
# --pointer='󰋇 '

# <Ctrl-/> to toggle small preview window to see the full command
# <Ctrl-Y> to copy the command into clipboard using xclip
export FZF_CTRL_R_OPTS="
  --color label:italic
  --border-label='╢ Ctrl+R: Search history ╟'
  --preview 'echo {2..} | bat --color=always -pl sh'
  --preview-window up:5:hidden:wrap
  --color header:italic
  --header '<Ctrl-Y> Copy\\t<Ctrl-/> Preview\\t<Ctrl-S> Sort'
  --bind='ctrl-s:toggle-sort'
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'
"

export FZF_ALT_T_COMMAND="fd --color=always --hidden --type=file '' '$HOME'"
# shellcheck disable=SC2016
typeTransformerAltT='
  if [[ ! $FZF_PROMPT =~ Files ]]; then
    echo "change-border-label@╢ Alt+T: Search files in \$HOME (absolute path) ╟@+change-prompt( Files> )+reload(fd --color=always --hidden --type=file {q} '$HOME')"
  else
    echo "change-border-label@╢ Alt+T: Search files in \$HOME (absolute path) ╟@+change-prompt( Directories> )+reload(fd --color=always --hidden --type=directory {q} '$HOME')"
  fi
'
export FZF_CTRL_T_COMMAND="fd --color=always --hidden --type=file"
# shellcheck disable=SC2016
typeTransformerCtrlT='
  if [[ ! $FZF_PROMPT =~ Files ]]; then
    echo "change-border-label(╢ Ctrt+T: Search files relative to \$PWD ╟)+change-prompt( Files> )+reload(fd --color=always --hidden --type=file)"
  else
    echo "change-border-label(╢ Ctrt+T: Search files relative to \$PWD ╟)+change-prompt( Directories> )+reload(fd --color=always --hidden --type=directory)"
  fi
'
export FZF_CTRL_T_OPTS="
  --border-label='╢ Ctrt+T / Alt+T: Search files ╟'
  --prompt ' Files> '
  --color header:italic
  --color label:italic
  --header '<Ctrl-T> Files/Directorie\\t<Ctrl-/> Preview\\t<Ctrl-S> Sort\\t\\n<Ctrl+E> Open with nvim\\t\\t<Alt-E> VS Code\\t\\t<Alt+Enter> Default App'
  --bind 'alt-/:change-preview-window:right,~1,+{0}+1/2|down,~1,+{0}+1/2'
  --bind 'ctrl-/:toggle-preview'
  --bind='ctrl-s:toggle-sort'
  --bind 'ctrl-t:transform:$typeTransformerCtrlT'
  --bind 'alt-t:transform:$typeTransformerAltT'
  --preview 'sleep 0; lessfilter {}'
  --bind 'ctrl-e:execute(nvim {+})'
  --bind 'alt-e:execute(code --disable-extensions -g {+}; sleep 1)'
  --bind 'alt-enter:execute(for file in {+}; do xdg-open \$file; done)'
  --bind 'ctrl-alt-a:execute-silent(chezmoi add {+} && notify-send -t 1 \"Chezmoi\" \"{+} added.\" --app-name=\"Chezmoi\")'
  --bind 'ctrl-alt-e:execute(chezmoi edit --watch {+})'
  --bind 'ctrl-alt-o:execute(EDITOR=\"code --disable-extensions\" chezmoi edit --watch {+}; sleep 1)'
"

BFS_EXCLUDE="-name .git -or -name .cache -or -name node_modules"
export FZF_ALT_C_COMMAND="bfs -color -type d -unique -exclude \( $BFS_EXCLUDE \) 2>/dev/null | sed 's|./||'"
export FZF_ALT_C_OPTS="
  --color header:italic
  --color label:italic
  --header '<Ctrl-/> Toggle Preview    <Ctrl-S> Sort'
  --preview 'tree -C --dirsfirst -L 1 {} | head -200'
  --bind 'ctrl-/:toggle-preview'
  --bind 'alt-/:change-preview-window:right|down'
"

zle -N fzf-rg       # Define fzf-rg as a new widget
bindkey "^f" fzf-rg # Bind Ctrl+F to fzf-rg

zle -N fzf-rga        # Define fzf-rga as a new widget
bindkey "^[f" fzf-rga # Bind Alt+F to fzf-rga

function fzf-man-widget {
  fzf-man "$LBUFFER"
}

# `Alt-H` keybinding to launch the widget (this widget works only on zsh, don't know how to do it on bash and fish (additionaly pressing`ctrl-backspace` will trigger the widget to be executed too because both share the same keycode)
zle -N fzf-man-widget
bindkey '^[h' fzf-man-widget

function fzf-chezmoi-widget {
  LBUFFER="${LBUFFER}$(fzf-chezmoi)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle -N fzf-chezmoi-widget
bindkey '^[m' fzf-chezmoi-widget

## fzf-tab
bindkey '^Xh' _complete_help
zle -N enable-fzf-tab
bindkey '^Xx' enable-fzf-tab

zstyle ":fzf-tab:*" fzf-flags \
  --multi \
  --bind 'alt-a:select-all' \
  --bind 'alt-t:toggle-all' \
  --height="90%" \
  --header="<Ctrl-Y> Copy to clipboard    <Ctrl-/> Toggle preview    <Ctrl-S/> Sort" \
  --color="header:italic" \
  --bind="ctrl-s:toggle-sort" \
  --bind 'alt-/:change-preview-window:right|down' \
  --bind 'ctrl-/:toggle-preview'

zstyle ':fzf-tab:*' continuous-trigger '/'

zstyle ':fzf-tab:complete:*' fzf-bindings \
  'ctrl-/:toggle-preview' \
  'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)'

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
# shellcheck disable=SC2296
zstyle ':completion:*' list-colors "echo $LS_COLORS | tr ':' ' '"

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# preview directory's content with eza when completing cd
# shellcheck disable=SC2016
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'tree -C --dirsfirst -L 1 $realpath | head -200'

# zstyle ':fzf-tab:*' single-group color header

# switch group using `<` and `>` (instead of F1, F2)
zstyle ':fzf-tab:*' switch-group '<' '>'

# Turn off sort for all completions
zstyle ':completion:*' sort false
# Show git sub-commands, git objects in original order
# zstyle ':completion:*:git:*' sort false   # Show the git subcommands in group
# zstyle ':completion:*:git-*:*' sort false # Show the git objects in created-time order
# zstyle ':completion:*:docker-*:*' sort false

unalias run-help  # Remove the default of run-help being aliased to man
autoload run-help # Use zsh's run-help, which will display information for zsh builtins.

# bat: color man. help
if [ "$(command -v bat)" ]; then
  alias bathelp="bat -pl help"
  function man() {
    /usr/bin/man "$@" | bat -pl help
  }

  # alias -g -- -h='-h 2>&1 | bat -pl help'
  # alias -g -- --help='--help 2>&1 | bat -pl help'

  # pre_validation() {
  #   local command="$1"

  #   # Check if the first argument is "help"
  #   if [[ "$command" == *'help'* ]]; then
  #     # Pipe the output of the command to cat
  #     eval $command | bat -pl help
  #     echo "🚨🚨🚨 Press Ctrl+C to exit 🚨🚨🚨"
  #     read -sk key
  #   fi
  # }

  # # Enable the preexec hook
  # autoload -Uz add-zsh-hook
  # add-zsh-hook preexec pre_validation
fi

# fx
# source <(fx --comp zsh) # Need to disable argc-complete for fx; Not so smooth when first release (v33)

# atac
export ATAC_MAIN_DIR=~/.config/atac

## rip2: a safer rm # rip2 is not compatible with XDG
# function rip {
#   local args=$@
#   eval "$HOME/.cargo/bin/rip --graveyard $RIP_GRAVEYARD -i $@"
# }

function upd() {
  printf "\n🆕 Update dnf packages\n"
  printf "dnf5 upgrade -y --refresh\n"
  sudo dnf5 upgrade -y --refresh

  printf "\n🆕 Update zsh plugins\n"
  antidote update

  printf "\n🆕 Update flatpak packages\n"
  printf "flatpak update -y\n"
  flatpak update -y

  printf "\n🆕 Update Gnome-Software packages\n"
  printf "pkcon refresh && pkcon update\n"
  pkcon refresh && pkcon update

  printf "\n🆕 Update Homebrew packages\n"
  printf "brew update && brew upgrade\n"
  brew update && brew upgrade
}

## Kubernetes
if [ "$(command -v kubecolor)" ]; then
  alias kubectl="kubecolor"
  compdef kubecolor=kubectl
fi
mk_running=$(minikube status | grep Running | wc -l)
((mk_running > 0)) && export MINIKUBE="Running"

# Volta
# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"

# NVMD
# export NVMD_DIR="$HOME/.nvmd"
# export PATH="$NVMD_DIR/bin:$PATH"

# pnpm
# export PNPM_HOME="/home/lqt/.local/share/pnpm"
# case ":$PATH:" in
# *":$PNPM_HOME:"*) ;;
# *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# pnpm end



# Go cover https://dave.cheney.net/2013/11/14/more-simple-test-coverage-in-go-1-2
go-cover() {
  t=$(mktemp)
  go test "$COVERFLAGS" -coverprofile="$t" "$@" && go tool cover -func="$t" && unlink "$t"
}
go-cover-web() {
  t=$(mktemp)
  go test "$COVERFLAGS" -coverprofile="$t" "$@" && go tool cover -html="$t" && unlink "$t"
}

# JetBrains
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# VS Code
# VSCODE_PROFILE=Fedora
# function code {
#   /usr/bin/code "$@" --profile $VSCODE_PROFILE
# }

# rbenv
if [ "$(command -v rbenv)" ]; then
  cached-eval 'rbenv' rbenv init - zsh
fi

# Mojo
export MODULAR_HOME="/home/lqt/.modular"
export PATH="/home/lqt/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

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

export WHERE=.zshrc

timezsh() {
  shell=${1-$SHELL}
  # shellcheck disable=SC2034
  for i in $(seq 1 10); do /usr/bin/time "$shell" -i -c exit; done
}

# Created by `pipx` on 2024-04-01 17:04:47
export PATH="$PATH:/home/lqt/.local/bin"

zle -N yy            # Define yy as a new widget
bindkey '^[[1;3B' yy # Bind Alt + Down to yy widget

# Temp workaround to disable punycode deprecation logging to stderr
# https://github.com/bitwarden/clients/issues/6689
alias bw='NODE_OPTIONS="--no-deprecation" bw'

## Copy - paste
# Copy from https://stackoverflow.com/a/62517779 with some modifications
if grep -q -i microsoft /proc/version; then
  # on WSL: version contains the string "microsoft"
  alias copy="clip.exe"
  alias paste="powershell.exe Get-Clipboard"
elif [[ "$(uname -a)" == *"cygwin"* ]]; then
  # on CYGWIN: uname contains the string "cygwin"
  alias copy="/dev/clipboard"
  alias paste="cat /dev/clipboard"
elif [[ ! -r /proc/version ]]; then
  # on MAC: version is not readable at all
  alias copy="pbcopy"
  alias paste="pbpaste"
else
  # on "normal" linux
  alias copy="xclip -sel clip"
  alias paste="xclip -sel clip -o"
fi

# asdf - Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more
# . "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh"

# nav
# nav bindkeys
zle -N gitop # Define gitop as a new widget
bindkey '^[[1;4A' gitop
bindkey '^[[1;3A' nav-up      # alt + up
bindkey '^[[1;3C' nav-forward # alt + right
bindkey '^[[1;3D' nav-back    # alt + left

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