#!/bin/bash

EVENTS=(event_claimdevice event_data event_devices event_generatetoken event_getpublickey event_identity event_localdevices event_message event_register event_resettoken event_revoketoken event_subscribe event_unclaimeddevices event_unregister event_update event_whoami)

for EVENT in "${EVENTS[@]}"; do
  bash "${EVENT}.sh"
done
