#!/bin/bash

if [ $# -ne 1 ]; then # if the number of paramaters is wrong
	echo "the number of parameters is wrong" # tell the user
	exit 1 # exit indicating a failure
fi

while ! ln "$0" "$1.lock" 2> /dev/null; do # check that the lock creation is successful 
	sleep 1 # if not successful wait
done
exit 0 # exit indicating success
