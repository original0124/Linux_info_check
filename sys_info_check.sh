#!/bin/bash
hostname=`hostname`
ip=`hostname -I`
echo "Hostname:${hostname}  IP:${ip}"
echo " "
echo "------------------------------------------------"
echo " "
load1=`uptime | awk -F'[ ,]+' '{print $(NF-2)}'`
load5=`uptime | awk -F'[ ,]+' '{print $(NF-1)}'`
load15=`uptime | awk -F'[ ,]+' '{print $NF}'`
echo "System Load Information"
echo "Load in the last 1 minute：${load1}"
echo "Load in the last 5 minutes: ${load5}"
echo "Load in the last 15 minutes:${load15}"
echo " "
echo "------------------------------------------------"
echo " "
mem_total=`free -m |awk 'NR==2{print $2}'`
mem_used=`free -m |awk 'NR==2{print $3}'`
memused_percent=`free -m |awk 'NR==2{print $3/$2*100"%"}'`
swap_total=`free -m |awk 'NR==3{print $2}'`
swap_used=`free -m |awk 'NR==3{print $3}'`
swap_used_percent=`free -m |awk 'NR==3{print $3/$2*100"%"}'`
echo "Memory and Swap Information"
echo "Total memory size::${mem_total}MB"
echo "Used memory:${mem_used}"
echo "Memory usage rate:${mem_used_percent}"
echo "Total swap size:${swap_total}MB"
echo "Used swap:${swap_used}"
echo "Swap usage rate:${swap_used_percent}"
echo " "
echo "------------------------------------------------"
echo " "
disk_count=`fdisk -l 2>/dev/null |grep '/dev/sd[a-z]:'|wc -l`
root_total_size=`df -h|awk '$NF=="/"{print $2}'`
root_used_percent=`df -h|awk '$NF=="/"{print $5}'`
echo "Disk Information"
echo "Number of disks:${disk_count}"
echo "Root partition size:${root_total_size}"
echo "Root partition usage rate:${root_used_percent}"
echo " "
echo "------------------------------------------------"
echo " "
proc_total=`top -bn1|awk 'NR==2{print $2}'`
proc_running=`top -bn1 |awk 'NR==2{print $4}'`
proc_stopped=`top -bn1 |awk 'NR==2{print $(NF-3)}'`
proc_zombine=`top -bn1 |awk 'NR==2{print $(NF-1)}'`
echo "Process Information"
echo "Total number of processes:${proc_total}"
echo "Number of running processes:${proc_running}"
echo "Number of sleeping processes:${proc_stopped}"
echo "Number of zombie processes:${proc_zombine}"

