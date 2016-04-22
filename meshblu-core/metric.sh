#!/bin/bash

ES_HOST='https://search-meshlastic-jzohajyndq6bowz24ic2jnf3vu.us-west-2.es.amazonaws.com'

curl -XPUT "${ES_HOST}/_template/metric" -d '{
  "template": "metric*",
  "order": 1,
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
                "workerName": {
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
                },
                "route": {
                  "type": "nested",
                  "properties": {
                    "from": {
                      "type": "string",
                      "fields": {
                        "raw" : {
                          "type": "string",
                          "index": "not_analyzed"
                        }
                      }
                    },
                    "to": {
                      "type": "string",
                      "fields": {
                        "raw" : {
                          "type": "string",
                          "index": "not_analyzed"
                        }
                      }
                    },
                    "type": {
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
                },
                "error": {
                  "properties": {
                    "message": {
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
    }
  }
}'
