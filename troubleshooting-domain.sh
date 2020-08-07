#!/bin/bash

# Bash function to quickly check NS records, registrar, status by domain name and filter briefly only by needed strings (in my opinion) 
# then will check serial numbers answer from authoritative nameservers, A record and PTR of this IP address,
# sends four ICMP request and in the end look with headers 

#Color_Off='\033[0m'       # Text Reset

# Regular Colors
#Black='\033[0;30m'        # Black
#Red='\033[0;31m'          # Red
#Green='\033[0;32m'        # Green
#Yellow='\033[0;33m'       # Yellow
#Blue='\033[0;34m'         # Blue
#Purple='\033[0;35m'       # Purple
#Cyan='\033[0;36m'         # Cyan
#White='\033[0;37m'        # White

ws() {
echo -e "
echo -e "\e[91m------------------------------------------------------------------------------------------------------------------------------\e[0m"
echo -e "\e[91mwhois $1 | grep "status\|registrar\|nserver\|Domain Status\|Registrar\|Name Server\|Status\|Created\|Last Updated\|Expiration"\e[0m"
whois $1 | grep "status\|registrar\|nserver\|Domain Status\|Registrar\|Name Server\|Status\|Created\|Last Updated\|Expiration"

echo -e "\n"
echo -e "\e[97m----------------------------------------------------\e[0m"
echo -e "\e[97mhost -C $1\e[0m"
echo -e "\e[37m-C compares SOA records on authoritative nameservers\e[0m"
echo -e "\n"
host -C $1

output=( $(host -C $1 | awk '{ print $7}') )
a=${output[0]}
b=${output[1]}
c=${output[2]}
d=${output[3]}
e=${output[4]}

echo -e "\n\n"

  echo "First authoritative nameservers answers by output of command 'host -C $1 | awk '{ print \$7}'': '$a'"

 if [[ -n "$b" ]]; then
  echo "Second authoritative nameservers answers by output of command 'host -C $1 | awk '{ print \$7}'': '$b'"
 fi

 if [[ -n "$c" ]]; then
  echo "Third authoritative nameservers answers by output of command 'host -C $1 | awk '{ print \$7}'': '$c'"
 fi

 if [[ -n "$d" ]]; then
  echo "Fourth authoritative nameservers answers by output of command 'host -C $1 | awk '{ print \$7}'': '$d'"
 fi

#echo "Fifth output from 'host -C $1 | awk '{ print \$7}'': '$e'"

echo -e "\n\n"

if [[ -n "$b" ]]; then
 echo -e "\e[97mAnswer from second authoritative nameservers by output of the command:'host -C $1 | awk '{ print \$7}'' is not empty, and serial number is $b, so script will compare other values wich are not empty below.\e[0m"

if [ "$a" = "$b" ]; then
    echo -e "\e[32mStrings are equal:\e[0m"
    echo -e "\e[32mserial numbers from first and second authoritative nameservers by output of command:'host -C $1 | awk '{ print \$7}'' are equal: $a = $b\e[0m"
 else
    echo -e "\e[91mStrings are not equal:\e[0m"
    echo -e "\e[91mATENSION! Serial numbers from first and second authoritative nameservers by output of the command:'host -C $1 | awk '{ print \$7}'' are NOT equal: $a!= $b\e[0m"
 fi

 if [[ -n "$c" ]]; then

  if [ "$a" = "$c" ]; then
    echo -e "\e[32mStrings are equal:\e[0m"
    echo -e "\e[32mserial numbers from first and third authoritative nameservers by output of command:'host -C $1| awk '{ print \$7}'' are equal: $a = $c\e[0m"
 else
    echo -e "\e[91mStrings are not equal.\e[0m"
    echo -e "\e[91mATENSION! Serial numbers from first and third authoritative nameservers by output of command:'host -C $1 | awk '{ print \$7}'' are NOT equal: $a!= $c\e[0m"
 fi

 else
  echo -e "\e[33m\e[2mThere is no answer from third authoritative nameserver by output of command:'host -C $1' and string is empty: $c\e[0m"
 fi

 if [[ -n "$d" ]]; then

  if [ "$a" = "$d" ]; then
     echo -e "\e[32mStrings are equal:\e[0m"
     echo -e "\e[32mserial numbers from first and fourth authoritative nameservers by output of the command:'host -C $1 | awk '{ print \$7}'' are equal: $a = $d\e[0m"
  else
     echo -e "\e[91mStrings are not equal.\e[0m"
     echo -e "\e[91mATENSION! Serial numbers from first and fourth authoritative nameservers by output of the command:'host -C $1 | awk '{ print \$7}'' are NOT equal: $a!= $d\e[0m"
  fi

 else
  echo -e "\e[33m\e[2mThere is no answer from fourth authoritative nameserver by output of the command:'host -C $1' and string is empty: $d\e[0m"
 fi
 if [[ -n "$b" && -n "$d" ]]; then
  if [ "$b" = "$d" ]; then
      echo -e "\e[32mStrings are equal:\e[0m"
      echo -e "\e[32mserial numbers from second and fourth authoritative nameservers by output of the command:'host -C $1 | awk '{ print \$7}'' are equal: $b = $d\e[0m"
  else
      echo -e "\e[91mStrings are not equal.\e[0m"
      echo -e "\e[91mATENSION! Serial numbers from second and fourth authoritative nameservers by output of the command:'host -C $1 | awk '{ print \$7}'' are NOT equal: $b!= $d\e[0m"
  fi
 else
  echo -e "\e[33m\e[2mThere is no answer from fourth authoritative nameserver for double check with second authoritative nameserver by output of the command:'host -C $1' and string is empty: $d\e[0m"
 fi

else
 echo -e "\e[33m\e[2mThere is no answer from second authoritative nameserver by output of the command:'host -C $1' and string is empty: $d\e[0m"
fi


echo -e "\n"
echo -e "\e[36m------------------------------\e[0m"
echo -e "\e[36mhost -t a $1 | awk '{print \$4}\e[0m"
host -t a $1 | awk '{print $4}'
NS=`host -t a $1 | awk '{print $4}'`
echo -e "\n"
echo -e "\e[34m------------\e[0m"
echo -e "\e[34mnslookup $NS\e[0m"
nslookup $NS
echo -e "\n"
echo -e "\e[32m\e[2m------------\e[0m"
echo -e "\e[32m\e[2mping -c 4 $1\e[0m"
ping -c 4 $1
echo -e "\n"
echo -e "\e[33m--------------------------------------------------------------------------------------------------\e[0m"
echo -e "\e[33mcurl -v --user-agent 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322)' -I $1\e[0m"
curl -v --user-agent "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322)" -I $1
echo -e "\n\n"
}
