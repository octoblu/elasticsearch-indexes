#!/bin/bash

INDEX='meshblu_job'
NEW_VERSION=1

curl -XPUT "http://localhost:9200/${INDEX}_v${NEW_VERSION}" -d '{
  "mappings": {
    "dispatcher": {
      "dynamic": false,
      "_timestamp": {
        "enabled": true,
        "store": true
      },
      "properties": {
         "elapsedTime": {
            "type": "long"
         },
         "request": {
            "properties": {
               "metadata": {
                  "properties": {
                     "auth": {
                        "properties": {
                           "uuid": {
                              "type": "string",
                              "fields": {
                                "raw" : {
                                  "type": "string",
                                  "index": "not_analyzed"
                                }
                              }
                           }
                        }
                     },
                     "fromUuid": {
                        "type": "string",
                        "fields": {
                          "raw" : {
                            "type": "string",
                            "index": "not_analyzed"
                          }
                        }
                     },
                     "jobType": {
                        "type": "string",
                        "fields": {
                          "raw" : {
                            "type": "string",
                            "index": "not_analyzed"
                          }
                        }
                     },
                     "responseId": {
                        "type": "string",
                        "fields": {
                          "raw" : {
                            "type": "string",
                            "index": "not_analyzed"
                          }
                        }
                     },
                     "toUuid": {
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
         },
         "response": {
            "properties": {
               "metadata": {
                  "properties": {
                     "code": {
                        "type": "long"
                     },
                     "responseId": {
                        "type": "string",
                        "fields": {
                          "raw" : {
                            "type": "string",
                            "index": "not_analyzed"
                          }
                        }
                     },
                     "status": {
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
    }
  }
}'

read -r -d '' alias_command <<EOF
  {
    "actions": [
      {
        "add": {
            "alias": "${INDEX}",
            "index": "${INDEX}_v${NEW_VERSION}"
        }
      }
    ]
  }
EOF
curl -XPOST http://localhost:9200/_aliases -d "$alias_command"
