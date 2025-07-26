#!/bin/bash

#create a testing enviroment setup script
# running this script will create a few directories with a specific style of folder structure
# and file names in order to run tests on the accuracy of our product!
fake_dir_abs_path="$(pwd)/fake_file_system"

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
#
# create a directory structure 4 directories so far..#
# lets add some bad actors to hopefully avoid : bad files simple have _BAD_ in the file name
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
