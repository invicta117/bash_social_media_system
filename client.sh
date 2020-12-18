#!/bin/bash
if [ $# -lt 2 ]; then
	echo "Error: paramater problem"
	exit 1
fi


if ! [[ $2 == "create" || $2 == "add" || $2 == "post" || $2 == show || $2 == "shutdown" ]]; then
	echo "Error: invalid command entered"
	exit 1
fi

if [[ $2 == "create" ]]; then
	echo "testing create"
	mkfifo "$1.pipe"
	./P.sh server.pipe	
	echo "$1 $2 $3" > server.pipe
	read reply < "$1.pipe"
	./V.sh server.pipe
	echo $reply
	rm "$1.pipe"
fi

if [[ $2 == "add" ]]; then
	echo "testing add"
	mkfifo "$1.pipe"
	./P.sh server.pipe
	echo "$1 $2 $3 $4" > server.pipe
	./V.sh server.pipe
	read reply < "$1.pipe"
	echo $reply
	rm "$1.pipe"	
fi

if [[ $2 == "post" ]]; then
	echo "testing add"
	mkfifo "$1.pipe"
	echo $1 $2 $3 $4 '$5'
	./P.sh server.pipe
	echo $5
	echo "$1 $2 $3 $4 '$5'" > server.pipe
	./V.sh server.pipe
	read reply < "$1.pipe"
	echo $reply
	rm "$1.pipe"	
fi

if [[ $2 == "show" ]]; then
	echo "testing add"
	mkfifo "$1.pipe"
	./P.sh server.pipe
	echo "$1 $2 $3" > server.pipe
	./V.sh server.pipe
	while read reply;do
		echo "$reply"
	done < "$1.pipe"
	rm "$1.pipe"	
fi

if [[ $2 == "shutdown" ]]; then
	echo "testing add"
	mkfifo "$1.pipe"
	./P.sh server.pipe
	echo "$1 $2" > server.pipe
	./V.sh server.pipe
	read reply < "$1.pipe"
	echo $reply
	rm "$1.pipe"	
fi

exit 0
