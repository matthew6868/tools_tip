# 网络工具和命令

## netstat
```shell
#:netstat -ntpl # TCP
#:netstat -nupl # UDP
#:netstat -a # 所有连接
#:netstat -i # 静态观察统计值
#:netstat -s # 提供了各个协议下的统计信息
```

## ss
>another utility to investigate sockets, 海量连接时建议用改命令
```shell
#: ss -a # 所有连接
```

## tcpdump工具
抓取eth0接口上的信息
```shell
$:tcpdump -i eth0 host 172.23.195.51 and tcp port 5044 -vvv -A ##-A:以ASCII格式打印出所有分组，并将链路层的头最小化, -vv:输出详细的报文信息
$:tcpdump -i eth0 host 172.23.195.51 and tcp port 5044 -XX ##-XX:以16进制和ASCII吗形式显示每个报文（包含链路层报头）
$:sudo tcpdump src port 5044 and greater 65 -Xxxx -nnnn -A ## 抓取源端口是5044并且长度大于65个字节的TCP包， less小于
```

## sar 工具
Collect, report, or save system activity information
```shell
%:sar -A
%:sar -n DEV 2 10 #DEV显示网络接口信息 
```

## iptraf 工具

```shell
%:yum install -y iptraf 
%:iftraf-ng 

```

## iftop 查看网络流量工具

### 安装
以CentOS 7 为例子

```shell 
%:yum install gcc flex byacc libpcap ncurses ncurses-devel libpcap-devel tcpdump // 安装依赖包
%:wget http://www.ex-parrot.com/pdw/iftop/download/iftop-1.0pre4.tar.gz
%:tar xvf iftop-1.0pre4.tar.gz
%:cd iftop-1.0pre4
%:./configure --prefix=/usr/local/iftop
%:./configure --prefix=/usr/local/iftop
%:make
%:make install
%:sudo chmod 700 /usr/local/iftop/sbin/iftop
```

### 使用

```shell
sudo ./iftop -i eth0
```

#### iftop界面相关说明
```txt
界面上面显示的是类似刻度尺的刻度范围，为显示流量图形的长条作标尺用的。中间的<= =>这两个左右箭头，表示的是流量的方向。
TX：发送流量
RX：接收流量
TOTAL：总流量
Cumm：运行iftop到目前时间的总流量
peak：流量峰值
rates：分别表示过去 2s 10s 40s 的平均流量
```

#### iftop相关参数
```txt
　　常用的参数
-i设定监测的网卡，如：# iftop -i eth1
-B 以bytes为单位显示流量(默认是bits)，如：# iftop -B
-n使host信息默认直接都显示IP，如：# iftop -n
-N使端口信息默认直接都显示端口号，如: # iftop -N
-F显示特定网段的进出流量，如# iftop -F 10.10.1.0/24或# iftop -F 10.10.1.0/255.255.255.0
-h（display this message），帮助，显示参数信息
-p使用这个参数后，中间的列表显示的本地主机信息，出现了本机以外的IP信息;
-b使流量图形条默认就显示;
-f这个暂时还不太会用，过滤计算包用的;
-P使host信息及端口信息默认就都显示;
-m设置界面最上边的刻度的最大值，刻度分五个大段显示，例：# iftop -m 100M
　　进入iftop画面后的一些操作命令(注意大小写)
按h切换是否显示帮助;
按n切换显示本机的IP或主机名;
按s切换是否显示本机的host信息;
按d切换是否显示远端目标主机的host信息;
按t切换显示格式为2行/1行/只显示发送流量/只显示接收流量;
按N切换显示端口号或端口服务名称;
按S切换是否显示本机的端口信息;
按D切换是否显示远端目标主机的端口信息;
按p切换是否显示端口信息;
按P切换暂停/继续显示;
按b切换是否显示平均流量图形条;
按B切换计算2秒或10秒或40秒内的平均流量;
按T切换是否显示每个连接的总流量;
按l打开屏幕过滤功能，输入要过滤的字符，比如ip,按回车后，屏幕就只显示这个IP相关的流量信息;
按L切换显示画面上边的刻度;刻度不同，流量图形条会有变化;
按j或按k可以向上或向下滚动屏幕显示的连接记录;
按1或2或3可以根据右侧显示的三列流量数据进行排序;
按<根据左边的本机名或IP排序;
按>根据远端目标主机的主机名或IP排序;
按o切换是否固定只显示当前的连接;
按f可以编辑过滤代码，这是翻译过来的说法，我还没用过这个！
按!可以使用Shell命令，这个没用过！没搞明白啥命令在这好用呢！
按q退出监控。
```

## mtr
> a network diagnostic tool. mtr combines the functionality of the traceroute and ping programs in a single network diagnostic tool.
> 追踪路由信息

```shell
%: mtr -r www.baidu.com
```

## tracepath
> traces path to a network host discovering MTU along this path