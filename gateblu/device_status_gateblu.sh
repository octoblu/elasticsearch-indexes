#!/bin/bash

ES_HOST='https://search-meshlastic-jzohajyndq6bowz24ic2jnf3vu.us-west-2.es.amazonaws.com'
EVENT='device_status_gateblu'
NEW_VERSION=1

curl -XPUT "${ES_HOST}/${EVENT}_v${NEW_VERSION}" -d '{
  "mappings": {
    "event": {
      "dynamic": false,
      "_timestamp": {
        "enabled": true,
        "store": true
      },
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
            "deviceUuid" : {
              "type": "string",
              "fields": {
                "raw" : {
                  "type": "string",
                  "index": "not_analyzed"
                }
              }
            },
            "gatebluUuid" : {
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
