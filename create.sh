#!/bin/bash
if [ $# -ne 1 ]; then
	echo "Error: parameters problem"
	exit 1	
fi

#if [ $(dirname $1) == "." ]; then
#	echo "we have a new directory"
#else
#	echo "we have a new file"
#fi

if mkdir "$1" 2>/dev/null; then
	touch "./$1/friends"
	touch "./$1/wall"
	echo "OK: user created"
else
	echo "Error: user already exists"
fi 

exit 1
