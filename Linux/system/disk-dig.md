# 磁盘性能分析

## 工具

### lsof
>list open files,可以查看当前文件或者文件夹被哪些进程打开

 >To list all open files, use:
```shell
#: lsof
```
>To list all open Internet, x.25 (HP-UX), and UNIX domain files, use:
```shell
#: lsof -i -U
```
>To list all open IPv4 network files in use by the process whose PID is 1234, use:
```shell
#: lsof -i 4 -a -p 1234
```
>Presuming the UNIX dialect supports IPv6, to list only open IPv6 network files, use:
```shell
#:lsof -i 6
```
>To list all files using any protocol on ports 513, 514, or 515 of host wonderland.cc.purdue.edu, use:
```shell
#:lsof -i @wonderland.cc.purdue.edu:513-515
```
>To list all files using any protocol on any port of mace.cc.purdue.edu (cc.purdue.edu is the default domain), use:
```shell
#:lsof -i @mace
```
> To list all open files for login name ``abe'', or user ID 1234, or process 456, or process 123, or process 789, use:
```shell
#:lsof -p 456,123,789 -u 1234,abe
```
>To list all open files on device /dev/hd4, use:
```shell
#:lsof /dev/hd4
```
> To find the process that has /u/abe/foo open, use:
```shell
#:lsof /u/abe/foo
```
> To send a SIGHUP to the processes that have /u/abe/bar open, use:
```shell
#: kill -HUP `lsof -t /u/abe/bar`
```
> To find any open file, including an open UNIX domain socket file, with the name /dev/log, use:
```shell
#:lsof /dev/log
```
> To find processes with open files on the NFS file system named /nfs/mount/point whose server is inaccessible, and presuming your mount table supplies the device number for /nfs/mount/point, use:
```shell
#:lsof -b /nfs/mount/point
```
> To do the preceding search with warning messages suppressed, use:
```shell
#:lsof -bw /nfs/mount/point
```

### pvdisplay
> display attributes of a physical volume

```shell
#:sudo pvdisplay
  --- Physical volume ---
  PV Name               /dev/sda5
  VG Name               xuyaohz-ubuntu-hyperv-vg
  PV Size               63.52 GiB / not usable 2.00 MiB
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              16261
  Free PE               2
  Allocated PE          16259
  PV UUID               pa37mm-GluD-YrG4-2fuB-RS3v-ziVJ-t02Sku

```