#!/usr/bin/env bash
#
# __bash_completions__: Use completion specifications and functions written for bash.
#
# References:
# - https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Use-of-compinit

# The function `bashcompinit` provides compatibility with bash’s programmable completion system.
# When run it will define two functions: `compgen` and `complete` which correspond to the bash builtins's.
autoload bashcompinit && bashcompinit
