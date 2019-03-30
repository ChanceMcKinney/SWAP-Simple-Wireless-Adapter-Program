#run as root
#!/bin/bash

clear

iwconfig 

printf "Which interface would you like to change?\n> "
read iface
while true;
do
    printf "0. Monitor\n1. Managed\n> "
    read mode
    if [ $mode = 0 ] 
    then    
        ifconfig $iface down
        airmon-ng check kill
        iwconfig $iface mode monitor
        ifconfig $iface up
        break

    elif [ $mode = 1 ]
    then    
        ifconfig $iface down		
        airmon-ng check kill
        iwconfig $iface mode managed
        ifconfig $iface up
        service network-manager start
        break
    else
        printf "Please choose a valid operator.\n"    
    fi
done	
