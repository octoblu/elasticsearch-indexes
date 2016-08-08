#!/bin/bash

ELASTIC_PORT=${ELASTIC_PORT:-9200}
BASE_URL=${BASE_URL:-http://localhost:${ELASTIC_PORT}}

curl -XPUT "${BASE_URL}/_template/verification" -d '{
  "template": "verifications*",
  "order": 1,
  "mappings": {
    "_default_": {
      "dynamic": false,
      "properties": {
        "type": {
          "type": "string",
          "fields": {
            "raw": {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        },
        "index": {
          "type": "string",
          "fields": {
            "raw": {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        },
        "date": {
          "type": "date"
        },
        "metadata": {
          "properties": {
            "name": {
              "type": "string",
              "fields": {
                "raw" : {
                  "type": "string",
                  "index": "not_analyzed"
                }
              }
            },
            "success": {
              "type": "boolean"
            },
            "expires": {
              "type": "date"
            }
          }
        }
      }
    }
  }
}'
