#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: First argument (search query) is required!"
  exit 1
fi

QUERY=$1
echo "⚙️ Running ingestion"
./ingest.sh $QUERY
echo "🔀 Running transformation"
./transform.sh
echo "💿 Running load"
./load.sh
