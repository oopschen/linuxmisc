#!/bin/bash

if [ $# -lt 1 ];then
  echo "Usage: sh doc_rep.sh [android doc directory]"
  exit 1
fi

andriodDocDir=$1

# replace 
echo "replace js url"
find ${andriodDocDir} -iname "*.html" | xargs sed  -i "s@https://developer.android.com/ytblogger_lists_unified.js/@/ytblogger_lists_unified.js/@ig"

echo "replace fonts url"
find ${andriodDocDir} -iname "*.html" | xargs sed  -i "s@http://fonts.googleapis.com/@/abc/@ig"
