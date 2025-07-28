move_to_repo() {
##  Moves to the selected repository directory
## Has it's own script as it must be sourced from gitIt.sh in order to change directories

    if [ ! -f "$report" ]; then
        echo "No repositories found. Please run gitIt to generate a report."
        return 1
    fi

    echo "Available repositories:"
    cat "$report"
    echo "-----------------------------------------------------------------------------------------"

#  Prompts user for input to select a repository
    read -p "Enter the number of the repo to navigate to: " repo_number
    #  Validates input
    if ! [[ "$repo_number" =~ ^[0-9]+$ ]]; then
        echo "Invalid input. Please enter a number."
        return 1
    fi
    #  Converts input to absolute path using report file
    target_repo=$(sed -n "${repo_number}s/^ *[0-9]*[.] //p" "$report")

    if [ -n "$target_repo" ]; then
            echo "Changing directory to: $target_repo"
            eval cd "$target_repo" || echo "Failed to change directory."
        fi

}
#  This function is called in gitIt.sh to allow the user to move to a specific repository