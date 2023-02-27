#!/bin/sh

# This file runs when a DM logs you into a graphical session.
# If you use startx/xinit like a Chad, this file will also be sourced.

xrandr --dpi 96		# Set DPI. User may want to use a larger number for larger screens.
setbg &			# Set the background with the `setbg` script.
xrdb ${XDG_CONFIG_HOME:-$HOME/}.Xresources & xrdbpid=$!	# Uncomment to use Xresources colors/settings on startup.
redshift -O 3000 # Changing the screen temperature.


autostart="mpd dunst unclutter pipewire remapd slstatus xkb"

for program in $autostart; do
	pidof -s "$program" || "$program" &
done >/dev/null 2>&1

# Ensure that xrdb has finished running before moving on to start the WM/DE.
[ -n "$xrdbpid" ] && wait "$xrdbpid"
exec dwm > ~/.dwm.log
