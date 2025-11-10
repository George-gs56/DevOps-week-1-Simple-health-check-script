# DevOps-week-1-Simple-health-check-script
🧩 1. Overview

Area            	    Skills & Tools
______________________________________________________________
Git Basics      	    Version control & GitHub

Linux Commands	        File operations, permissions, system info

Bash Scripting	        Automation using shell scripts

Post-Deployment         Check	System resource verification

CI/CD Concept	        Integration with Azure DevOps pipeline


🧩 2. Git & Linux Command Summary

🔹 Git Essentials

git init                     # Initialize repo
git add .                    # Stage files
git commit -m "message"      # Commit changes
git remote add origin <URL>  # Using HTTPS|SSH for Connecting remote repo
git push origin master       # Push to GitHub/Azure Repos
git pull origin master       # Pull the current files from global repo
git branch branch-name       # Create new branch
git merge branch-name        # mergeing two branches
git log                      # To see the commit logs/history


🔹 Common Linux Commands

ls -l               # List files with permission type
mkdir / rmdir       #Create / delete directories
cd /path            # Change directory
pwd                 # Show current path (present working directory)
cat,touch,cp,mv,rm  # File handling
vi, nano            # file editors
df -h               # Disk usage (disk free)
free -m             # Memory usage
uptime              # System load
chmod +x file.sh    # Make script executable/giving permmisions
whoami              # Show current user

🧩 3. System Health Check Script 🩺

* The script automatically checks Disk, Memory, CPU, and Active User information — similar to a post-deployment health validation step in CI/CD.
* The Information will shown with color to highlight and ensure the state of system.

📜 Script File — system_health_check.sh
___________________________________________________
#!/bin/bash

# Define color codes
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
CYAN="\033[36m"
RESET="\033[0m"

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


🧪 4. Example Output
________________________________________________________

$ ./system_health_check.sh
 ---System Health Check Report---
_______________________________________________
Date & Time: Mon Nov 10 20:25:41 IST 2025
-----------------------------------
Disk Usage:
Filesystem            Size  Used Avail Use% Mounted on
C:/Program Files/Git  100G   97G  2.5G  98% /
D:                    316G   34G  283G  11% /d
-----------------------------------
Memory Usage:
Used: 2912.68 MB / 3935 MB (74.0%)
-----------------------------------
CPU Load(Windows):
 ✅Low CPU Load: 9               %
-----------------------------------
Active User: ELCOT
-----------------------------------

SYSTEM HEALTH CHECK IS COMPLETED.
_____________________________________________________________

🧭 6. Learning Summary

✔ Learned Git version control
✔ Practiced Linux commands and permissions
✔ Built a Bash automation script
✔ Performed post-deployment health validation
✔ Monitoring: System resource usage (CPU, Memory, Disk, User)

👨Author
George
🎯 Aspiring DevOps Engineer
💼 Focused on Cloud, CI/CD, and Automation
[![LinkedIn](https://img.shields.io/badge/LinkedIn-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/george-r-87104a282/)
[![GitHub](https://img.shields.io/badge/GitHub-black?style=flat&logo=github)](https://github.com/George-gs56)]








