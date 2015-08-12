#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
FILES=($(ls $DIR/event_*.sh))
EVENTS=()

for FILE in "${FILES[@]}"; do
  EVENTS+=($(basename $FILE | sed -e 's/\.sh//g'))
done

if [ $# -ne 0 ]; then
  EVENTS=($@)
fi

for EVENT in "${EVENTS[@]}"; do
  read -r -d '' alias_command <<EOF
  {
    "actions": [
      {
        "remove": {
            "alias": "${EVENT}",
            "index": "${EVENT}_v1"
        }
      }
    ]
  }
EOF

  curl -X POST http://localhost:9200/_aliases -d "$alias_command"
  curl -X DELETE "http://localhost:9200/${EVENT}_v1"
  curl -X DELETE "http://localhost:9200/${EVENT}"
done
