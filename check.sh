#!/bin/bash

CONTAINER="${1:-clair}"

while true
do
    docker logs "$CONTAINER" | grep "update finished" >& /dev/null
    if [ $? == 0 ]; then
        break
    fi

    echo -n "."
    sleep 10
done
echo ""
