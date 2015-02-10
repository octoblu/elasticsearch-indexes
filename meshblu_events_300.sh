#!/bin/bash

source ./utils.sh
VERSION="1"

curl -XPUT "http://localhost:9200/meshblu_events_300_v${VERSION}" -d '{
  "mappings": {
    "events": {
      "properties": {
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

create_alias 300 $VERSION
