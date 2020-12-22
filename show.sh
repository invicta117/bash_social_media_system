#!/bin/bash

if [ $# -ne 1 ]; then # check that the number of paramaters is correct
	echo "Error: paramaters problem" # tell user if it is not
	exit 1 # exit indicating failure
fi

if ! [ -d "$1" ]; then # check that the directory for the user exists
	echo "Error: user does not exist" # tell the user that this user does not exist
	exit 1 # exit indicating failure
fi


wall="$1/wall" # set the file that will be accessed
echo "WallStart" # indicate the start of the wall message
./P.sh "$1-wall" # lock the wall file to prevent other processes accessing it 
cat "$wall" # output the contents of the wall file
./V.sh "$1-wall" # unlock the mutex allowing other process to access the wall file
echo "WallEnd" # indicate the end of the wall message
exit 0 # exit indicating success
