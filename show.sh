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
echo "WallStart"
./P.sh $1
cat $wall
./V.sh $1
echo "WallEnd"
exit 0
