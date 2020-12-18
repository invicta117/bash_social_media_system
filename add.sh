!#/bin/bash

if [ $# -ne 2 ]; then
	echo "Error: parameters problem"
	exit 1
fi

./P.sh "$1"
./P.sh "$2"

if [ ! -d "$1" ]; then
	echo "Error: user does not exist"
	./V.sh "$1" # clean up the pipes
	./V.ah "$2"
	exit 1
elif [ ! -d "$2" ]; then
	echo "Error: friend does not exist"
	./V.sh "$1"
	./V.sh "$2"
	exit 1
fi
./V.sh "$2" # no longer need to lock the second folder
if grep -q "^$2$" "./$1/friends"; then
	echo "Error: user already friends with this user"
	./V.sh "$1"
	exit 1
else
	echo "$2" >> "./$1/friends"
	./V.sh "$1"
	echo "OK: friends added"
fi

exit 0
