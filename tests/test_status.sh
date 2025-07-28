#!/bin/bash
STASH=""

source "functions/git_status.sh"
for repo in $(cat "/tmp/repositories.txt"); do 
    echo "===Repo: $repo ==="
    git_status "$repo"
    echo
done

