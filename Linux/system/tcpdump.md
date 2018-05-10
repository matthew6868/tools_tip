# tcpdump User Guide

## 抓取指定网卡接口数据

```shell
$:sudo tcpdump -i eth0 host 172.23.195.51 and tcp port 5044 -vvv -A ##-A:以ASCII格式打印出所有分组，并将链路层的头最小化, -vv:输出详细的报文信息
$:sudo tcpdump -i eth0 host 172.23.195.51 and tcp port 5044 -XX ##-XX:以16进制和ASCII吗形式显示每个报文（包含链路层报头）
$:sudo tcpdump src port 5044 and greater 65 -Xxxx -nnnn -A ## 抓取源端口是5044并且长度大于65个字节的TCP包， less小于
```
