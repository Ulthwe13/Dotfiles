#System Icons
CLOCK_ICON="%{F#6B59B3} \ue015 %{F-}"
SPEAKER_ICON="%{F#6B59B3} \ue204 %{F-}"
CONN_ICON='\ue21e'
DC_ICON='\ue21b'
#Weather Icons
MOON_ICON='\ue233'
SUNNY_ICON="\ue234"
LIGHTNING_ICON="\ue22c"
CLOUDY_ICON="\ue22b"
RAINY_ICON="\ue22f"
SNOWY_ICON="\ue22e"
TEMP_ICON="\ue0cf" 
#Music Icons
MUSIC_NOTE_ICON='\ue1a6'
BACK_ICON='\ue096'
PLAY_ICON='\ue09a'
PAUSE_ICON='\ue09b'
STOP_ICON='\ue099'
FORWARD_ICON='\ue09c'

now_playing() {
	cur=`mpc current`
	test -n "$cur" && echo $cur || echo "- stopped -"
}

TOD() {
 	TIME=$(date +"%H")
 	DAY='8'
 	NIGHT='20'

 	if [ ${TIME} -ge ${DAY} ] && [ ${TIME} -le ${NIGHT} ];
 	then
 		echo "$SUNNY_ICON"
 	else
 		echo "$MOON_ICON"
 	fi;
}
weather() {
	STR=`cat weather.txt`
	IFS=":" read summary temp <<< "$STR"
	echo "%{F#6B59B3}$(choose_icon)%{F-}%{F#8C8C8C} $summary%{F-}%{F#6B59B3}$TEMP_ICON%{F-}%{F#8C8C8C}$temp%{F-}"
}

network() {
	int1=eth0
	ping -c 1 8.8.8.8 >/dev/null 2>&1 && echo "  %{F#6B59B3}$CONN_ICON %{F-}%{F#8C8C8C}$int1 connected%{F-}" || echo "%{F#6B59B3}$DC_ICON %{F#8C8C8C} $int1 sdisconnected%{F-}"
}
choose_icon() {
	if [[ "${summary,,}" == *"cloudy"*  ]] || [[ "$summary,," == *"overcast"* ]]
	then 
		echo "$CLOUDY_ICON"
	elif [[ "{$summary,,}" == *"sunny"* ]] || [[ "{$summary,,}" == *"clear"* ]] || [[ "{$summary,,}" == *"fair"* ]]
	then
		echo "$SUNNY_ICON"
	elif [[ "{$summary,,}" == *"rain"* ]] || [[ "{$summary,,}" == *"drizzle"* ]]
	then
		echo "$RAINY_ICON"
	elif [[ "${summary,,}" == *"Lightning"* ]] || [[ "{$summary,,}" == *"Thunderstorm"* ]]
	then
		echo "$LIGHTNING_ICON"
	elif [[ "${summary,,}" == *"Sunny"* ]] || [[ "{$summary,,}" == *"Clear"* ]]
	then
		echo "$SNOWY_ICON"
	fi;
}

mpd_control() {
	echo "%{F#6B59B3}%{A:/usr/bin/mpc prev:}$BACK_ICON%{A}%{A:/usr/bin/mpc stop:}$STOP_ICON%{A}%{A:/usr/bin/mpc pause:}$PAUSE_ICON%{A}%{A:/usr/bin/mpc play:}$PLAY_ICON%{A}%{A:/usr/bin/mpc next:}$FORWARD_ICON%{A}%{F-}"
}

volume() {
    amixer get Master | sed -n 'N;s/^.*\[\([0-9]\+%\).*$/\1/p'

}

while sleep 1.0; do echo -e "%{c} %{F#6B59B3}$(TOD)%{F-} %{F#8C8C8C} $(date +%A,\ %d,\ %B\ %H:%M) $(weather)%{c-} %{r}%{F#6B59B3}$MUSIC_NOTE_ICON %{F-} %{F#8C8C8C}$(now_playing) ${F-}$(mpd_control)%{F-}$(network)%{F#6B59B3}$SPEAKER_ICON %{F-}%{F#8C8C8C} $(volume)%{F-}"; done | lemonbar  -f '-*-siji-*' -f '-*-uushi-*' -g 1920x20+0+2 | /bin/bash