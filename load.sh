#!/bin/bash

jq -c '.' data/enriched.json >data/c.json

source .env
export PGPASSWORD=$POSTGRES_PASSWORD
echo "✅ Dropping existing tables and creating tables: repo_stats_staging and repo_stats"
psql -U "$POSTGRES_USER" -h "$POSTGRES_HOST" -d "$POSTGRES_DATABASE" <<SQL >/dev/null
DROP TABLE IF EXISTS repo_stats;
DROP TABLE IF EXISTS repo_stats_staging;

CREATE TABLE repo_stats_staging (
    data JSONB
);

-- Create the final table with individual columns
CREATE TABLE repo_stats (
    id BIGINT PRIMARY KEY,
    full_name TEXT,
    name TEXT,
    node_id TEXT,
    private BOOLEAN,
    avatar TEXT,
    repo_url TEXT,
    description TEXT,
    stars INT,
    lang TEXT,
    forks INT
);
SQL

echo "✅ Ingesting data from data/c.json to repo_stats_staging"
psql -U "$POSTGRES_USER" -h "$POSTGRES_HOST" -d "$POSTGRES_DATABASE" -c "\\copy repo_stats_staging(data) FROM 'data/c.json'" >/dev/null

echo "✅ Loading data into repo_stats table"
psql -U "$POSTGRES_USER" -h "$POSTGRES_HOST" -d "$POSTGRES_DATABASE" <<SQL >/dev/null
INSERT INTO repo_stats (
    id, full_name, name, node_id, private,
    avatar, repo_url, description, stars, lang, forks
)
SELECT
    (data->>'id')::BIGINT,
    data->>'full_name',
    data->>'name',
    data->>'node_id',
    (data->>'private')::BOOLEAN,
    data->>'avatar',
    data->>'repo_url',
    data->>'description',
    (data->>'stars')::INT,
    data->>'lang',
    (data->>'forks')::INT
FROM repo_stats_staging;
SQL

echo "✅ Dropping repo_stats_staging table"
psql -U "$POSTGRES_USER" -h "$POSTGRES_HOST" -d "$POSTGRES_DATABASE" -c "DROP TABLE repo_stats_staging;" >/dev/null

echo "✅ Data successfully loaded into table 'repo_stats' in database '$POSTGRES_DATABASE'."
