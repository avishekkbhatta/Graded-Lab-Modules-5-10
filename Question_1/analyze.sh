#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: You must provide exactly one argument (file or directory)."
    exit 1
fi

path="$1"

# Check if the path exists
if [ ! -e "$path" ]; then
    echo "Error: The path '$path' does not exist."
    exit 1
fi

# CASE 1: The argument is a File
if [ -f "$path" ]; then
    echo "Analyzing File: $path"
    lines=$(wc -l < "$path")
    words=$(wc -w < "$path")
    chars=$(wc -m < "$path")
    
    echo "Lines: $lines"
    echo "Words: $words"
    echo "Characters: $chars"

# CASE 2: The argument is a Directory
elif [ -d "$path" ]; then
    echo "Analyzing Directory: $path"
    total_files=$(find "$path" -maxdepth 1 -type f | wc -l)
    txt_files=$(find "$path" -maxdepth 1 -type f -name "*.txt" | wc -l)
    
    echo "Total files present: $total_files"
    echo "Text (.txt) files: $txt_files"
fi
