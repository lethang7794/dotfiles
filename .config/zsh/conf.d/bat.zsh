#!/usr/bin/env bash
#
# bat: Configure bat.
#
# https://github.com/sharkdp/bat

if command -v bat &>/dev/null; then
  alias bathelp="bat -pl help"
fi
