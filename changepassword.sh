#!/bin/bash
start(){
	password=$(zenity --password --title="Authentication") #Reading Password fron User
	echo
	sed "s/user/$password/g" lock.sh > setlock #Replacing current password in lock.sh file and putting it in setlock file.
	rm lock.sh #removing lock.sh file
	sudo chmod +x  setlock #giving excutable permission to setlock
	sudo mv setlock /usr/bin #moving setlock to /usr/bin Directory
	sudo echo setlock  >> $HOME/.bashrc #adding setlock file to .bashrc file in home to run start in terminal.
	#here bashrc file only runs the file present in /usr/bin.
	sudo rm -r ../set_terminal_lock_zenity #removing set_terminal lock directory.
}

which zenity > /dev/null #checking zenity
if [ $? -eq 0 ]
then
	which figlet > /dev/null #checking figlet
	if [ $? -eq 0 ] #checking ping
	then
 		start #if zenity and figlet are Installed then start
	else
		ping -c 3 google.com #else install figlet and start
		if [ $? -eq 0 ]
		then
			sudo apt-get update -y
			sudo apt-get install figlet -y
			start
		else
			echo "check your internet connection"
		fi
	fi
else
	which figlet > /dev/null #if zenity is not installed but figlet is installed then install zenity and start
	if [ $? -eq 0 ]
	then
		ping -c 3 google.com
		if [ $? -eq 0 ]
		then
			sudo apt-get update -y
			sudo apt-get install zenity -y
			start
		else
			echo "check your internet connection"
		fi
	else
		ping -c 3 google.com #if both are not installed then install both and start
		if [ $? -eq 0 ]
		then
			sudo apt-get update -y
			sudo apt-get install figlet -y
			sudo apt-get install zenity -y
			start
		else
			echo "check your internet connection"
		fi
	fi
fi
