#!/bin/bash

source ./utils.sh

EVENTS="100 101 102 200 201 204 205 300 301 302 303 304 305 400 401 402 403 500 600 700 701"
VERSION="1"

for event in $EVENTS; do
  create_index $event $VERSION
  create_alias $event $VERSION
done
