#!/bin/bash

USERNAME=mntone
JARFILE=forge-1.7.10-10.13.4.1614-1.7.10-universal.jar
SCREEN_NAME=minecraft
MCPATH=/home/mntone/minecraft

PERMSIZE="128m"
XMS="1g"
XMX="1g"

cd $MCPATH

ME=`whoami`

if [ $ME == $USERNAME ]; then
	if pgrep -u $USERNAME -f $JARFILE > /dev/null
	then
		echo 'Minecraft is already running!'
	else
		echo 'Starting Minecraft...'
		screen -AmdSU $SCREEN_NAME java -XX:PermSize=$PERMSIZE -XX:MaxPermSize=$PERMSIZE -Xms$XMS -Xmx$XMX -XX:+UseG1GC -jar $JARFILE nogui
	fi
else
	echo "Please run the $USERNAME user."
fi
