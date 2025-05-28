#!/bin/bash
#系统巡检脚本

#1.输出基本信息
hostname=`hostname`

ip=`hostname -I`

echo "主机名:${hostname}  ip:${ip}"
echo " "
echo "------------------------------------------------"
echo " "

#2.负载信息
load1=`uptime | awk -F'[ ,]+' '{print $(NF-2)}'`

load5=`uptime | awk -F'[ ,]+' '{print $(NF-1)}'`

load15=`uptime | awk -F'[ ,]+' '{print $NF}'`



echo "系统负载信息"
echo "最近一分钟负载：${load1}"
echo "最近五分钟负载： ${load5}"
echo "最近十五分钟负载: ${load15}"

echo " "
echo "------------------------------------------------"
echo " "
#3.内存和swap
mem_total=`free -m |awk 'NR==2{print $2}'`
mem_used=`free -m |awk 'NR==2{print $3}'`
memused_percent=`free -m |awk 'NR==2{print $3/$2*100"%"}'`

swap_total=`free -m |awk 'NR==3{print $2}'`
swap_used=`free -m |awk 'NR==3{print $3}'`
swap_used_percent=`free -m |awk 'NR==3{print $3/$2*100"%"}'`

echo "内存和swap信息"
echo "总计内存大小:${mem_total}MB"
echo "使用的内存:${mem_used}"
echo "内存使用率:${mem_used_percent}"

echo "总计swap大小:${swap_total}MB"
echo "使用的swap:${swap_used}"
echo "swap使用率:${swap_used_percent}"
echo " "
echo "------------------------------------------------"
echo " "
#4.磁盘
disk_count=`fdisk -l 2>/dev/null |grep '/dev/sd[a-z]:'|wc -l`
root_total_size=`df -h|awk '$NF=="/"{print $2}'`
root_used_percent=`df -h|awk '$NF=="/"{print $5}'`


echo "硬盘信息"
echo "硬盘数量:${disk_count}"
echo "根分区大小:${root_total_size}"
echo "根分区使用率:${root_used_percent}"
echo " "
echo "------------------------------------------------"
echo " "
#5.进程信息


proc_total=`top -bn1|awk 'NR==2{print $2}'`
proc_running=`top -bn1 |awk 'NR==2{print $4}'`
proc_stopped=`top -bn1 |awk 'NR==2{print $(NF-3)}'`
proc_zombine=`top -bn1 |awk 'NR==2{print $(NF-1)}'`


echo "进程信息"
echo "进程总数:${proc_total}"
echo "运行中的进程数:${proc_running}"
echo "挂起的进程数:${proc_stopped}"
echo "僵尸进程数:${proc_zombine}"

