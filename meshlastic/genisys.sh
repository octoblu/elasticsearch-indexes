#!/bin/bash

ELASTIC_PORT=${ELASTIC_PORT:-9200}
BASE_URL=${BASE_URL:-http://localhost:${ELASTIC_PORT}}

curl -XPUT "${BASE_URL}/_template/genisys-room-state" -d '{
  "template": "genisys-room-state*",
  "order": 1,
  "mappings": {
    "_default_": {
      "dynamic": false,
      "properties": {
        "uuid": {
          "type": "string",
          "index": "not_analyzed"
        },
        "meshblu": {
          "type": "object",
          "properties": {
            "updatedAt": {
              "type": "date"
            },
            "updatedBy": {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        },
        "genisys": {
          "type": "object",
          "properties": {
            "inSkype": {
              "type": "boolean"
            },
            "currentMeeting": {
              "type": "object",
              "properties": {
                "meetingId": {
                  "type": "string",
                  "index": "not_analyzed"
                },
                "startTime": {
                  "type": "date"
                },
                "endTime": {
                  "type": "date"
                },
                "subject": {
                  "type": "string",
                  "index": "not_analyzed"
                }
              }
            },
            "peopleInRoom": {
              "type": "nested",
              "properties": {
                "userUuid": {
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
