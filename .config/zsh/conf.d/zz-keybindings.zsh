#!/usr/bin/env bash

##
## keybindings.zsh: Custom keybindings to zsh widgets.
##

# zoxide
zle -N zi        # Define zi as a new widget
bindkey "^[z" zi # Bind Alt+z to zi

# lazygit
zle -N lg       # Define lg as a new widget
bindkey "^g" lg # Bind ctrl+g to lg

# fzf-rg
zle -N fzf-rg       # Define fzf-rg as a new widget
bindkey "^f" fzf-rg # Bind Ctrl+F to fzf-rg

# fzf-rga
zle -N fzf-rga        # Define fzf-rga as a new widget
bindkey "^[f" fzf-rga # Bind Alt+F to fzf-rga

# fzf-man
function fzf-man-widget {
  fzf-man "$LBUFFER"
}
zle -N fzf-man-widget
bindkey '^[h' fzf-man-widget # Alt-H` keybinding to launch the widget (this widget works only on zsh, don't know how to do it on bash and fish (additionaly pressing`ctrl-backspace` will trigger the widget to be executed too because both share the same keycode)

# fzf-chezmoi
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
