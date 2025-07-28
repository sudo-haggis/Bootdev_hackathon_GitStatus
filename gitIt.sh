#!/bin/bash
source ./functions/cli_tools.sh
cat <<'EOF'

        _ __  __________
  ___ _(_) /_/  _/_  __/
 / _ `/ / __// /  / /   
 \_, /_/\__/___/ /_/    
/___/                   
EOF
gitIt() {
    case "$1" in
        ""|--default) __init__
            if [ -f "$repo_list" ]; then
            echo "             Generating git status for all repositories..."
            echo "========================================================================================="
            for repo in $(cat "$repo_list"); do
                git_status "$repo" > "$status"
            done
            cat "$status"
            echo "========================================================================================="
            else
            echo "No repositories found."
            fi
            exit 0
        ;;
        -h|--help)
        echo "                                   gitIt CLI Tool"
        echo "============================================================================================="
        echo "This tool provides a quick report of all local repositories found on your system,"
        echo "as well as the ability to quickly navigate to them."
        echo "============================================================================================="
        echo "                               Usage: gitit [flags]"
        echo
        echo "Without flags, gitit will display the statuses of all local repositories."
        echo "You can navigate to a repository by selecting it with the arrow keys and pressing Enter."
        echo "You can also use the following flags:"
        echo
        echo "Flags:"
        echo "  -h, --help       Show this help message"
        echo "  --ignore-repo <REGEX pattern>  Ignore repositories matching the provided pattern"
        echo "                                 This will add the pattern to the ignore.conf file" 
        echo "                                 in $HOME/.config/gitit"
        exit 0
        ;;
        -s) __init__
            if [ -f "$repo_list" ]; then
            echo "             Generating git status for all repositories..."
            echo "========================================================================================="
            for repo in $(cat "$repo_list"); do
                git_status "$repo" > "$status"
            done
            cat "$status"
            echo "========================================================================================="
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
        __init__
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
        -l|--list) __init__
            if [ -f "$repo_list" ]; then
                echo "                  Generating a list of all local repositories..."
                echo "========================================================================================="
                echo
                echo "Found $(wc -l "$repo_list" | awk '{print $1}') active repositories"
                echo
                echo "========================================================================================="
                echo
                echo "List of repositories:"
                echo "----------------------------------------------------------------------------------------"
                cat "$report"
                echo "========================================================================================="
            else
                echo "No repositories found."
            fi
            exit 0
        ;;
    esac
}

gitIt "$@"
