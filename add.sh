#!/bin/bash

if [ $# -ne 2 ]; then # if the number of paramaters is not 2 then
	echo "Error: parameters problem" # give warning to user
	exit 1 # non zero exit code to display failure
fi

if [ ! -d "$1" ]; then # check that the directory does actually exist before accessing the files
	echo "Error: user does not exist" # tell the user that the directory that contains the files does not exist
	exit 1 # non zero exit code to display error
elif [ ! -d "$2" ]; then # if the directory for the friend does not exist
	echo "Error: friend does not exist" # warn the user
	exit 1 # quit the program
fi

./P.sh "$1-friends" # lock the user friends file to prevent other processes accessing the file while it is being accessed
if grep -q "^$2$" "./$1/friends"; then # check that the users friends file has the friend in it
	./V.sh "$1-friends" # unlock the file so that is can be accessed by other processes later
	echo "Error: user already friends with this user" # warn the user
	exit 1 # quit the program
else # otherwise
	echo "$2" >> "./$1/friends" # append the friend name to the users friends file
	./V.sh "$1-friends" # unlock the users friends file so that other processes can use it
	echo "OK: friends added" # tell the user all successful
fi

exit 0 # exit sucess
