#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Error: parameters problem" >&2
	exit 1
fi

if [ ! -d "$1" ]; then
	echo "Error: user does not exist" >&2
	exit 1
elif [ ! -d "$2" ]; then
	echo "Error: friend does not exist" >&2
	exit 1
fi

if grep -q "$2$" -q "./$1/friends"; then
	echo "Error: user already friends with this user"
	exit 1
else
	echo "$2" >> "./$1/friends"
	echo "OK: friends added"
fi

exit 0

