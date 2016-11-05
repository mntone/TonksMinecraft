#!/bin/bash
FILENAME=mods_list.txt
rm $FILENAME
for file in *; do
	if [ $file != "write_mods.sh" ] && [ $file != "1.7.10" ]; then
    	echo "${file}" >> $FILENAME
	fi
done
