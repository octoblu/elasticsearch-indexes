#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
FILES=($(ls $DIR/event_*.sh))

for FILE in "${FILES[@]}"; do
  echo $FILE
  # bash "${EVENT}.sh"
done
