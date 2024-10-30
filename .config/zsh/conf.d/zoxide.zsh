#
# zoxide: Configure zoxide.
#

# https://github.com/ajeetdsouza/zoxide
if (( $+commands[zoxide] )); then
  cached-eval 'zoxide-init-zsh' zoxide init zsh

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
fi
