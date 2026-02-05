#!/bin/bash

# 1. Check if the input file argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <marks_file>"
    exit 1
fi

file="$1"

# 2. Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' not found."
    exit 1
fi

# Initialize counters
count_passed_all=0
count_failed_one=0

# Variables to hold the list of names (we will append names to these)
passed_list=""
failed_one_list=""

# 3. Process the file line by line
# IFS=, sets the comma as the separator for reading CSV data
while IFS=, read -r roll name m1 m2 m3; do
    
    # Skip empty lines if any
    if [ -z "$roll" ]; then continue; fi

    # Count how many subjects the student failed (Marks < 33)
    fails=0
    if [ "$m1" -lt 33 ]; then ((fails++)); fi
    if [ "$m2" -lt 33 ]; then ((fails++)); fi
    if [ "$m3" -lt 33 ]; then ((fails++)); fi

    # Categorize the student based on failure count
    if [ "$fails" -eq 0 ]; then
        # Passed ALL subjects
        ((count_passed_all++))
        passed_list+="$roll $name"$'\n'
    elif [ "$fails" -eq 1 ]; then
        # Failed exactly ONE subject
        ((count_failed_one++))
        failed_one_list+="$roll $name"$'\n'
    fi

done < "$file"

# 4. Display the Results
echo "Students who failed in exactly ONE subject:"
echo -e "$failed_one_list"

echo "Students who passed in ALL subjects:"
echo -e "$passed_list"

echo "-------------------------------------------"
echo "Count of students who passed in ALL subjects: $count_passed_all"
echo "Count of students who failed in exactly ONE subject: $count_failed_one"
