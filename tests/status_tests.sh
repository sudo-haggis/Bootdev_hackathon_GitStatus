#!/bin/bash

source "functions/git_status.sh"
test_dir="/tmp/repo_tmp/"

cd $test_dir

test_get_status(){
    echo "Testing git status in $test_dir"

    git_status "$test_dir"
}

test_get_status
