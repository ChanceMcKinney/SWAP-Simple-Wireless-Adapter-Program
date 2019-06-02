#!/bin/bash

if [ $EUID -ne 0 ]
then
    echo "Sorry, must run as root!"
    exit 1
fi

monitor_mode () {
    ifconfig $iface down
    airmon-ng check kill
    iwconfig $iface mode monitor
    ifconfig $iface up
}

managed_mode () {
    ifconfig $iface down        
    airmon-ng check kill
    iwconfig $iface mode managed
    service network-manager start
    ifconfig $iface up
}

while true;
do
    printf "\n"

    /sbin/iwconfig

    printf "\nWhich interface would you like to change?\n\n> "
    
    read iface
    
    while true;
    do
        printf "\n0. Monitor\n1. Managed\n\n> "
        read mode
       
        if [ $mode = 0 ] 
        then    
            monitor_mode

            if [ $? -eq 0 ]
            then
                notify-send "Monitor Mode enabled" "$iface" -t 4000
                exit
            fi
            break
           
        elif [ $mode = 1 ]
        then    
           managed_mode
           
            if [ $? -eq 0 ]
            then
                 notify-send "Managed Mode enabled" "$iface" -t 4000
                exit
            fi
            break
        
        else
            printf "\nPlease choose a valid option.\n\n"    
        fi
    done	
done
        
