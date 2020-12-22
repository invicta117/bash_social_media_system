#!/bin/bash
mkfifo server.pipe # create the pipe server.pipe so that messages can be passed to the server
read -r input < server.pipe # read in any messages from the users that have been passed to the server.pipe
user=$(echo "$input" | cut -d" " -f1) # get the user that was passed to the pipe
request=$(echo "$input" | cut -d" " -f2) # get the request that was passed to the pipe
param=$(echo "$input" | cut -d" " -f3-) # get the paramaters that was passed to the pipe
while true; do
        case "$request" in
                create) # when create was the request
                        echo $param | xargs ./create.sh > $user.pipe & # echo the paramaters, this is piped to xargs ./create.sh which takes the values echoed and passes them as standard input to ./create.sh
			# this is then passed to the users pipe that was processed at the start, and this command is placed in the background using the & command
                        ;;
                add)
			echo $param | xargs ./add.sh > "$user.pipe" & # same as above but passed to ./add.sh
                        ;;
                post)	
		
                        echo $param | xargs ./post.sh > "$user.pipe" &
                        ;;
                show)
		
                        echo $param | xargs ./show.sh > "$user.pipe" &
                        ;;
                shutdown)
			echo "server shutting down.." > "$user.pipe" & # need to send message to notify user and allow the user pipe to be removed
                        break # break out of the while loop to allow the remaining code to be executed
                        ;;
                *) # should not be executed if the client.sh script works correctly but incliding anyway 
			echo "Error: bad request" > "$user.pipe" & # tell client that this was a bad request and we are shutting down the server, also cleans up clients pipe
			rm server.pipe # clean up the server.pipe
                        exit 1 # exit indicating failure
        esac
        read -r input < server.pipe # allows more input to be read
 	user=$(echo "$input" | cut -d" " -f1) # as described above
      	request=$(echo "$input" | cut -d" " -f2)
        param=$(echo "$input" | cut -d" " -f3-)
done
rm server.pipe # when shutdown is used need to remove the server.pipe after we have used it
exit 0 # exit indicating success
