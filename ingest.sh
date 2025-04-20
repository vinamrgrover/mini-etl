#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: First argument (search query) is required!"
  exit 1
fi
source .env
export PGPASSWORD=$POSTGRES_PASSWORD

QUERY=$1

echo "Fetching GitHub data for query: $QUERY"
curl -s "https://api.github.com/search/repositories?q=${QUERY}&per_page=10" >data/raw.json

#psql -U $POSTGRES_USER --host $POSTGRES_HOST -c "SELECT current_user;"
echo "✅ Data successfully extracted from github!"
