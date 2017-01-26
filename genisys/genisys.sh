#!/bin/bash

ELASTIC_PORT=${ELASTIC_PORT:-9200}
BASE_URL=${BASE_URL:-http://localhost:${ELASTIC_PORT}}

curl -XPUT "${BASE_URL}/_template/genisys-meetings" -d '{
  "template": "genisys-meetings*",
  "order": 1,
  "mappings": {
    "_default_": {
      "dynamic": false,
      "properties": {
        "meetingId": {
          "type": "string",
          "index": "not_analyzed"
        },
        "roomId": {
          "type": "string",
          "index": "not_analyzed"
        },
        "roomName": {
          "type": "string",
          "index": "not_analyzed"
        },
        "startTime": {
          "type": "date"
        },
        "endTime": {
          "type": "date"
        },
        "duration": {
          "type": "long"
        }
      }
    }
  }
}'
