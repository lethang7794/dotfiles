#
# starship: Configure starship.
#

# https://github.com/starship/starship
if (( $+commands[starship] )); then
  cached-eval 'starship-init-zsh' starship init zsh
fi
