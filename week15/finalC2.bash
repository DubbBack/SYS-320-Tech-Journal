#!/bin/bash

logFile=$"$1"
iocFile=$"$2"
output=$"report.txt"

if [[ ! -f "$logFile" || ! -f "$iocFile" ]]; then
  echo "Usage: $0 <access_log_file> <ioc_file>"
  exit 1
fi

> "$output"

while IFS= read -r ioc; do
  grep -- "$ioc" "$logFile" | while read -r line; do
    ip=$(echo "$line" | awk '{print $1}')
    datetime=$(echo "$line" | grep -oP '\[\K[^]]+' | cut -d' ' -f1)
    page=$(echo "$line" | awk -F'"' '{print $2}' | cut -d' ' -f2)
    
    echo "$ip $datetime $page" >> "$output"
  done
done < "$iocFile"
