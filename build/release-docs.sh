#!/bin/sh
OLDV=$1
NEWV=$2

echo $NEWV
echo ''
git log --oneline $OLDV..$NEWV | grep 'Merge pull request #'
echo ''
git log --oneline $OLDV..$NEWV | grep -v Merge | grep -v 'Bump version'