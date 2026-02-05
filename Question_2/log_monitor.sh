#!/bin/bash

# 1. Check if a log file argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

logfile="$1"

# 2. Validate that the file exists and is readable
if [ ! -f "$logfile" ] || [ ! -r "$logfile" ]; then
    echo "Error: File '$logfile' not found or not readable."
    exit 1
fi

# 3. Process the log file
# Count total lines
total_entries=$(wc -l < "$logfile")

# Count specific keywords
info_count=$(grep -c "INFO" "$logfile")
warn_count=$(grep -c "WARNING" "$logfile")
error_count=$(grep -c "ERROR" "$logfile")

# Find the most recent ERROR message (tail -n 1 gets the last one)
recent_error=$(grep "ERROR" "$logfile" | tail -n 1)

# 4. Display the analysis to the screen
echo "Analysis Report:"
echo "Total Entries: $total_entries"
echo "INFO: $info_count | WARNING: $warn_count | ERROR: $error_count"
echo "Most Recent Error: $recent_error"

# 5. Generate a report file with the current date
current_date=$(date +%F)
report_name="logsummary_${current_date}.txt"

{
    echo "Date: $(date)"
    echo "Log File: $logfile"
    echo "Total Entries: $total_entries"
    echo "Counts - INFO: $info_count, WARNING: $warn_count, ERROR: $error_count"
    echo "Most Recent Error: $recent_error"
} > "$report_name"

echo "Report saved to: $report_name"
