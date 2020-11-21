#!/bin/bash
if [ $# -ne 1 ]; then
	echo "Error: parameters problem"
	exit 1	
fi
mkdir $1
#if mkdir "$1" 2>/dev/null; then
#	echo "OK: user created"
#else
#	echo "Error: user already exists"
#fi 

exit 1
