#!/bin/bash

# 1. Check if two directory arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <dirA> <dirB>"
    exit 1
fi

dirA="$1"
dirB="$2"

# 2. Check files present ONLY in dirA
echo "Files present ONLY in $dirA:"
# Loop through all files in dirA
for file in "$dirA"/*; do
    # Get just the filename (basename)
    filename=$(basename "$file")
    # Check if this filename does NOT exist in dirB
    if [ ! -e "$dirB/$filename" ]; then
        echo "$filename"
    fi
done
echo "--------------------------------"

# 3. Check files present ONLY in dirB
echo "Files present ONLY in $dirB:"
for file in "$dirB"/*; do
    filename=$(basename "$file")
    if [ ! -e "$dirA/$filename" ]; then
        echo "$filename"
    fi
done
echo "--------------------------------"

# 4. Compare files present in BOTH
echo "Comparison of Common Files:"
for file in "$dirA"/*; do
    filename=$(basename "$file")
    # If the file also exists in dirB
    if [ -e "$dirB/$filename" ]; then
        # 'cmp -s' returns true (0) if identical, false (1) if different
        if cmp -s "$dirA/$filename" "$dirB/$filename"; then
            echo "$filename: Content Matches"
        else
            echo "$filename: Content DIFFERS"
        fi
    fi
done
