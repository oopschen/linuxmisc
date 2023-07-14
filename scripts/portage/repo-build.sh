#!/usr/bin/env bash
# default values
input_repo_dir=
localrepodir=
pkg_name=

if [ 1 -eq $# ]; then
    pkg_name=$1
    localrepodir=/var/db/repos/local
elif [ 2 -eq $# ]; then
    pkg_name=$2
    localrepodir=/var/db/repos/local
elif [ 2 -gt $# ]; then
    echo "sh $(basename $0) [local_repo_dir] package_name"
    exit 1
fi


## change owner
chown -R portage:portage $localrepodir

## gen manifest
if [ ! -d "$localrepodir/$package_name" ]; then
    echo "No dir found: $localrepodir/$package_name"
    exit 2
fi
cd $localrepodir/$package_name
pkgdev manifest && pkgcheck scan
