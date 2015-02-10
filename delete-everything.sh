#!/bin/bash

EVENTS="100 101 102 200 201 204 205 300 301 302 303 304 305 400 401 402 403 500 600 700 701"
VERSION="1"

for event in $EVENTS; do
  # magic
  read -r -d '' alias_command <<EOF
  {
    "actions": [
      { 
        "remove": {
            "alias": "meshblu_events_${event}",
            "index": "meshblu_events_${event}_v${VERSION}"
        }
      }
    ]
  }
EOF

  curl -XPOST http://localhost:9200/_aliases -d "$alias_command"

  # magic
  curl -XDELETE "http://localhost:9200/meshblu_events_${event}_v${VERSION}"
done
