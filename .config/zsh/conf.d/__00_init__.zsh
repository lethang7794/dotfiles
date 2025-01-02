#
# __init__: This runs prior to any other conf.d contents.
#

# Apps
export EDITOR=nvim
export VISUAL=code
export PAGER=less

# Set the list of directories that cd searches.
cdpath=(
  $XDG_PROJECTS_DIR(N/)
  $XDG_PROJECTS_DIR/lethang7794(N/)
  $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  # core
  $prepath
  $path

  # emacs
  $HOME/.emacs.d/bin(N)
  $XDG_CONFIG_HOME/emacs/bin(N)

  # pip
  $HOME/.local/bin(N)

  # Bash
  $HOME/bin(N)
  /usr/local/bin(N)

  # Jetbrains
  $HOME/.local/share/JetBrains/Toolbox/scripts(N)

  # Golang
  $HOME/.gobrew/bin(N)         # Gobrew bin 
  $HOME/.gobrew/current/bin(N) # Built by gobrew's Golang
  $HOME/go/bin(N)              # Built by OS-level Golang

  # keg only brew apps
  # $HOMEBREW_PREFIX/opt/curl/bin(N)
  $HOMEBREW_PREFIX/opt/go/libexec/bin(N)
  $HOMEBREW_PREFIX/share/npm/bin(N)
  $HOMEBREW_PREFIX/opt/ruby/bin(N)
  $HOMEBREW_PREFIX/lib/ruby/gems/*/bin(N)
  $HOME/.gem/ruby/*/bin(N)
)
