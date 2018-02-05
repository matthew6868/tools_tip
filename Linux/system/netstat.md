# netstat tips

## 服务器上的一些统计数据
1. 统计80端口连接数
```shell
$: netstat -nat|grep -i "80"|wc -l
```

2. 统计httpd协议连接数
```shell
$: ps -ef|grep httpd|wc -l
```

3. 统计已连接上的，状态为“established
```shell
$: netstat -na|grep ESTABLISHED|wc -l
```

4. 查出哪个IP地址连接最多,将其封了.
```shell
$: netstat -na|grep ESTABLISHED|awk {print $5}|awk -F: {print $1}|sort|uniq -c|sort -r +0n
$: netstat -na|grep SYN|awk {print $5}|awk -F: {print $1}|sort|uniq -c|sort -r +0n
```

5. 
```shell
$: netstat -an | grep ESTABLISHED | wc -l
```
> 对比httpd.conf中MaxClients的数字差距多少。

6. 获取当前所有80端口的请求总数
```shell
$: netstat -nat|grep -iw "80"|wc -l
4341
```
> netstat -an会打印系统当前网络链接状态，而grep -i "80"是用来提取与80端口有关的连接的，wc -l进行连接数统计。
最终返回的数字就是当前所有80端口的请求总数。

7. 查看当前并发访问数：
```shell
$: netstat -na|grep ESTABLISHED|wc -l
376
```
> netstat -an会打印系统当前网络链接状态，而grep ESTABLISHED 提取出已建立连接的信息。 然后wc -l统计。
最终返回的数字就是当前所有已建立连接的总数。

8. 可查看所有建立连接的详细记录
```shell
$: netstat -nat||grep ESTABLISHED|wc - 
```

9. 查看Apache的并发请求数及其TCP连接状态：
 ```shell
$: netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
```
>（这条语句是从 新浪互动社区事业部 新浪互动社区事业部技术总监王老大那儿获得的，非常不错）返回结果示例：
　　LAST_ACK 5  
　　SYN_RECV 30  
　　ESTABLISHED 1597  
　　FIN_WAIT1 51  
　　FIN_WAIT2 504  
　　TIME_WAIT 1057  
　　其中:  
  SYN_RECV表示正在等待处理的请求数；  
  ESTABLISHED表示正常数据传输状态；  
  TIME_WAIT表示处理完毕，等待超时结束的请求数。  
　　状态：描述  
　　CLOSED：无连接是活动 的或正在进行  
　　LISTEN：服务器在等待进入呼叫  
　　SYN_RECV：一个连接请求已经到达，等待确认  
　　SYN_SENT：应用已经开始，打开一个连接  
　　ESTABLISHED：正常数据传输状态  
　　FIN_WAIT1：应用说它已经完成  
　　FIN_WAIT2：另一边已同意释放  
　　ITMED_WAIT：等待所有分组死掉  
　　CLOSING：两边同时尝试关闭  
　　TIME_WAIT：另一边已初始化一个释放  
　　LAST_ACK：等待所有分组死  

　　
