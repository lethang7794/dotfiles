#
# direnv: Configure direnv.
#

# https://github.com/direnv/direnv
if (( $+commands[direnv] )); then
  export DIRENV_LOG_FORMAT= # make `direnv` silent
  cached-eval 'direnv-hook-zsh' direnv hook zsh
fi
