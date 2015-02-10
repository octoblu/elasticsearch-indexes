#!/bin/bash

EVENTS="100 101 102 200 201 204 205 300 301 302 303 304 305 400 401 402 403 500 600 700 701"
VERSION="2"

for event in $EVENTS; do
  # magic
  curl -XDELETE "http://localhost:9200/meshblu_events_${event}_v${VERSION}"
done
