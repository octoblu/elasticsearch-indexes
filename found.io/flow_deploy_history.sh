#!/bin/bash

EVENT='flow_deploy_history'
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
        "beginTime": {
          "type": "date",
          "format": "dateOptionalTime"
        },
        "deploymentUuid": {
          "type": "string",
          "fields": {
            "raw" : {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        },
        "elapsedTime": {
          "type": "long"
        },
        "endTime": {
          "type": "date",
          "format": "dateOptionalTime"
        },
        "success": {
          "type": "boolean"
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
