#!/bin/bash
source ./functions/cli_tools.sh
init_colours

echo -e "${BLUE}" 
cat <<'EOF'
        _ __  __________
  ___ _(_) /_/  _/_  __/
 / _ `/ / __// /  / /   
 \_, /_/\__/___/ /_/    
/___/                   
EOF
echo -e "${NC}"

gitIt() {
    case "$1" in
        ""|--default)
            __init__
            quick_report
            generate_status
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
            generate_status
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
                quick_report
            else
                echo "No repositories found."
            fi
            exit 0
        ;;
        -t|--test-dir)
            TEST=true
            SEARCH_DIR="tests/fake_file_system"
            echo "Testing directory set to current directory: $SEARCH_DIR"
            __init__
            quick_report
            generate_status
            exit 0
        ;;
    esac
}

gitIt "$@"
