screenshot() {
	scrot -e 'mv $f ~/Documents/screenshots'
	echo "Screenshot Saved!"
}

dunstify "$(screenshot)"