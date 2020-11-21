#!/bin/bash
if [ $# -ne 1 ]; then
	echo "Error: parameters problem" >&2
	exit 1	
fi

if mkdir ./"$1" 2>/dev/null; then
	echo "OK: user created"
else
	echo "Error: user already exists"
fi 

exit 0 # everything went well
