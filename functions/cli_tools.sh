#!/bin/bash
#  gitIt CLI Tool
#  This script provides a command-line interface to manage and print reports of local Git repositories.

__init__() {
    ##  Establishes variables for the script  ##

    ##  sets the search directory to the home directory
    SEARCH_DIR="$HOME"
    ##  sets the ignore list file path
    ignore_list="$HOME/.config/gitit/ignore.conf"
    ##  sets the path for the temporary repository list file
    repo_list="/tmp/repositories.txt"
    ##  sets the path for the report file
    report="/tmp/repositories_report.txt"

## removes the temporary repositories.txt file if it exists
    if [ -f "$repo_list" ]; then
    rm "$repo_list"
    fi

## removes the report file if it exists
    if [ -f "$report" ]; then
    rm "$report"
    fi
}

quick_report() {
##  Generates a quick report of all local repositories found in the search directory
    echo "==============================================================================="
    echo
    echo "*gitting* repositories..."
    echo
    echo "==============================================================================="
    ##  searches for .git directories
    find "$SEARCH_DIR" -type d -name ".git" 2>/dev/null | while read -r git_dir; do
    ##  gets the parent directory of the .git directory
    repo_dir=$(dirname "$git_dir")
    ## checks the ignore.conf file for the repository path, ignoring it if present
    if grep -q "$repo_dir" "$ignore_list" 2>/dev/null; then
        echo "Ignoring repository: $repo_dir..."
        continue
    else
    ##  appends the repository path to a temporary repositories.txt file
    echo "$repo_dir" >> "/tmp/repositories.txt"
    
done

echo "Found $(wc -l /tmp/repositories.txt | awk '{print $1}') active repositories"

repolist="/tmp/repositories.txt"

#  flags for the cli tool
case "$1" in
    -h|--help)
        echo                                "gitIt CLI Tool"
        echo "==============================================================================="
        echo "This tool provides a quick report of all local repositories found on your system,"
        echo "as well as the ability to quickly navigate to them."
        echo "==============================================================================="
        echo "Usage: gitit [flags]"
        echo
        echo "Without flags, gitit will display a TUI with a list of all repositories."
        echo "You can navigate to a repository by selecting it with the arrow keys and pressing Enter."
        echo "You can also use the following flags:"
        echo
        echo "Flags:"
        echo "  -h, --help       Show this help message"
        echo "  -r, --report    Generate a report of all repositories"
        echo "  --ignore-repo <REGEX pattern>  Ignore repositories matching the provided pattern"
        echo "                                 This will add the pattern to the ignore.conf file" 
        echo "                                 in $HOME/.config/gitit"
        exit 0
        ;;
    -r|--report)
        if [ -f "$repo_list" ]; then
            echo "Generating report of all repositories..."
            sleep 1
            less "$repo_list"
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
        if [ -f "$repo_list" ]; then
            grep -E "$ignore_pattern" "$repo_list" >> "$ignore_list"
            echo ignore pattern "$ignore_pattern" added to "$HOME"/.config/gitit/ignore.conf
        else
            echo "No repositories found."
        fi
        ;;
    -t|--test-dir)
        SEARCH_DIR="./tests/fake_file_system/"
        echo "Testing directory set to current directory: $SEARCH_DIR"
        quick_report
        exit 0
        ;;
esac

