#!/bin/bash

myIP=$(bash myIP.bash)


# Todo-1: Create a helpmenu function that prints help for the script
function helpMenu() {
    echo "   HELP MENU"
    echo "---------------"
    echo "-n: Add -n as an argument for this script to use nmap"
    echo " -n external: External NMAP scan"
    echo " -n internal: Internal NMAP scan"
    echo "-s: Add -s as an argument for this script to use ss"
    echo " -s external: External ss(Netstat) scan"
    echo " -s internal: Internal ss(Netstat) scan"
    echo ""
    echo "Usage: bash networkchecker.bash -n/-s external/internal"
    echo "---------------"
}

# Return ports that are serving to the network
function ExternalNmap(){
  rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}

# Return ports that are serving to localhost
function InternalNmap(){
  rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}


# Only IPv4 ports listening from network
function ExternalListeningPorts(){
  ss -ltpn | awk -F'[[[:space:]:(),]+' '!/127.0.0.1/ && /LISTEN/ && $5 ~ /^[0-9]+$/ && $9 != "" {print $5, $9}' | tr -d "\""
}

# Todo-2: Complete the ExternalListeningPorts that will print the port and application
# that is listening on that port from network (using ss utility)


# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
  ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\""
}

if [ "$#" -ne 2 ]; then
    helpMenu
fi

while getopts "n:s:" opt; do
    case $opt in
        n)
            if [ "$OPTARG" == "internal" ]; then
                InternalNmap
                echo "$rin"
            elif [ "$OPTARG" == "external" ]; then
                ExternalNmap
                echo "$rex"
            else
                helpMenu
            fi
            ;;
        s)
            if [ "$OPTARG" == "internal" ]; then
                InternalListeningPorts
                echo "$ilop"
            elif [ "$OPTARG" == "external" ]; then
                ExternalListeningPorts
		
            else
                helpMenu
            fi
            ;;
        *)
            helpMenu
            ;;
    esac
done

# Todo-3: If the program is not taking exactly 2 arguments, print helpmenu

# Todo-4: Use getopts to accept options -n and -s (both will have an argument)
# If the argument is not internal or external, call helpmenu
# If an option other then -n or -s is given, call helpmenu
# If the options and arguments are given correctly, call corresponding functions
# For instance: -n internal => will call NMAP on localhost
#               -s external => will call ss on network (non-localhost)
