#!/bin/bash

if [ $# -ne 3 ]; then
        echo " post.sh :Error: paramater problem"
	echo "$#"
        exit 1 # I think it is non zero
fi

if ! [ -d $1 ]; then
        echo "Error: Receiver does not exist"
        exit 1
fi
if [ ! -d "$2" ]; then
	echo "Error: Sender does not exist"
	exit 1
fi
./P.sh $1
if ! grep -q "^$2$" "./$1/friends"; then
        ./V.sh $1 # needs to be here to release the semaphore if true, otherwise would not unlock
	echo "Error: Sender is not a friend of receiver"
        exit 1
fi
./V.sh $1

./P.sh $1
echo "$2: $3" >> "./$1/wall"
./V.sh $1
echo "Ok: message posted to wall"
exit 0

