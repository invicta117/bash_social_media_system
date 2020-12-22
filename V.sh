#!/bin/bash

if [ $# -ne 1 ]; then # check paramaters correct
	echo "need one paramater" # tell user paramaters wrong
	exit 1 # exit indicating failure
fi	

while ! rm "$1.lock" 2> /dev/null; do # loop while trying to remove the file
	echo "trying to remove link" # give message to user
	sleep 1 # wait before trying again
done
exit 0 # exit indicating success
