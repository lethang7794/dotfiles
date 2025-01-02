#
# mise: Configure mise.
#

# https://github.com/jdx/mise
if (( $+commands[mise] )); then
  cached-eval 'mise-activate-zsh' mise activate zsh
fi
