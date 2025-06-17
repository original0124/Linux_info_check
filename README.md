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

修改定时任务的环境变量  在crontab 里写入 : PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin  
You can redirect the script output to a file and then send it to your email.  
```
crontab -e  
00 07 * * * /servers/sys_info_check.sh &> /var/www/html/upload/sys_info_check  
00 07 * * * bash /servers/attachment_sys_info_check.sh &> /var/www/html/upload/attachment_sys_info_check.csv  
05 07 * * * mail -s 'system status information' "your email" < /var/www/html/upload/sys_info_check  
05 07 * * * echo "System Information Attachment" | mail -s 'Daily Patrol Results Attachment' -a /var/www/html/upload/attachment_sys_info_check.csv  "your email"    
```
备份服务rsync:  
安装  
```
yum install -y rsync  
```
查看软件包内容：    
```
rpm -ql rsync  
```
服务的配置文件:/etc/rsyncd.conf  
/etc/rsyncd.conf内容：  
```
# /etc/rsyncd: configuration file for rsync daemon mode  

# See rsyncd.conf man page for more options.  

# configuration example:  

# uid = nobody  
# gid = nobody  
# use chroot = yes  
# max connections = 4  
# pid file = /var/run/rsyncd.pid  
# exclude = lost+found/  
# transfer logging = yes  
# timeout = 900  
# ignore nonreadable = yes  
# dont compress   = *.gz *.tgz *.zip *.z *.Z *.rpm *.deb *.bz2  

# [ftp]  
#        path = /home/ftp  
#        comment = ftp export area  

#伪装成有root权限  
fake super = yes  
#rsync运行时的用户和组 虚拟用户  
uid = rsync  
gid = rsync  

use chroot=no  

#最大连接数  
max connections=2000  
#超时时间(s)  
timeout=600  
#存放服务的pid号(用于方便写脚本   
pid file = /var/run/rsyncd.pid  
#进程/服务的锁文件 防止重复运行  
lock file = /var/run/rsync.lock  
#rsync服务端日志  
log file = /var/log/rsyncd.log  
#忽略错误  
ignore errors  
#可以进行读写  
read only = false  
#关闭rsync服务端列表功能  
list=false  
#只准许哪些IP或网段访问 白名单  
#hosts allow = 10.0.0.0/24  
#拒绝哪些网段访问  
#hosts deny = 0.0.0.0/32  
#rsync服务端进行验证用户：用户名  
auth users=rsync_backup  
#rsync服务端用于验证：密码文件  
secrets file = /etc/rsync.password  

#模块名  
[data]  
#注释说明  
comment = data  
#模块对应目录 注意权限问题  
path = /data  
```
#-s  这个选项指定了用户登录后使用的shell  /sbin/nologin 是一个特殊的shell，允许用户登录，但不允许交互式登录，通常用于系统服务账号 如rsync这种不需要用户交互的服务  -M不要为用户创建家目录 系统服务用户如rsync通常不需要家目录  
useradd -s /sbin/nologin -M rsync  

chown -R rsync.rsync /data/ 改变目录以及目录下的内容的所有者和所属组都为rsync  
id rsync 查看用户信息  
 chmod 600 /etc/rsync.password  

sersync:内置inotify+rsync命令，一个命令+一个配置文件  
inotify：是个命令监控指定目录是否发生变化  
