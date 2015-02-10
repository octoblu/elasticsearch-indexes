#!/bin/bash

source ./utils.sh

EVENTS="100 101 102 200 201 204 205 301 302 303 304 305 400 401 402 403 500 600 700 701"
OLD_VERSION="2"
NEW_VERSION="3"

for event in $EVENTS; do
  create_index $event $NEW_VERSION
  move_alias $event $OLD_VERSION $NEW_VERSION
done
