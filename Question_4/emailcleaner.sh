#!/bin/bash

input_file="emails.txt"

# 1. Check if input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: $input_file not found."
    exit 1
fi

# Define the Regex: <letters_and_digits>@<letters>.com
# ^ = start, $ = end, + = one or more
regex="^[a-zA-Z0-9]+@[a-zA-Z]+\.com$"

# 2. Extract VALID emails (sort and remove duplicates)
grep -E "$regex" "$input_file" | sort | uniq > valid.txt

# 3. Extract INVALID emails (lines that DO NOT match the regex)
grep -v -E "$regex" "$input_file" > invalid.txt

# 4. Display confirmation
echo "Processing complete."
echo "Valid emails saved to: valid.txt"
echo "Invalid emails saved to: invalid.txt"
