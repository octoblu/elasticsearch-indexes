#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
FILES=($(ls $DIR/device_*.sh))

for FILE in "${FILES[@]}"; do
  bash ${FILE}
done
