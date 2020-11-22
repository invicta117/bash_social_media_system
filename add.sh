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


exit 0

