#!/bin/bash

ELASTIC_PORT=${ELASTIC_PORT:-9200}
BASE_URL=${BASE_URL:-http://localhost:${ELASTIC_PORT}}

EVENT='device_status_flow'
NEW_VERSION=1

curl -XPUT "${BASE_URL}/${EVENT}_v${NEW_VERSION}" -d '{
  "mappings": {
    "event": {
      "dynamic": false,
      "properties": {
        "payload": {
          "type": "object",
          "properties": {
            "date": {
              "type": "date"
            },
            "application" : {
              "type": "string",
              "fields": {
                "raw" : {
                  "type": "string",
                  "index": "not_analyzed"
                }
              }
            },
            "deploymentUuid" : {
              "type": "string",
              "fields": {
                "raw" : {
                  "type": "string",
                  "index": "not_analyzed"
                }
              }
            },
            "flowUuid" : {
              "type": "string",
              "fields": {
                "raw" : {
                  "type": "string",
                  "index": "not_analyzed"
                }
              }
            },
            "message" : {
              "type": "string",
              "fields": {
                "raw" : {
                  "type": "string",
                  "index": "not_analyzed"
                }
              }
            },
            "state" : {
              "type": "string",
              "fields": {
                "raw" : {
                  "type": "string",
                  "index": "not_analyzed"
                }
              }
            },
            "userUuid" : {
              "type": "string",
              "fields": {
                "raw" : {
                  "type": "string",
                  "index": "not_analyzed"
                }
              }
            },
            "workflow" : {
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
curl -XPOST "${ES_HOST}/_aliases" -d "$alias_command"
