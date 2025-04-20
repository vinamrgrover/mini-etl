#!/bin/bash

jq '.items[] | {
  id: .id,
  full_name: .full_name,
  name: .name,
  node_id: .node_id,
  private: .private,
  avatar: .owner.avatar_url,
  repo_url: .owner.html_url,
  description: .description,
  stars: .stargazers_count,
  lang: .language,
  forks: .forks_count
}' data/raw.json >data/enriched.json

echo "✅ Data successfully transformed!"
