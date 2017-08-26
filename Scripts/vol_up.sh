#!/bin/sh
amixer set Master 5%+ > /dev/null 2>&1

volume() {
    amixer get Master | sed -n 'N;s/^.*\[\([0-9]\+%\).*$/\1/p'
}

dunstify "$(volume)" 