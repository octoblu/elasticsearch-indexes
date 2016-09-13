#!/bin/bash

ELASTIC_PORT=${ELASTIC_PORT:-9200}
BASE_URL=${BASE_URL:-http://localhost:${ELASTIC_PORT}}

curl -XPUT "${BASE_URL}/_template/meshblu_job" -d '{
  "template": "meshblu_job*",
  "order": 1,
  "aliases": {
    "meshblu_job_last_7_days": {}
  },
  "mappings": {
    "_default_": {
      "dynamic": false,
      "_timestamp": {
        "enabled": true,
        "store": true
      },
      "properties": {
         "date": {
           "type": "date"
         },
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
                     "taskName": {
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
                     "success": {
                        "type": "boolean"
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