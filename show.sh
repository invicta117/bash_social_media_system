#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Error: paramaters problem"
	exit 1
fi

if ! [ -d $1 ]; then
	echo "Error: user does not exist"
	exit 1
fi

wall="$1/wall"
num=$(wc -l $wall | cut -d " " -f1)
echo "WallStart"
head -n$num $wall
echo "WallEnd"
exit 0
