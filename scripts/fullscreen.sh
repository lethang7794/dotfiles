#!/bin/bash -e

# Get the active window ID
ACTIVE_WINDOW=$(xdotool getactivewindow)

WINDOW_STATE=$(xprop -id "$ACTIVE_WINDOW" _NET_WM_STATE | awk '{print $3}')

if [[ "$WINDOW_STATE" == *"_NET_WM_STATE_FULLSCREEN"* ]]; then
   exit 0
fi

# wmctrl -i -r $ACTIVE_WINDOW -b add,fullscreen
wmctrl -i -r $ACTIVE_WINDOW -b add,maximized_vert,maximized_horz

# Get the total number of workspaces
TOTAL_WORKSPACES=$(wmctrl -d | wc -l)

# Move the active window to the last workspace
wmctrl -i -r $ACTIVE_WINDOW -t $(($TOTAL_WORKSPACES - 1))

# Switch to the last workspace
wmctrl -s $(($TOTAL_WORKSPACES - 1))

echo "Active window maximized and moved to the last workspace."