#!/bin/bash

EVENT='gateblu_device_detail_history'
NEW_VERSION=1
ELASTIC_PORT=${ELASTIC_PORT:-9200}
BASE_URL=${BASE_URL:-http://localhost:${ELASTIC_PORT}}

curl -X PUT "$BASE_URL/${EVENT}_v${NEW_VERSION}" -d '{
  "settings" : {
    "index": {
      "number_of_shards": 5
    }
  },
  "mappings": {
    "event": {
      "dynamic": false,
      "_timestamp": {
        "enabled": true,
        "store": true
      },
      "properties": {
        "successes": {
          "type": "integer"
        },
        "failures": {
          "type": "integer"
        },
        "total": {
          "type": "integer"
        },
        "workflow": {
          "type": "string",
          "fields": {
            "raw" : {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        },
        "connector": {
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
curl -X POST "$BASE_URL/_aliases" -d "$alias_command"
