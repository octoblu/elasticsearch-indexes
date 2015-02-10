function create_index() {
  event=$1
  version=$2
  # not a whole lot of magic
  curl -XPOST "http://localhost:9200/meshblu_events_${event}_v${version}"
}

function create_alias() {
  event=$1
  version=$2

  # magic
  read -r -d '' alias_command <<EOF
  {
    "actions": [
      { 
        "add": {
            "alias": "meshblu_events_${event}",
            "index": "meshblu_events_${event}_v${version}"
        }
      }
    ]
  }
EOF

  curl -XPOST http://localhost:9200/_aliases -d "$alias_command"
}

function move_alias() {
  event=$1
  old_version=$2
  new_version=$3

  # magic
  read -r -d '' alias_command <<EOF
  {
    "actions": [
      { 
        "remove": {
            "alias": "meshblu_events_${event}",
            "index": "meshblu_events_${event}_v${old_version}"
        }
      },
      { 
        "add": {
            "alias": "meshblu_events_${event}",
            "index": "meshblu_events_${event}_v${new_version}"
        }
      }
    ]
  }
EOF

  curl -XPOST http://localhost:9200/_aliases -d "$alias_command"
}