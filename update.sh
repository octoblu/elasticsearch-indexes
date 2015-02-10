#!/bin/bash

OLD_VERSION=3
NEW_VERSION=4

./update_aliases.sh $OLD_VERSION $NEW_VERSION && \
  ./meshblu_events_300.sh $OLD_VERSION $NEW_VERSION && \
  ./meshblu_events_401.sh $OLD_VERSION $NEW_VERSION && \
  ./delete_old_indexes.sh $OLD_VERSION
