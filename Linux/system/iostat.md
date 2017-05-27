# iostat

## 安装

## 使用

```shell
#:iostat -d sda -x -m 3
```

>iostat 显示CPU和磁盘IO数据命令 ==> Report  Central Processing Unit (CPU) statistics and input/output statistics for devices and partitions.

```shell
#:iostat -x 2 2 ==> 每隔2秒，总共输出2次
```

## 说明：
```
rrqm/s：每秒这个设备相关的读取请求有多少被Merge了（当系统调用需要读取数据的时候，VFS将请求发到各个FS，如果FS发现不同的读取请求读取的是相同Block的数据，FS会将这个请求合并Merge）；
wrqm/s：每秒这个设备相关的写入请求有多少被Merge了。
rsec/s：每秒读取的扇区数；
wsec/：每秒写入的扇区数。
rKB/s：The number of read requests that were issued to the device per second；
wKB/s：The number of write requests that were issued to the device per second；
avgrq-sz 平均请求扇区的大小
avgqu-sz 是平均请求队列的长度。毫无疑问，队列长度越短越好。    
await：  每一个IO请求的处理的平均时间（单位是微秒毫秒）。这里可以理解为IO的响应时间，一般地系统IO响应时间应该低于5ms，如果大于10ms就比较大了。
         这个时间包括了队列时间和服务时间，也就是说，一般情况下，await大于svctm，它们的差值越小，则说明队列时间越短，反之差值越大，队列时间越长，说明系统出了问题。
svctm    表示平均每次设备I/O操作的服务时间（以毫秒为单位）。如果svctm的值与await很接近，表示几乎没有I/O等待，磁盘性能很好，如果await的值远高于svctm的值，则表示I/O队列等待太长， 系统上运行的应用程序将变慢。
%util： 在统计时间内所有处理IO时间，除以总共统计时间。例如，如果统计间隔1秒，该设备有0.8秒在处理IO，而0.2秒闲置，那么该设备的%util = 0.8/1 = 80%，所以该参数暗示了设备的繁忙程度
。一般地，如果该参数是100%表示设备已经接近满负荷运行了（当然如果是多磁盘，即使%util是100%，因为磁盘的并发能力，所以磁盘使用未必就到了瓶颈）。
```