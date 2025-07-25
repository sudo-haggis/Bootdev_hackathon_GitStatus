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
        local repo_name=$(basename $(git rev-parse --show-toplevel))
        local repo_curr_branch=$(git branch --show-current)
        echo "Found $repo_name on branch $repo_curr_branch" && return 0

        local staged_changes=$(git diff --cahced --name-only | wc -l)
        local modified=$(git diff --name-only | wc -l)

        echo "Files: ${staged} staged, ${modified} modified"

        if [ $staged -gt 0 ] || [ $modified -gt 0 ]; then
            git status -s --untracked-files=no | head --8 
        else
            echo "Clean treee"
        fi
    fi
}
