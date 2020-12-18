#!/bin/bash
mkfifo server.pipe
read -r input < server.pipe
echo $input
user=$(echo "$input" | cut -d" " -f1)
request=$(echo "$input" | cut -d" " -f2)
param=$(echo "$input" | cut -d" " -f3-)
while true; do
        case "$request" in
                create)
			echo $input
                        echo $param | xargs ./create.sh > $user.pipe &
                        ;;
                add)
                        echo $input
			echo $param | xargs ./add.sh > $user.pipe &
                        ;;
                post)	
			echo $param
                        echo $param | xargs ./post.sh > $user.pipe &
                        ;;
                show)
			echo $input
                        echo $param | xargs ./show.sh > $user.pipe &
                        ;;
                shutdown)
			echo "server shutting down.." > $user.pipe &
                        break
                        ;;
                *)
			rm server.pipe
			echo "Error: bad request"
                        exit 1
        esac
        read -r input < server.pipe
 	user=$(echo "$input" | cut -d" " -f1)
      	request=$(echo "$input" | cut -d" " -f2)
        param=$(echo "$input" | cut -d" " -f3-)
done
rm server.pipe
exit 0
