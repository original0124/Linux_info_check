# Linux_info_check
This script will collect the following information:  
Hostname  
IP Address  
  
System Load Information  
Load in the last 1 minute  
Load in the last 5 minutes  
Load in the last 15 minutes  
  
Memory and Swap Information  
Total memory size  
Used memory  
Memory usage rate  
Total swap size  
Used swap  
Swap usage rate  
  
Disk Information  
Number of disks  
Root partition size  
Root partition usage rate  
  
Process Information  
Total number of processes  
Number of running processes  
Number of sleeping processes  
Number of zombie processes  
  
You can redirect the script output to a file and then send it to your email.  
```
crontab -e  
00 07 * * * /servers/sys_info_check.sh &> /var/www/html/upload/sys_info_check  
00 07 * * * bash /servers/attachment_sys_info_check.sh &> /var/www/html/upload/attachment_sys_info_check.csv  
05 07 * * * mail -s 'system status information' "your email" < /var/www/html/upload/sys_info_check  
05 07 * * * echo "System Information Attachment" | mail -s 'Daily Patrol Results Attachment' -a /var/www/html/upload/attachment_sys_info_check.csv  "your email"  
```
