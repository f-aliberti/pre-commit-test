#!/bin/bash

#FOR POST-CHECKOUT

#This hook is invoked when a git-checkout[1] or git-switch[1] is run after having updated the worktree. 
#The hook is given three parameters: the ref of the previous HEAD, 
#the ref of the new HEAD (which may or may not have changed), 
#and a flag indicating whether the checkout was a branch checkout (changing branches, flag=1) 
#or a file checkout (retrieving a file from the index, flag=0). 
#This hook cannot affect the outcome of git switch or git checkout, 
#other than that the hook’s exit status becomes the exit status of these two commands.
# documentation: https://git-scm.com/docs/githooks

#if [ $3 != '1' ]
#    then echo 'git checkout did not checkout a branch - quitting';
#    exit
#fi

branch=$(git rev-parse --abbrev-ref HEAD)

if [[ $branch != feature/* ]]
    then echo 'Not Feature branch';
    exit
fi

branch="${branch#'feature/'}"  

#echo $branch
[[ $branch =~ ^E4T[0-9]{4}$ ]] || echo 'Remane branch with E4TXXXX (X are [0-9] digit)'

# get current version of the top level pom
current_version=$(mvn help:evaluate -Dexpression=project.version | grep -v '\[.*')

echo 'current version:' $current_version

current_version_cutted=$(echo $current_version | cut -f1 -d \-)

new_version=$current_version_cutted'-'$branch'-SNAPSHOT'

echo 'version to set:' $new_version

if [[ $current_version != $new_version ]]
    then mvn versions:set -DgenerateBackupPoms=false -DnewVersion=$new_version;
    exit
fi

echo 'no need set version'
