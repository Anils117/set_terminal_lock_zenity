#!/bin/bash
password="$(zenity --password --title="Authentication")"
b=`md5sum <<< $password`
if [[ $b == "user" ]]
then
	sleep 1s
	figlet "Welcome"
else
	sleep 1s
	figlet "You are not an Authorized User"
	sleep 3s
	kill $(pgrep terminal)
fi


