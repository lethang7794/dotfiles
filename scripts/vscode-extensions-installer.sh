#!/bin/bash

EXTS="$(cat vscode-extensions.txt)"
for EXT_ID in $EXTS; do
    code --install-extension $EXT_ID
done

