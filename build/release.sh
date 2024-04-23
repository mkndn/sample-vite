#!/bin/sh

# Setup git globals
echo 'Config git globals'
git config --global user.name "$(git log -n 1 --pretty=format:%an)"
git config --global user.email "$(git log -n 1 --pretty=format:%ae)"


# Fetching current and new version
echo 'Fetching current and the next version'
current_version="1.1.1"
new_version="1.1.2"
echo "current_version=${current_version}"
echo "new_version=${new_version}"

# Creating git tag
if [ ! -z "$new_version" ]
then
  #echo 'Creating git tag'
  #git tag -a $tag -m "Tag $tag for design system"
  #git push origin $tag

  echo 'Getting changelog content'
  cgl_content="$(./release-docs.sh $old_tag $new_tag)"
  echo "content<<EOF"$'\n'"$cgl_content"$'\n'EOF >> $GITHUB_OUTPUT
  echo "new_version=${new_version}" >> $GITHUB_OUTPUT
else
  echo "Skipping release as new version is invalid: $new_version"
fi