#!/bin/bash

#create a testing enviroment setup script
# running this script will create a few directories with a specific style of folder structure
# and file names in order to run tests on the accuracy of our product!
fake_file_system_name="fake_file_system"
fake_dir_abs_path="$(pwd)/tests/$fake_file_system_name"
set -e # exit if any errorrs occour

echo "Lets make some directories..."

# check were in correct directory
echo "About to create fake file system in $fake_dir_abs_path"
echo "This will abruptly overwrite anything in that dir..."
read -r -p "Continue (Y/n)" choice

if [ "$choice" != "Y" ] && [ "$choice" != "y" ]; then
    echo "Exiting..."
    exit 1
fi

echo "Working... "

# Delete any current fake repos to ensure clenliness
if [ -d "$fake_dir_abs_path" ]; then
    echo "removing current fake file system"
    rm -rf $fake_dir_abs_path
fi

mkdir -p $fake_dir_abs_path
cd $fake_dir_abs_path

echo "Now in $(pwd) ready to start creating some repo's"

# create a directory structure 4 directories so far..

#project alpha, clean and tidy
mkdir -p project_alpha/src/utils
mkdir -p project_alpha/repo_clean

#project beta, not staged
mkdir -p project_beta/docs
mkdir -p project_beta/repo_staged

#project gamma half way through a rebase 
mkdir -p project_gamma/config/misc
mkdir -p project_gamma/repo_rebase

echo "directories created" 

# lets add some bad actors to hopefully avoid : bad files simple have _BAD_ in the file name
touch BAD_marker_file.txt

touch project_alpha/BAD_marker_file.txt
touch project_alpha/src/utils/BAD_marker_file.txt

touch project_beta/BAD_marker_file.txt
touch project_beta/docs/BAD_marker_file.txt

touch project_gamma/BAD_marker_file.txt
touch project_gamma/config/BAD_marker_file.txt
touch project_gamma/config/misc/BAD_marker_file.txt

echo "Bad actors added to file system" 
tree
#
# STEP 1 : lets make a clean perfect repo to test
#
# STEP 2 : lets make a repo with some uncommited files
#
# STEP 3 : lets also have ourself a repo thats half way through a rebase!
#
# STEP 4 and beyond can come later!
#
# COMPLETION
#
# Output a summary and maybe a tree diagram to show what we have made!
