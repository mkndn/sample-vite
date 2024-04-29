#!/bin/bash

# Setup git globals
echo 'Config git globals'
git config --global user.name "mkndn"
git config --global user.email "mkndn.rk@gmail.com"


# Fetching current and new version
echo 'Fetching current and the next version'
current_version="1.1.1"
new_version="1.1.2"
npm --version
echo "current_version=${current_version}"
echo "new_version=${new_version}"

# Creating git tag
if [ ! -z "$new_version" ]
then
  echo 'Creating tag successful. Getting changelog content'
  {
    echo 'content<<EOF'
    ./scripts/release-docs.sh "$current_version" "$new_version"
    echo EOF
  } >> "$GITHUB_OUTPUT"
  echo "new_version=${new_version}" >> $GITHUB_OUTPUT
else
  echo "Skipping release as new version is invalid: $new_version"
fi