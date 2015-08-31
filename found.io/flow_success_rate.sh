#!/bin/bash

EVENT='flow_success_rate'
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
        "captureRangeInMinutes": {
          "type": "long"
        },
        "failurePercentage": {
          "type": "long"
        },
        "failureRate": {
          "type": "long"
        },
        "failures": {
          "type": "long"
        },
        "successPercentage": {
          "type": "long"
        },
        "successRate": {
          "type": "long"
        },
        "successes": {
          "type": "long"
        },
        "total": {
          "type": "long"
        },
        "workflow": {
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
