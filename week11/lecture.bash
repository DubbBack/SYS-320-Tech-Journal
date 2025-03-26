#!/bin/bash

pageCounts(){
  awk '{print $7}' /var/log/apache2/access.log | sort | uniq -c
}

countingCurlAccess() {
  awk '/curl/ {print $1, $12}' /var/log/apache2/access.log | sort | uniq -c
}

pageCounts
countingCurlAccess

