#!/bin/bash

EVENT='event_devices'
NEW_VERSION=1

curl -XPUT "http://localhost:9200/${EVENT}_v${NEW_VERSION}" -d '{
  "mappings": {
    "event": {
      "dynamic": false,
      "_timestamp": {
        "enabled": true
      },
      "properties": {
        "fromUuid" : {
          "type": "string",
          "fields": {
            "raw" : {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        }
      }
    }
  }
}'

read -r -d '' alias_command <<EOF
  {
    "actions": [
      {
        "add": {
            "alias": "${EVENT}",
            "index": "${EVENT}_v${NEW_VERSION}"
        }
      }
    ]
  }
EOF
curl -XPOST http://localhost:9200/_aliases -d "$alias_command"
