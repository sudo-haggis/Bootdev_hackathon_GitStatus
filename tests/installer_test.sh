#!/bin/bash
if [ ! -f "../functions/installer_tools.sh" ]; then
    echo "Error: installer_tools.sh not found in the expected location."
    exit 1
fi
source ../functions/installer_tools.sh

echo "Loaded functions:"
declare -F detect_package_manager fuzzy_install || {
  echo "One or more functions not found!"
  exit 1
}

main() {
    # Test dependency management functions
    echo "Testing dependency management functions..."
    detect_package_manager
    fuzzy_install
}

# Run the main function
main
