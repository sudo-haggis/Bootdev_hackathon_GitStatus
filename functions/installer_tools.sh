##!/bin/bash
#  gitIt CLI Tool installer script

#  detects the package manager and installs any neccessary dependencies
detect_package_manager() {
    if command -v apt-get &> /dev/null; then
        PACKAGE_MANAGER="apt-get"
        UPDATE_COMMAND="sudo apt-get update"
        SEARCH_COMMAND="apt-cache search"
        INSTALL_COMMAND="sudo apt-get install -y"
        ### TODO: Add other common package managers
    fi
}

fuzzy_install() {
    if [ -z "$PACKAGE_MANAGER" ]; then
        echo "No supported package manager found. Please install dependencies manually."
        exit 1
    fi

    echo "Detected package manager: $PACKAGE_MANAGER"
    echo "Updating package list..."
    eval "$UPDATE_COMMAND"

    echo "searching for dependencies..."
    ## Read the dependency list, ignoring empty lines and comments
    while IFS= read -r dependency; do
        [[ -z "$dependency" ]] && continue
        [[ "$dependency" == \#* ]] && continue

    ## Check if the dependency is already installed if not install it
        if ! command -v "$dependency" &> /dev/null; then
            echo "Installing $dependency..."
            match=$($SEARCH_COMMAND "$dependency"\
                | head -n 1 | awk '{print $1}')
            ### If no match is found, prompt the user to install manually
            if [ -z "$match" ]; then
                echo "No match found for $dependency. Please install it manually."
                exit 1
            else
                eval "$INSTALL_COMMAND $match"
                if [ $? -ne 0 ]; then
                    echo "Failed to install $dependency. Please install it manually."
                    exit 1
                fi
            fi
            echo "$dependency installed successfully."

            
        else
            echo "$dependency is already installed."
        fi
    done < cache/dependency_list.txt

    echo "All dependencies installed successfully."
}