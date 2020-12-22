#!/bin/bash

if [ $# -ne 3 ]; then # if the number of paramaters is not equal to 3 then
        echo "Error: paramater problem" # warn the user
        exit 1 # exit indicating failure
fi

if ! [ -d "$1" ]; then # if the receiver directory does not exist
        echo "Error: Receiver does not exist" # tell the user
        exit 1 # exit indicating failure
fi
if [ ! -d "$2" ]; then # if the sender directory does not exist then
	echo "Error: Sender does not exist" # warn the user
	exit 1 # exit indicatin failure
fi
./P.sh "$1-friends" # lock the receiver friends file from being accessd by another file using the mutex
if ! grep -q "^$2$" "./$1/friends"; then # check that the sender is not a friend of the receiver
        ./V.sh "$1-friends" # needs to be here to release the semaphore if true, otherwise would not unlock file
	echo "Error: Sender is not a friend of receiver" # tell user
        exit 1 # exit indicating failure
fi
./V.sh "$1-friends" # if the above if statement is not true then we need to unlock the mutex for the friends file here

./P.sh "$1-wall" # lock the receivers wall file
echo "$2: $3" >> "./$1/wall" # append the sender and message to the receivers wall file
./V.sh "$1-wall" # unlock the receivers wall file
echo "Ok: message posted to wall" # tell the user all went well
exit 0 # exit indicating success

