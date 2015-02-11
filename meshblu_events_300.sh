#!/bin/bash

source ./utils.sh
OLD_VERSION=$1
NEW_VERSION=$2

curl -XPUT "http://localhost:9200/meshblu_events_300_v${NEW_VERSION}" -d '{
  "mappings": {
    "event": {
      "dynamic": false,
      "properties": {
        "timestamp": {
          "type": "date"
        },
        "topic" : {
          "type": "string",
          "fields": {
            "raw" : {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        },
        "fromUuid" : {
          "type": "string",
          "fields": {
            "raw" : {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        },
        "toUuid" : {
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

move_alias 300 $OLD_VERSION $NEW_VERSION
