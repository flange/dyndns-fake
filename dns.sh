#!/bin/bash

SERVER="http://www.icanhazip.com"
FILE="raspberry_ip"
WORKING_DIR=$(pwd)

PUSH=0

CURR_IP=$(curl -s $SERVER)

if [ ! -f $WORKING_DIR/$FILE ]; then
	echo $CURR_IP > $WORKING_DIR/$FILE
	PUSH="1"
else
	OLD_IP=$(cat $WORKING_DIR/$FILE)

	if [ $CURR_IP != $OLD_IP ]; then
		echo $CURR_IP > $WORKING_DIR/$FILE
		PUSH="1"
	fi
fi


if [ $PUSH == "1" ]; then
	PUSH=0
	git add $WORKING_DIR/$FILE
	git commit -a -m "ip update"
	git push
fi
