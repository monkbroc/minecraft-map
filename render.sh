#!/bin/bash

# Only set defaults if not already defined
: "${WORLD_PATH:=/mnt/world}"
: "${OUTPUT_PATH:=/opt/www}"
: "${UNMINED:=/opt/unmined-cli/unmined-cli}"

echo "[$(date)] Starting map render"
echo "World path: $WORLD_PATH"
echo "Output path: $OUTPUT_PATH"
echo "uNmINeD binary: $UNMINED"

mkdir -p "$OUTPUT_PATH"

"$UNMINED" web render \
    --world="$WORLD_PATH" \
    --output="$OUTPUT_PATH" \
    --players -c

echo "[$(date)] Map render complete"
