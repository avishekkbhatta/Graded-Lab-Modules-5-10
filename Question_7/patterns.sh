#!/bin/bash

# 1. Check if input file exists
file="input.txt"
if [ ! -f "$file" ]; then
    echo "Error: $file not found."
    exit 1
fi

# 2. Pre-process: Tokenize to one word per line
# 'tr' replaces punctuation/spaces with newlines so we can grep line-by-line.
# We save to a temporary file 'all_words.tmp'
tr -c '[:alnum:]' '\n' < "$file" | sed '/^$/d' > all_words.tmp

# 3. Extract Patterns (Case insensitive using -i)

# Pattern A: Words containing ONLY vowels (a, e, i, o, u)
# Regex: ^[aeiou]+$ (Start to end is only vowels)
grep -iE '^[aeiou]+$' all_words.tmp > vowels.txt

# Pattern B: Words containing ONLY consonants
# Regex: ^[bcdfghjklmnpqrstvwxyz]+$ (Start to end is only consonants)
grep -iE '^[bcdfghjklmnpqrstvwxyz]+$' all_words.tmp > consonants.txt

# Pattern C: Both vowels and consonants, but starts with a consonant
# Regex: Starts with consonant (^[...]) AND contains a vowel (.*[aeiou])
grep -iE '^[bcdfghjklmnpqrstvwxyz].*[aeiou]' all_words.tmp > mixed.txt

# 4. Display Results
echo "Processing complete."
echo "-------------------"
echo "Vowels only (vowels.txt):"
cat vowels.txt
echo "-------------------"
echo "Consonants only (consonants.txt):"
cat consonants.txt
echo "-------------------"
echo "Mixed (Start with Consonant) (mixed.txt):"
cat mixed.txt

# Cleanup
rm all_words.tmp
