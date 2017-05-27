# fio (flexible I/O tester)

## 安装

>CentOS 7
```shell
#:  sudo yum install fio
```

## 使用

>测试SATA硬盘的4KB随机写的IOPS

```shell
#: fio -ioengine=libaio -bs=4k -direct=1 -thread -rw=randwrite -size=100G -filename=/dev/sdb -name="EBS 4K write benchmark" -iodepth=64 -runtime=60
```
* ioengine：负载引擎，一般使用libaio，发起起步IO请求。<br>
* bs：IO大小。<br>
* direct：直写，绕过操作系统cache。<br>
* rw：读写模式，有顺序写write、顺序读read、随机写randwrite和随机读randread等。<br>
* size：寻址空间，IO会落在[0, size)这个区间的硬盘空间上。<br>
* filename：测试对象。<br>
* iodepth：队列深度，只有打开libaio才有意义。<br>
* runtime：测试时长。<br>

## dd测试硬盘IOPS和MBPS

```shell
#: dd if=/dev/zero of=/dev/sdd bs=2M count=1000 oflag=direct
```
* 调整bs的大小，可以调整磁盘的队列深度<br>
* 磁盘队列深度：在某一时刻，有N个inflight的IO请求，包括在队列中的IO请求、磁盘正在处理的IO请求。N就是队列深度。
