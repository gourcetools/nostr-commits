#!/bin/bash

# Replace <github_username>, <github_repo>, <api_key>, and <sleep_time> with the actual values
SLEEP_TIME="<sleep_time>"
GITHUB_USERNAME="<github_username>"
GITHUB_REPO="<github_repo>"



GITHUB_URL="https://api.github.com/repos/$GITHUB_USERNAME/$GITHUB_REPO/commits?access_token=$API_KEY"


# API_KEY="<api_key>"
# GITHUB_URL="https://api.github.com/repos/$GITHUB_USERNAME/$GITHUB_REPO/commits?access_token=$API_KEY"



# Create a file to store the last modified time of the latest commit
touch last_commit_time.txt

# Loop forever
while :
do
  # Get the last modified time of the latest commit
  last_commit_time=$(cat last_commit_time.txt)

  # Download the latest commits that have been modified since the last time they were checked
  latest_commits=$(curl -s -z "$last_commit_time" -H "If-Modified-Since: $last_commit_time" "$GITHUB_URL")

  # Check if there are any new commits
  if [ "$latest_commits" != "" ]
  then
    # Extract the latest commit ID and last modified time
    latest_commit_id=$(echo "$latest_commits" | grep '"sha":' | head -n 1 | cut -d'"' -f4)
    latest_commit_time=$(echo "$latest_commits" | grep '"date":' | head -n 1 | cut -d'"' -f4)

    # Write the new commit ID and last modified time to disk
    echo "$latest_commit_id" > last_commit_id.txt
    echo "$latest_commit_time" > last_commit_time.txt

    # Print the new commit ID
    echo "NEW COMMIT: $latest_commit_id"
  else
    # Print a message indicating that there are no new commits
    echo "NO NEW COMMIT."
  fi

  # Wait for the specified sleep time
  sleep $SLEEP_TIME
done
