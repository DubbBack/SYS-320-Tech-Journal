#!/bin/bash

iocUrl=$"http://10.0.17.6/IOC.html"

outputFile=$"IOC.txt"

curl -s "$iocUrl" | \
grep -oP '(?<=<td>).*?(?=</td>)' | \
awk 'NR % 2 == 1' > "$outputFile"
