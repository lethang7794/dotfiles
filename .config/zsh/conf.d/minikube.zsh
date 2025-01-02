#!/usr/bin/env bash
#
# minikube: Configure minikube.
#
# https://github.com/kubernetes/minikube

if [ ! "$(command -v minikube)" ]; then
  return
fi

mk_running=$(minikube status | grep Running | wc -l)
((mk_running > 0)) && export MINIKUBE="Running"
