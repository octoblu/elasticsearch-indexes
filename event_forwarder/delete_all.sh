#!/bin/bash

EVENTS=(event_claimdevice event_data event_devices event_generatetoken event_getpublickey event_identity event_localdevices event_message event_register event_resettoken event_revoketoken event_subscribe event_unclaimeddevices event_unregister event_update event_whoami)

for EVENT in "${EVENTS[@]}"; do
  read -r -d '' alias_command <<EOF
  {
    "actions": [
      {
        "remove": {
            "alias": "${event}",
            "index": "${event}_v1"
        }
      }
    ]
  }
EOF

  curl -X POST http://localhost:9200/_aliases -d "$alias_command"
  curl -X DELETE "http://localhost:9200/${EVENT}_v1"
done
