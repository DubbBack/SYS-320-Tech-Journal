#!/bin/bash

# run ipp addr so it only returns my ip address

ipAddr= ip addr | grep "global dynamic" | cut -c 10-19
