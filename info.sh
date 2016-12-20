#!/bin/bash
# Simple little bash script to show OS, uptime, proc stuff, ram 
# Tested on CentOS 7, Mint 18, Debian
var1=$(uptime -p)
var2=$(arch)
var3=$(hostname)
var4=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
var5=$(free -m | awk '/^Mem:/{print $2}')
var6=$(grep "model name" /proc/cpuinfo | uniq | awk -F ': ' '{$1=$2""; print $1}')
var7=$(grep -P '^core id\t' /proc/cpuinfo | uniq | wc -l)
var8=$(getconf _NPROCESSORS_ONLN)
var9=$(dmidecode -t system | grep "Manufacturer" | awk '{print $2}')
check_distro(){
    if [[ -e /etc/redhat-release ]]
    then
      var10=$(cat /etc/redhat-release)
    elif [[ -e /usr/bin/lsb_release ]]
    then
      var10=$(lsb_release -d | awk -F ':' '{print $2}'| awk '{print $1" " $2" " $3" " $4}')
    elif [[ -e /etc/issue ]]
    then
      var10=$(cat /etc/issue)
    else
      var10=$(cat /proc/version)
    fi
    }
check_distro
printf "%-0s\n" " +———————————————————————————————————————————————————————————————————————————————————+"
printf "| %-30s | %-50s |%-30s\n" "Os type" "$var10" 
printf "| %-30s | %-50s | %-30s\n" "Uptime:" "$var1"
printf "| %-30s | %-50s | %-30s\n" "System arch:" "$var2"
printf "| %-30s | %-50s | %-30s\n" "Hostname:" "$var3"
printf "| %-30s | %-50s | %-30s\n" "Ip address:" "$var4"
printf "| %-30s | %-50s | %-30s\n" "RAM:" "$var5 MB"
printf "| %-30s | %-50s | %-30s\n" "Proc:" "$var6"
printf "| %-30s | %-50s | %-30s\n" "Cores:" "$var7"
printf "| %-30s | %-50s | %-30s\n" "Threads:" "$var8"
printf "| %-30s | %-50s | %-30s\n" "Manufacturer:" "$var9"
printf "%-0s\n" " +———————————————————————————————————————————————————————————————————————————————————+"

