#!/bin/bash

#==================================== Version without monitoring agents ===========================================
#This little script will check status of services in GNU/Linux distributions which are used systemd — systemctl, 
#and if some of them inactive will try to start them.

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

echo -e "\e[97m\nsystemctl status httpd | grep 'Active\|active' | awk ' { print \$2}'\e[0m"

systemctl status httpd | grep "Active\|active" | awk ' { print $2}'

apache=$(systemctl status httpd | grep "Active\|active" | awk ' { print $2}')

if [[ "$apache" == "inactive" ]]; then
  echo -e "\e[31mWARNING! Apache web server (httpd) does NOT work!\e[0m"
  echo -e "\e[33m\e[2mScript trying to start Apache web server (httpd), check output below:\e[0m"
  systemctl start httpd
  echo -e "\e[33msystemctl start httpd\e[0m"
  echo -e "\e[33m\e[2msystemctl status httpd | grep "Active\|active"\e[0m"
  systemctl status httpd | grep "Active\|active"
 
    apache=$(systemctl status httpd | grep "Active\|active" | awk ' { print $2}')
    if [[ "$apache" == "active" ]]; then
     echo -e "\e[32mApache (httpd) successfully started by script and now is active\e[0m"
    else
     echo -e "\e[31mWARNING! Apache web server (httpd) does NOT work!\e[0m"
    fi
else
  echo -e "\e[32mApache (httpd) is active\e[0m"
fi

echo -e "\e[97m\nsystemctl status nginx | grep "Active\|active" | awk ' { print \$2}'\e[0m"

systemctl status nginx | grep "Active\|active" | awk ' { print $2}'


nginx=$(systemctl status nginx | grep "Active\|active" | awk ' { print $2}')

if [[ "$nginx" == "inactive" ]]; then
  echo -e "\e[31mWARNING! Nginx web server does NOT work!\e[0m"
  echo -e "\e[33m\e[2mScript trying to start Nginx web server, check output below:\e[0m"
  echo -e "\e[33msystemctl start nginx\e[0m"
  systemctl start nginx
  echo -e "\e[33m\esystemctl status nginx | grep "Active\|active"\e[0m"
  systemctl status nginx | grep "Active\|active"
else
  echo -e "\e[32mNGINX is active\e[0m"
fi

echo -e "\e[97m\nsystemctl status mariadb | grep "Active\|active" | awk ' { print \$2}'\e[0m"

systemctl status mariadb | grep "Active\|active" | awk ' { print $2}'

mariadb=$(systemctl status mariadb | grep "Active\|active" | awk ' { print $2}')

if [[ "$mariadb" == "inactive" ]]; then
  echo "\e[31mWARNING! mariadb does NOT work!\e[0m"
  echo -e "\e[33m\e[2mScript trying to start mariadb, check output below:\e[0m"
  echo -e "\e[33msystemctl start mariadb\e[0m"
  systemctl start mariadb
  echo -e "\e[33m\e[2msystemctl status mariadb | grep "Active\|active"\e[0m"
  systemctl status mariadb | grep "Active\|active"
else
  echo -e "\e[32mmariadb is active\e[0m"
fi


echo -e "\e[97m\nsystemctl status exim | grep "Active\|active" | awk ' { print \$2}'\e[0m"

systemctl status exim | grep "Active\|active" | awk ' { print $2}'

exim=$(systemctl status exim | grep "Active\|active" | awk ' { print $2}')

if [[ "$exim" == "inactive" ]]; then
  echo -e "\e[31mWARNING! Exim does NOT work!\e[0m"
  echo -e "\e[33m\e[2mScript trying to start exim, check output below:\e[0m"
  echo -e "\e[33msystemctl start exim\e[0m"
  systemctl start exim
  echo -e "\e[33m\e[2msystemctl status exim | grep "Active\|active"\e[0m"
  systemctl status exim | grep "Active\|active"
else
  echo -e "\e[32mExim is active\e[0m"
fi


echo -e "\e[97m\nsystemctl status dovecot | grep "Active\|active" | awk ' { print \$2}'\e[0m"

systemctl status dovecot | grep "Active\|active" | awk ' { print $2}'

dovecot=$(systemctl status dovecot | grep "Active\|active" | awk ' { print $2}')

if [[ "$dovecot" == "inactive" ]]; then
  echo -e "\e[31mWARNING! Dovecot does NOT work!\e[0m"
  echo -e "\e[33m\e[2mScript trying to start Dovecot, check output below:\e[0m"
  echo -e "\e[33msystemctl start dovecot\e[0m"
  systemctl start dovecot
  echo -e "\e[33m\e[2msystemctl status dovecot | grep "Active\|active"\e[0m"
  systemctl status dovecot | grep "Active\|active"
else
  echo -e "\e[32mDovecot is active\e[0m"
fi

echo -e "\e[97m\nsystemctl status iptables | grep "Active\|active" | awk ' { print \$2}'\e[0m"

systemctl status iptables | grep "Active\|active" | awk ' { print $2}'

iptables=$(systemctl status iptables | grep "Active\|active" | awk ' { print $2}')

if [[ "$iptables" == "inactive" ]]; then
  echo -e "\e[31mWARNING! iptables does NOT work!\e[0m"
  echo -e "\e[33m\e[2mScript trying to start iptables, check output below:\e[0m"
  echo -e "\e[33msystemctl start iptables\e[0m"
  systemctl start iptables
  echo -e "\e[33m\e[2msystemctl status iptables | grep "Active\|active"\e[0m"
  systemctl status iptables | grep "Active\|active"
else
  echo -e "\e[32miptables is active\e[0m"
fi
