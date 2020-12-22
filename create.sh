#!/bin/bash
if [ $# -ne 1 ]; then # if the number of paramater is not equal to 1
	echo "Error: parameters problem" # output error warning
	exit 1	# non zero exit code to indicate a failure
fi
# want to lock the friends and wall file as if the directory is created and then swaps to another process before creating the files then other scripts that check the directory exists
# and then tries to add to a file or post or show will find the files don't exist, so need to lock the files here. Explained in more detail in the report
./P.sh "$1-friends" 
./P.sh "$1-wall"
if mkdir "$1" 2>/dev/null; then # mkdir is atomic so do not need to lock
	touch "./$1/friends" # touch is not atomic so do need to lock
	./V.sh "$1-friends" # close the lock 
	touch "./$1/wall" # touch is not atomic 
	./V.sh "$1-wall" # unlock the wall file
	echo "OK: user created"
else
	./V.sh "$1-friends" # ensure the files are released before exiting script
	./V.sh "$1-wall"
	echo "Error: user already exists"
	exit 1
fi 

exit 0
