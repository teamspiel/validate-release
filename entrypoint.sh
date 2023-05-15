#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# If set, the return value of a pipeline is the value of the last (rightmost) command to exit with a non-zero status
set -o pipefail

# Starting the validation process
echo "Starting validation $1"

# Get the remote branch that contains the commit id 
BRANCH=$(git branch -r --contains ${GITHUB_SHA})

# Extract the release version from the GitHub reference, replace slashes with dashes
RELEASE_VERSION=$(echo ${GITHUB_REF} | sed -e "s/refs\/tags\///g" | sed -e "s/\//-/g")

# main branch name
MAIN_BRANCH_NAME='origin/main'

# Release prefix
RELEASE_PREFIX='r-'

# Check if the branch is main, the release version starts with the release prefix and it's not a pre-release
if [[ "${INPUT_PRERELEASE}" != true ]] && [[ "$BRANCH" == *"$MAIN_BRANCH_NAME"* ]] && [[ "$RELEASE_VERSION" == "$RELEASE_PREFIX"* ]]; then
  # If conditions are met, validation is successful
  echo "Release tag validation succeeded!"
  exit 0

# Check if it's a pre-release
elif [[ "${INPUT_PRERELEASE}" == true ]]; then
  # If it's a pre-release, validation is successful
  echo "Pre-Release tag validation succeeded!"
  exit 0

else
  # If none of the conditions are met, validation fails
  echo "Tag validation failed!"
  exit 1
fi