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
mvn versions:set-property -Dproperty=revision -DgenerateBackupPoms=false -DnewVersion=$new_version