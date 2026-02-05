#!/bin/bash

file="input.txt"

# 1. Check if input file exists
if [ ! -f "$file" ]; then
    echo "Error: $file not found."
    exit 1
fi

# 2. Pre-process the file
# tr -c '[:alnum:]' '[\n*]' replaces anything that isn't a letter/number with a newline
# sed '/^$/d' removes empty lines
# We save this list of words to a temporary file
tr -c '[:alnum:]' '[\n*]' < "$file" | sed '/^$/d' > words.tmp

# 3. Calculate Metrics

# Longest Word (Sort by length descending)
longest=$(awk '{ print length, $0 }' words.tmp | sort -nr | head -n 1 | cut -d " " -f2-)

# Shortest Word (Sort by length ascending)
shortest=$(awk '{ print length, $0 }' words.tmp | sort -n | head -n 1 | cut -d " " -f2-)

# Total Unique Words
unique_count=$(sort words.tmp | uniq | wc -l)

# Average Word Length (Total characters / Total words)
average=$(awk '{ sum += length } END { if (NR > 0) print sum / NR }' words.tmp)

# 4. Display Results
echo "Analysis of $file:"
echo "-----------------------------"
echo "Longest word: $longest"
echo "Shortest word: $shortest"
echo "Average word length: $average"
echo "Total unique words: $unique_count"

# Cleanup temp file
rm words.tmp
