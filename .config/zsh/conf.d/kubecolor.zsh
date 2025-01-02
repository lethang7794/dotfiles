#!/usr/bin/env bash
#
# kubecolor: Configure kubecolor.
#
# https://github.com/kubecolor/kubecolor

if [ "$(command -v kubecolor)" ]; then
  alias kubectl="kubecolor"
  compdef kubecolor=kubectl
fi
