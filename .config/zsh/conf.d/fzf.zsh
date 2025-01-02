#
# fzf: Configure fzf.
#

# https://github.com/junegunn/fzf
if [ -d "$HOMEBREW_PREFIX/opt/fzf" ]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
fi
