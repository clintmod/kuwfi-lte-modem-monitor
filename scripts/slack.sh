#!/usr/bin/env bash

set -e

if curl -sL -m 5 google.com | grep -o "<title>.*</title>"; then
  echo "All good"
  exit 0
else
  curl -X POST https://hooks.slack.com/services/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 \
  -H 'Content-type: application/json' \
  --data-binary @- << EOF
  {
    "text":"Hello, World!",
    "channel":"#alerts-farm",
    "icon_emoji":":arrow_down:"
  }
  EOF
  exit 1
fi

