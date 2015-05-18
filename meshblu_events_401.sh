#!/bin/bash

source ./utils.sh
OLD_VERSION=$1
NEW_VERSION=$2

curl -XPUT "http://localhost:9200/meshblu_events_401_v${NEW_VERSION}" -d '{
  "mappings": {
    "event": {
      "dynamic": false,
      "properties": {
        "timestamp": {
          "type": "date"
        },
        "uuid" : {
          "type": "string",
          "fields": {
            "raw" : {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        },
        "type" : {
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

move_alias 401 $OLD_VERSION $NEW_VERSION
