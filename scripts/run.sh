#!/usr/bin/env bash

set -e

if [[ -z $HOST ]]; then
  HOST=$1
fi
echo 
echo "host = $HOST"
echo

COOL_DOWN=120 # seconds

function log {
  echo "$(date '+%Y-%m-%d %H:%M:%S') $1"
}


mkdir -p workdir
echo
log "Press [CTRL+C] to stop.."
echo
while true
do
  set +e
  scripts/check-connection.tcl $HOST 2>&1 > /dev/null
  CONNECTION_EXIT_CODE=$?
  set -e
  if [[ $CONNECTION_EXIT_CODE -eq 3 ]]; then
    echo
    cat workdir/$HOST.connection.txt
    echo
    log "Checking if we need to reboot"
    echo
    UPTIME=$(scripts/get-uptime.sh $HOST)
    UPTIME=$(($UPTIME+0))
    echo
    log "UPTIME = $UPTIME"
    echo
    if [[ $UPTIME -ge $COOL_DOWN ]]; then
      echo
      log "Rebooting $HOST"
      echo
      scripts/reboot.tcl $HOST
    else
      echo
      log "Not rebooting $HOST"
      echo
    fi
  elif [[ $CONNECTION_EXIT_CODE -ne 0 ]]; then
    echo
    log "Script exited with $CONNECTION_EXIT_CODE... not sure why"
    echo
    cat workdir/$HOST.connection.txt
    echo
  else
    echo
    log "Connection on $HOST seems ok"
    echo
  fi
  sleep 10
done
