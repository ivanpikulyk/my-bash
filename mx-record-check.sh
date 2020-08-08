#!/bin/bash

# This function will check MX records of domain name, IP address of each MX record and PTR of those IP`s.    

mx() {

        domainName=$(echo "$1" | cut -d'@' -f2)
        echo -e "\n\n$domainName | cut -d'@' -f2"
        echo "host -t MX $domainName | awk '{print \$7}'"
        for MX in $(host -t MX "$domainName" | awk '{print $7}') 
        do  
           echo -e "\n\n$MX"
           host "$MX"
           for ip in $(host -t A "$MX" | awk '{print $4}')
           do  
              host "$ip"
           done  
        done
            
        echo -e "Do you want to sent ICMP request with command: "ping -c 3 "$MX"" [y/n]: "
        
        read input

        if [[ "$input" == "y" ]]; then
           for MX in $(host -t MX "$domainName" | awk '{print $7}') 
           do  
              ping -c 3 "$MX"
           done
        else
            echo -e "Your answer is "$input", so this is the end of script work!"
        fi  
         
}
