#!/bin/bash
start()
{
	password=$(zenity --password --title="Authentication")
	a=`md5sum <<< $password`
	sed "s/user/$a/g" lock.sh > setlock
	rm lock.sh
	sudo chmod +x  setlock
	sudo mv setlock /usr/bin
	sudo echo setlock  >> $HOME/.bashrc
	sudo rm -r ../set_terminal_lock_zenity
}

which zenity > /dev/null
if [ $? == 0 ]
then 
	echo "Zenity Already Installed"
else
	ping -c 3 google.com
	if [ $? == 0 ]
	then
		sudo apt-get install zenity -y
	else
		echo "check your internet connection"
	fi
fi

which figlet > /dev/null
if [ $? == 0 ]
then 
	echo "figlet Already Installed"
else
	ping -c 3 google.com
	if [ $? == 0 ]
	then
		sudo apt-get install figlet -y
	else
		echo "check your internet connection"
	fi
fi

dpkg -l | grep ucommon-utils
if [ $? == 0 ]
then
	echo "ucommon-utils Already Installed"
	start
else
	ping -c 3 google.com
	if [ $? == 0 ]
	then
		sudo apt-get install ucommon-utils -y
		start
	else
		echo "check your internet connection"
	fi
fi
