#!/bin/bash

SOURCE_JSON_FILE="maps.json"
DESTINATION_DIR="./www"

mkdir -p "$DESTINATION_DIR"

jq 'map(del(.downloadLink))' "$SOURCE_JSON_FILE" > "$DESTINATION_DIR/maps.json"

echo "Processed file has been copied to $DESTINATION_DIR"
