curl -XPUT http://localhost:9200/skynet_trans_log_v2 -d '{
  "mappings": {
    "info": {
      "properties": {
        "@fields": {
          "properties": {
            "topic" : {
              "type": "multi_field",
              "fields": {
                "raw" : {
                  "type": "string",
                  "index": "not_analyzed"
                }
              }
            },
            "fromUuid" : {
              "type": "multi_field",
              "fields": {
                "raw" : {
                  "type": "string",
                  "index": "not_analyzed"
                }
              }
            },
            "toUuid" : {
              "type": "multi_field",
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

curl -XPOST http://localhost:9200/_aliases -d '
{
    "actions": [
        { "remove": {
            "alias": "skynet_trans_log",
            "index": "skynet_trans_log_v2"
        }},
        {
          "add": {
              "alias": "skynet_trans_log",
              "index": "skynet_trans_log_v1"
          }
        }
    ]
}
'


