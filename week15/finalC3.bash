#!/bin/bash

# Define input/output files
input="report.txt"
output="/var/www/html/report.html"

# Ensure the report.txt exists
if [[ ! -f "$input" ]]; then
  echo "Error: $input not found!"
  exit 1
fi

# Start HTML structure
{
echo "<!DOCTYPE html>"
echo "<html>"
echo "<head><title>IOC Report</title>"
echo "<style>"
echo "table { border-collapse: collapse; width: 100%; }"
echo "th, td { border: 1px solid black; padding: 8px; text-align: left; }"
echo "</style>"
echo "</head>"
echo "<body>"
echo "<h2>Access logs with IOC indicators:</h2>"
echo "<table>"
echo "<tr><th>IP</th><th>Date/Time</th><th>Page Accessed</th></tr>"

while IFS= read -r line; do
  ip=$(echo "$line" | awk '{print $1}')
  datetime=$(echo "$line" | awk '{print $2}')
  page=$(echo "$line" | cut -d ' ' -f3-)
  echo "<tr><td>$ip</td><td>$datetime</td><td>$page</td></tr>"
done < "$input"

echo "</table>"
echo "</body>"
echo "</html>"
} > "$output"

echo "HTML report created at $output"
