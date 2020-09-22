# linux tips

1, copy files/folders
cp file1.txt file2.txt /home/mxu
cp -r -v folder /home/mxu #-v:verbose

2, change folder permission for apache
sudo chown -R www-data:www-data <folder>

3, Get the List of Subdirectories With Their Owner & Permissions and Full Paths
ls -dl `find ./ -type d` | grep -v root

4,How to specify in crontab by what user to run script?
crontab -u www-data -e / run as specical user and do crontab -e

5, 统计代码行数
find ./ -name "*.h" |xargs cat|grep -v ^$|wc -l #去掉空格
find demo/ -name "*.js" |wc -l #统计文件数量
wc -l `find ./ -name "*.js"`|tail -n1 #统计行数，包含空格

6, sudo 免密码输入
#sudo visudo
添加NOPASSWD:到指定的组，比如Ubuntu下面：
%sudo ALL=(ALL:ALL) NOPASSWD: ALL
CentOS下面：
%wheel  ALL=(ALL) NOPASSWD: ALL

7，统计文件夹大小并排序
%:sudo du -lh --max-depth=1|grep '[GM]'|sort -rn

8，CentOS 7关闭防火墙
%:sudo systemctl stop firewalld
%:sudo ps auxf|grep firewalld #查看

9, 查看进程的所有线程信息
%: ps -Lf [PID]
%: pstree -af [PID]

10，查看当前目录下的文件夹大小
%: du -sh ./*

11, 通过ps删除指定进程
%: ps -ef |grep top |awk '{print $2}'|sudo xargs kill -9

12, 设置时间和时区(CentOS 7)
%: sudo yum install ntp ntpdate
%: sudo systemctl enable ntpd
%: sudo systemctl start ntpd
%: sudo timedatectl list-timezones # 列出所有时区 Asia/Shanghai
%: sudo timedatectl set-local-rtc 1 # 将硬件时钟调整为与本地时钟一致, 0 为设置为 UTC 时间
%: sudo timedatectl set-timezone Asia/Shanghai # 设置系统时区为上海

13. TIME_WAIT过高
```shell
vi /etc/sysctl.conf
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
/sbin/sysctl -p //使之生效
```

14. 查看so文件符号表
```shell
$: nm xxx.so
$: nm -Do xxx.so //if no symbols tips, use -Do args
$: objdump -tT xxx.so //列出 xxx.so 的函数 
```
