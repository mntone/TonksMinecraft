#!/bin/bash

USERNAME=mntone
SCREEN_NAME=minecraft
MCPATH=/home/mntone/minecraft

cd $MCPATH

ME=`whoami`

if [ $ME == $USERNAME ]; then
	if pgrep -u $USERNAME -f $JARFILE > /dev/null
	then
		echo 'Backing up Minecraft data...'

		# update mod list
		cd mods
		./write_mods.sh
		cd ..

		# write data
		screen -p 0 -S $SCREEN_NAME -X eval 'stuff "say 現在の状態をセーブし、バックアップします (オートセーブが一時停止します)"\015'
		screen -p 0 -S $SCREEN_NAME -X eval 'stuff "save-all"\015'
		sleep 10

		# save off
		screen -p 0 -S $SCREEN_NAME -X eval 'stuff "save-off"\015'

		# git process
		git add -A
		DATETIME=`date '+%Y%m%d-%H%M%S'`
		git commit -a -m "SNAPSHOT-$DATETIME"
		sleep 5

		# save on
		screen -p 0 -S $SCREEN_NAME -X eval 'stuff "save-on"\015'
		screen -p 0 -S $SCREEN_NAME -X eval 'stuff "say オートセーブが再開されました"\015'

		if [ $? == 0 ]; then
			git push origin master
		fi

		echo 'Backup completed!'
	else
		echo 'Minecraft is not running!'
	fi
else
	echo "Please run the $USERNAME user."
fi
