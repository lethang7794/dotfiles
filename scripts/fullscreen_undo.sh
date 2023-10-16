#!/bin/bash -e

# Get the active window ID
ACTIVE_WINDOW=$(xdotool getactivewindow)


# Unmaximize the active window
wmctrl -i -r $ACTIVE_WINDOW -b remove,fullscreen
wmctrl -i -r $ACTIVE_WINDOW -b remove,maximized_vert,maximized_horz

# Move the active window to the first workspace (workspace index 0)
wmctrl -i -r $ACTIVE_WINDOW -t 0

# Switch to the first workspace
wmctrl -s 0

echo "Active window moved to the first workspace, unmaximized, and switched to the first workspace."