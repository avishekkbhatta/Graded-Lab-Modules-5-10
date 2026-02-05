#!/bin/bash

# 1. Check argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

dir="$1"

# 2. Validate directory
if [ ! -d "$dir" ]; then
    echo "Error: Directory '$dir' not found."
    exit 1
fi

# Print the current script PID (Requirement to use $$)
echo "Script (PID: $$) is starting file moves..."

# 3. Create the backup folder inside the target directory
mkdir -p "$dir/backup"

# 4. Loop through files and move them in the background
for file in "$dir"/*; do
    # Skip the backup folder itself
    if [ "$(basename "$file")" == "backup" ]; then
        continue
    fi

    # Only move regular files
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        
        # Move command with '&' puts it in background
        mv "$file" "$dir/backup/" &
        
        # $! holds the PID of the most recent background process
        echo "Moved '$filename' in background process. PID: $!"
    fi
done

# 5. Wait for all background jobs to finish
wait

echo "All background moves completed."
