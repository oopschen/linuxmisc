#!/bin/bash
### Usage:
###   ./new_branch trunkURL

if [ $# -lt 1 ]; then
  echo -e "Usage:\n \t./new_branch.sh trunkURL"
  exit 1
fi

trunkURL=$1
formatDate=$(date +%Y%m%d)
branchURL=${trunkURL/trunk/branches}/branch-${formatDate}
baseDir=$(dirname $0)
curDir=$(pwd)

svn cp -m "new branch at ${formatDate}: ${branchURL}" ${trunkURL} ${branchURL}
echo "checkout new branch ${branchURL}"
