#!/bin/bash
branch=$(git rev-parse --abbrev-ref HEAD)

if [[ "$branch" != "develop" ]]
    then echo 'Not develop branch';
    exit
fi

echo $branch
# get current version of the top level pom
current_version=$(mvn help:evaluate -Dexpression=project.version | grep -v '\[.*')

current_version=$(echo $current_version | cut -f1 -d \-)

echo $current_version

new_version=$current_version'-SNAPSHOT'

echo 'version to set:' $new_version

# run maven versions plugin to set new version
python -c 'import sys;
import os;
import subprocess;
subprocess.Popen(["mvn", "versions:set","-DgenerateBackupPoms=false","-DnewVersion="+sys.argv[1],], stdout=open(os.devnull,"w"), stderr=subprocess.STDOUT)' $new_version