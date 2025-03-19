#!/bin/bash

# List all the ips inn the given network prefix
# /24 only

#Usage: bash IPList.bash 10.0.17
if [ $# -ne 1 ] ; then
    echo "Usage: $0 <Prefix>"
    exit 1
fi

prefix=$1

if [ ${#prefix} -lt 6 ] ; then
	printf "Prefix length is to short\nPrefix example: 10.0.17\n" ;
	exit 1
fi


for i in {1..254}
do
	ping -c 1 $prefix.$i > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		result=0
	else
		result=1
	fi
	if [ $result -eq 0 ]; then
	   echo "$prefix.$i"
	fi
done
