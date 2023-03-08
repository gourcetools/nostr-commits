#!/bin/bash

SLEEP=30

# Replace <github_username> and <github_repo> with the actual username and repo name
GITHUB_URL="https://api.github.com/repos/<github_username>/<github_repo>/commits"

# Get the latest commit ID and store it in a file called "last_commit_id.txt"
curl -s $GITHUB_URL | grep '"sha":' | head -n 1 | cut -d'"' -f4 > last_commit_id.txt
echo "Initial commit ID: $(cat last_commit_id.txt)"

# Loop forever
while :
do
  # Wait for X seconds
  sleep $SLEEP

  # Get the latest commit ID again
  curl -s $GITHUB_URL | grep '"sha":' | head -n 1 | cut -d'"' -f4 > new_commit_id.txt

  # Compare the new commit ID to the old one
  if [ "$(cat new_commit_id.txt)" != "$(cat last_commit_id.txt)" ]
  then

    echo "NEW COMMIT: $(cat new_commit_id.txt)"
    # Update the old commit ID with the new one
    mv new_commit_id.txt last_commit_id.txt
  else
    echo "NO NEW COMMIT."
  fi
done
