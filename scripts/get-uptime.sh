#! /usr/bin/env bash

set -e

mkdir -p workdir

CR=$(printf "\r")
set +e
./scripts/get-uptime.tcl $1 2>&1 > /dev/null || true
set -e
REGEX="s#\.[0-9]*${CR}##g"

if grep -q "/proc/uptime" workdir/$1.uptime.txt; then
  cat workdir/$1.uptime.txt | tail -n 3 | head -n 1 | awk '{print $1}' | sed $REGEX
else
  echo 0
fi
