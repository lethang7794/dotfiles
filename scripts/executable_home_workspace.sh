#!/bin/bash -e

# Switch to the first workspace
wmctrl -s 0

sleep 0.15

dbus-send --session --dest=org.gnome.Shell --type=method_call /org/gnome/Shell org.freedesktop.DBus.Properties.Set string:org.gnome.Shell string:OverviewActive variant:boolean:true

# Not working
# xdotool key "Shift+Ctrl+Alt+Super+Space" > /dev/null 

# Not working
# python show_overview.py