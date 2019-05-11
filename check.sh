#!/bin/bash

CONTAINER="${1:-clair}"


# Look for success without failure for 40 minutes
# Travis will kill the job after 50min so we have
# 10min left to finish our work

SECONDS=0
FAILURES=0
UPDATES=1

while read -r log; do
    echo "$log"
    # if we are reaching the timeout just abort nicely at 35min
    if [ $SECONDS -gt 2100 ]; then
      echo "----> Timeout, reached with $FAILURES failure(s)"
      exit 0
    fi

    case "$log" in

      *"update finished"*)
        echo "----> Update $UPDATES finished, with $FAILURES failure(s)"
        if [ "$FAILURES" == 0 ]; then
          break
        fi
      ;;

      *"an error occured"*)
        FAILURES=$((FAILURES+1))
        echo "----> $FAILURES Failure(s) detected"
      ;;

    esac

done < <(docker logs "$CONTAINER" -f)
