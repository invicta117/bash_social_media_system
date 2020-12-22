#!/bin/bash
if [ $# -lt 2 ]; then # check the minimum number of paramaters is 2 as per assignment guidelines
	echo "Error: paramater problem" # tell user there was a problem
	exit 1 # exit indicating failure
fi


if ! [[ $2 == "create" || $2 == "add" || $2 == "post" || $2 == "show" || $2 == "shutdown" ]]; then # check the command entered corresponds to a vailid command
	echo "Error: invalid command entered" # tell the user if it does not satify one of the above options
	exit 1 # exit indicating failure
fi

if [[ $2 == "create" ]]; then # if the chosen command is create then
	if [ $# -ne 3 ]; then # if the user did not enter 3 args
		echo "Error: paramater problem" # tell them paramaters wrong
		exit 1 # exit indicating failure
	fi
	mkfifo "$1.pipe" # make the user pipe
	./P.sh server.pipe # lock the server pipe used, this solved broken pipe issue
	echo "$1 $2 $3" > server.pipe # send the args to the server pipe
	./V.sh server.pipe # unlock the server pipe
	read reply < "$1.pipe" # read the reply to from the user pipe
	echo "$reply" # output the reply
	rm "$1.pipe" # remove the user pipe
fi

if [[ $2 == "add" ]]; then # same as above but for add command
	if [ $# -ne 4 ]; then # paramaters should be 4 this time
		echo "Error: paramater problem"
		exit 1
	fi
	mkfifo "$1.pipe"
	./P.sh server.pipe
	echo "$1 $2 $3 $4" > server.pipe
	./V.sh server.pipe
	read reply < "$1.pipe"
	echo "$reply"
	rm "$1.pipe"	
fi

if [[ $2 == "post" ]]; then # same as above but for post command
	if [ $# -ne 5 ]; then # paramaters should be 5
		echo "Error: paramater problem"
		exit 1
	fi
	mkfifo "$1.pipe"
	echo "$1 $2 $3 $4 '$5'"
	./P.sh server.pipe
	echo "$1 $2 $3 $4 '$5'" > server.pipe
	./V.sh server.pipe
	read reply < "$1.pipe"
	echo "$reply"
	rm "$1.pipe"	
fi

if [[ $2 == "show" ]]; then # same as above for show command
	if [ $# -ne 3 ]; then # paramaters should be 3
		echo "Error: paramater problem"
		exit 1
	fi
	mkfifo "$1.pipe"
	./P.sh server.pipe
	echo "$1 $2 $3" > server.pipe
	./V.sh server.pipe
	while read reply;do # this is to allow multiple lines of input to be read from a pipe comes from the tutorial 7 on pipes
		echo "$reply" # echo out each of the lines in the reply
	done < "$1.pipe" # receive the multiple line message from the user pipe
	rm "$1.pipe"	
fi

if [[ $2 == "shutdown" ]]; then # same as above but for shutdown command
	if [ $# -ne 2 ]; then # paramater number should be 2
		echo "Error: paramater problem"
		exit 1
	fi	
	mkfifo "$1.pipe"
	./P.sh server.pipe
	echo "$1 $2" > server.pipe
	./V.sh server.pipe
	read reply < "$1.pipe"
	echo "$reply"
	rm "$1.pipe"	
fi

exit 0
