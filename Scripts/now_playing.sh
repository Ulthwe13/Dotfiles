#!/bin/sh
form="\n<b>Artist:</b>\t<span color='##6b59b3'>%artist%</span>\n<b>Album:</b>\t<span color='##8859b3'>%album%</span>\n<b>Title:</b>\t<span color='##ac4142'>%title%</span>\n<b>Track:</b>\t<span color='##b3596b'>%track%</span>"
toprint="`mpc status -f \"$form\" | head -n5 | sed \"s:&:&amp;:g\"`"
artpath="~/Music/$(dirname "$(mpc status -f '%file%' | head -n1)")/cover.jpg"
rm /tmp/cover.png > /dev/null 2>&1
convert -resize 128x128 "$artpath" /tmp/cover.png > /dev/null 2>&1
/usr/bin/dunstify -a MPD -r 1337 -i "/tmp/cover.png"  "$toprint"
