#!/bin/bash

# Setup git globals
echo 'Config git globals'
git config --global user.name "$(git log -n 1 --pretty=format:%an)"
git config --global user.email "$(git log -n 1 --pretty=format:%ae)"


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
  #echo 'Creating git tag'
  git tag -a $new_version -m "Tag $new_version for design system"
  echo "Pushing new tag"

  git push origin --porcelain 1.1.2

  echo "Pushed new tag to origin successfully"

  if [ "$tag_output" == *"[new tag]         $new_version -> $new_version"* ]
  then
    echo 'Creating tag successful. Getting changelog content'
    {
      echo 'content<<EOF'
      ./scripts/release-docs.sh "$current_version" "$new_version"
      echo EOF
    } >> "$GITHUB_OUTPUT"
    echo "new_version=${new_version}" >> $GITHUB_OUTPUT
  else
    echo "Pushing tag to origin failed"
  fi
else
  echo "Skipping release as new version is invalid: $new_version"
fi