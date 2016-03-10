#!/bin/bash
### Usage:
###   ./merge_trunk.sh branch_url start_version_num 

if [ $# -lt 2 ]; then
  echo -e "Usage:\n \t./merge_trunk.sh branch_url start_version_num"
  exit 1
fi

branchURL=$1
mergeVersion=$2
tagURL=${branchURL/branches/tags}
trunkURL=${branchURL%%branches/*}trunk
baseDir=$(dirname $0)
curDir=$(pwd)
formatDate=$(date +%Y%m%d)

workingDir=work-$RANDOM
while [[ -d ${baseDir}/${workingDir} ]]; do
  workingDir=work-$RANDOM
done

workDirPath=${baseDir}/${workingDir}
# check out trunk
echo "checkout branch ${branchURL}"
svn -q co ${trunkURL} ${workDirPath}

# merge the branch
cd ${workDirPath}
echo "merge branch ${branchURL} to trunk"
svn merge -r ${mergeVersion}:HEAD ${branchURL} .
svn commit -m "merge branch ${branchURL}@${mergeVersion} at ${formatDate}"
cd ${curDir}
# tag the branch
svn cp -m 'tag branch ${branchURL}' ${branchURL} ${tagURL}
# delete the branch
svn delete -m "delete branch after merge ${formatDate}" ${branchURL}
# remove the working dir
rm -rf ${workDirPath}
