#!/bin/bash

# Assign arguments
SOURCE="$1"
DEST="$2"
USERID=$(id -u)
DAYS=${3:-14}

# --- 1. Root Check ---
if [ "$USERID" -ne 0 ]; then
    echo "ERROR:: Please run this script with root privilege"
    exit 1
fi

# --- 2. Usage Function ---
USAGE(){
    echo "Usage: sudo backup.sh source_directory destination_directory [days_old]"
}

# --- 3. Argument Check ---
if [ $# -lt 2 ]; then
    USAGE
    exit 1
fi

# --- 4. Directory Existence Checks (and Exit on Failure) ---
if [ ! -d "$SOURCE" ]; then
    echo "ERROR:: Source directory '$SOURCE' does not exist."
    exit 1
fi

if [ ! -d "$DEST" ]; then
    echo "ERROR:: Destination directory '$DEST' does not exist."
    exit 1
fi

# --- 5. Find Files to Archive ---
# Using the -print0 and xargs method for robustness against spaces in file names
# This is a better method for generating a safe list than just standard command substitution
file_list=$(find "$SOURCE" -name "*.log" -type f -mtime +"$DAYS" -print0)

# --- 6. Archival Logic ---
# Check if the list is not empty
if [ ! -z "${file_list}" ]; then
    
    echo "Archival successful. Proceeding with zip creation..."
    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_NAME="$DEST/app_logs-$TIMESTAMP.zip" # Re-added 'app_logs-' for clarity
    
    # Zip the files: read null-terminated list and pipe to zip
    echo "$file_list" | xargs -0 zip -j "$ZIP_NAME"

    # --- 7. Post-Archival Verification and Cleanup ---
    if [ -f "$ZIP_NAME" ]; then
        echo "Zip file created successfully: $ZIP_NAME"
        echo "Starting cleanup (deleting original log files)..."
        
        # Read the null-terminated list and delete files safely
        echo "$file_list" | xargs -0 rm -rf
        
        echo "Cleanup complete."
    else
        echo "ERROR:: Archival failure! Zip file was not created."
        exit 1
    fi

else
    echo "Skipping: No .log files older than $DAYS days found in $SOURCE."
fi