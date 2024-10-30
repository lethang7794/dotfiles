#!/bin/bash

EXTS="$(cat gnome-extensions.txt)"
for EXT_ID in $EXTS; do
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=${EXT_ID}" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O "${EXT_ID}".zip "https://extensions.gnome.org/download-extension/${EXT_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force "${EXT_ID}".zip
    if ! gnome-extensions list | grep --quiet "${EXT_ID}"; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s "${EXT_ID}"
    fi
    gnome-extensions enable "${EXT_ID}"
    rm "${EXT_ID}".zip
done
