#!/usr/bin/python
# -*- coding: utf-8 -*-
# Grabs a small weather summary from wttr.in and saves to text file.
import subprocess
import re
import time
import os

location = "<location>"
filename = "weather.txt"


def strip_ansi(forecast_string):
	ansi_escape = re.compile(r'\x1b[^m]*m')
	forecast_string = ansi_escape.sub('', forecast_string)
	forecast_string = " ".join(re.findall("[a-zA-Z0-9\°]+", forecast_string))
	return forecast_string


def grab_weather(location):

	url = "wttr.in/" + location + "?q"
	curl = subprocess.Popen(("curl", url), stdout=subprocess.PIPE)
	time.sleep(1)
	weather = subprocess.check_output(('sed', '-n', '3, 4p'), stdin=curl.stdout)
	return strip_ansi(weather)


def save_forecast(summary, temp):
	if not os.path.exists(filename):
		file(filename, 'w').close()

	f = open(filename, 'r+')
	f.seek(0)
	f.truncate()
	f.write(summary + "\t" + temp)
	f.close()


forecast = grab_weather(location)
temp = re.split(r'(^[^\d]+)', forecast)[2]
summary = re.split(r'(^[^\d]+)', forecast)[1]
save_forecast(summary, temp)
