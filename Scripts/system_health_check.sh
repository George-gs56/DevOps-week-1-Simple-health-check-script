#!/bin/bash

# Define color codes
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${CYAN} ---System Health Check Report---"
echo -e "_______________________________________________${RESET}"

#Date and Time
echo -e "${YELLOW}Date & Time:${RESET} $(date)"
echo -e "${CYAN}-----------------------------------${RESET}"

#Disk Usages
echo -e "${YELLOW}Disk Usage:${RESET}"
df -h | grep -E '^C|^D|Filesystem'
echo -e "${CYAN}-----------------------------------${RESET}"

#Memory Usage
echo -e "${YELLOW}Memory Usage:${RESET}"
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory | sed 1d |grep -E [0-9] | awk '{
	free=$1/1024;
	total=$2/1024;
	used=total-free;
	if (total>0){
		percent=(used/total)*100;}
	else{
		percent=0;}
	color=(percent>80)?"\033[31m":(percent>60)?"\033[33m":"\033[32m";
		printf"%sUsed: %.2f MB / %2.f MB (%.1f%%)\033[0m\n",color,used,total,percent}'
echo -e "${CYAN}-----------------------------------${RESET}"

#CPU Load Percentage
echo -e "${YELLOW}CPU Load(Windows):${RESET}"
cpu_load=$(wmic cpu get LoadPercentage | grep -E '[0-9]')
if [ "$cpu_load" -gt 80 ]; then
	echo -e "${RED} ⚠️High CPU Load: ${cpu_load}%${RESET}"
elif [ "$cpu_load" -gt 60 ]; then
	echo -e "${YELLOW} ⚠️Moderate CPU Load: ${cpu_load}%${RESET}"
else
	echo -e "${GREEN} ✅Low CPU Load: ${cpu_load}%${RESET}"
fi
echo -e "${CYAN}-----------------------------------${RESET}"

#Active Users
echo -e "${YELLOW}Active User:${RESET} $(whoami)"
echo -e "${CYAN}-----------------------------------${RESET}"
echo
echo -e "${GREEN}SYSTEM HEALTH CHECK IS COMPLETED.${RESET}"
