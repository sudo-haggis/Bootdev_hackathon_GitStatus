#!/bin/bash
git_status() {
    #param1 is directory path to deal with 
    #move to the directory specified
    abs_path=$1
    cd $abs_path

    #if we find a .git file, 
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Not a repo" && return 1
    else 
        #show some details
        repo_name=$(basename $(git rev-parse --show-toplevel))
        repo_curr_branch=$(git branch --show-current)
        echo "Found Repo $repo_name on branch $repo_curr_branch" && return 0
    fi
}
