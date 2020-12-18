#!/bin/bash
if [ $# -ne 1 ]; then
	echo "Error: parameters problem"
	exit 1	
fi

if mkdir "$1" 2>/dev/null; then # mkdir is atomic so do not need to lock
	./P.sh "$1"
	touch "./$1/friends" # touch is not atomic so do need to lock
	touch "./$1/wall"
	./V.sh "$1"
	echo "OK: user created"
else
	echo "Error: user already exists"
	exit 1
fi 

exit 0
