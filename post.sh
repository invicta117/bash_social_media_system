#!/bin/bash

if [ $# -ne 3 ]; then
        echo "Error: paramater problem"
        exit 1 # I think it is non zero
fi

if ! [ -d $1 ]; then
        echo "Error: Receiver does not exist"
        exit 1
fi

if ! [ -d $2 ]; then
        echo "Error: Sender does not exist"
        exit 1
fi

if ! grep -q $2 ./$1/friends; then
        echo "Error: Sender is not a friend of receiver"
        exit 1
fi

echo "$2: $3" >> "./$1/wall"
echo "Ok: message posted to wall"
exit 0

