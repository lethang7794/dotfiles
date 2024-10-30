#
# thefuck: Configure thefuck.
#

# https://github.com/atuinsh/atuin
if (($ +commands[thefuck] )); then
  cached-eval 'thefuck' thefuck --alias f
  zle -N f        # Define f as a new widget
  bindkey "^[f" f # Bind Alt+f to f
fi