#!/bin/bash

USERNAME=mntone
JARFILE=forge-1.7.10-10.13.4.1614-1.7.10-universal.jar
SCREEN_NAME=minecraft
MCPATH=/home/mntone/minecraft

cd $MCPATH

ME=`whoami`

if [ $ME == $USERNAME ]; then
	if pgrep -u $USERNAME -f $JARFILE > /dev/null
	then
		echo 'Stopping Minecraft...'
		screen -p 0 -S $SCREEN_NAME -X eval 'stuff "say 15秒以内にサーバーを停止します"\015'
		sleep 5
		screen -p 0 -S $SCREEN_NAME -X eval 'stuff "say 現在の状態をセーブします"\015'
		screen -p 0 -S $SCREEN_NAME -X eval 'stuff "save-all"\015'
		sleep 10
		screen -p 0 -S $SCREEN_NAME -X eval 'stuff "stop"\015'
		sleep 15
		echo 'Stopped Minecraft server.'
	else
		echo 'Minecraft is not running!'
	fi
else
	echo "Please run the $USERNAME user."
fi
