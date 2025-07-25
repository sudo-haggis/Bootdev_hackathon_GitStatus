#!/bin/bash

#  search the computer for repositories, adding them to a .txt file
echo "Getting repositories..."
##  checks if the temporary repositories.txt file exists, if so, removes it
if [ -f "/tmp/repositories.txt" ]; then
    rm "/tmp/repositories.txt"
fi
##  sets the search directory to the home directory
SEARCH_DIR="$HOME"
##  searches for .git directories
find "$SEARCH_DIR" -type d -name ".git" 2>/dev/null | while read -r git_dir; do
    ##  gets the parent directory of the .git directory
    repo_dir=$(dirname "$git_dir")
    ##  appends the repository path to a temporary repositories.txt file
    echo "$repo_dir" >> "/tmp/repositories.txt"
done

repolist="/tmp/repositories.txt"

#  flags for the cli tool
case "$1" in
    -h|--help)
        echo "Usage: gitit [flags]"
        echo "Flags:"
        echo "  -h, --help       Show this help message"
        echo "  -r, --report    Generate a report of all repositories"
        exit 0
        ;;
    -r|--report)
        if [ -f "$repolist" ]; then
            less "$repolist"
        else
            echo "No repositories found."
        fi
        exit 0
        ;;
    --ignore-repo)
        #  Check if the ignore pattern is provided
        if [ -z "$2" ]; then
            echo "Error: No ignore pattern provided."
            echo "Usage: gitit --ignore-repo <REGEX pattern>"
            exit 1
        fi
        #  Check if the ignore.conf file exists, if not, create it
        ignore_pattern="$2"
        if [ ! -f "$HOME/.config/gitit/ignore.conf" ]; then
            mkdir -p "$HOME/.config/gitit"
            touch "$HOME/.config/gitit/ignore.conf"
        fi
        #  Append the ignore pattern to the ignore.conf file
        if [ -f "$repolist" ]; then
            grep -E "$ignore_pattern" "$repolist" >> "$HOME/.config/gitit/ignore.conf"
            echo ignore pattern "$ignore_pattern" added to "$HOME"/.config/gitit/ignore.conf
        else
            echo "No repositories found."
        fi
        ;;
esac

