#!/usr/bin/env bash

#
# argc-completions: Configuration for argc-completions
#
# https://github.com/sigoden/argc-completions/

export ARGC_COMPLETIONS_ROOT="/home/lqt/go/src/github.com/sigoden/argc-completions"

if ! [ "$(command -v argc)" ] || ! [ -d "${ARGC_COMPLETIONS_ROOT}" ]; then
  return 1
fi
export ARGC_COMPLETIONS_PATH="$ARGC_COMPLETIONS_ROOT/completions"

# Load argc-completions first, so they can be override by others                    # ? HOW

###############################################################################
# Option 1: Whitelist completions from argc

# To add a subset of completions only, use `argc_scripts` array
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

###############################################################################
## Option 2: Blacklist - Load all argc completions except the one in `argc_scripts_exclude`

# All argc-completions
# shellcheck disable=SC2207,SC2012
argc_scripts_include=($(ls -p -1 "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p'))

# Specify the argc completions to be exclude
argc_scripts_exclude=(docker gem kubectl go brew npm pnpm openssl git make just cargo task)

# Keep the rest
argc_scripts_exclude_pattern=$(printf "|%s" "${argc_scripts_exclude[@]}")
argc_scripts_exclude_pattern=${argc_scripts_exclude_pattern:1} # Remove the leading '|'
argc_scripts_items=$(printf "%s\n" "${argc_scripts_include[@]}" | grep -v -E "${argc_scripts_exclude_pattern}")
argc_scripts=$(echo "$argc_scripts_items" | tr "\n" " ")

###############################################################################

## Load the completions
source <(argc --argc-completions zsh ${argc_scripts[*]})
