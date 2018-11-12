# MongoDB

[TOC]

## 安装

> https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/

## 配置

> 默认存储数据地址:
> its data files in /var/lib/mongo
> its log files in /var/log/mongodb

### 配置SELINUX
1. 允许端口方式
```shell
$: sudo semanage port -a -t mongod_port_t -p tcp 27017
```

2. 禁用方式
```shell
$: sudo echo SELINUX=disabled >> /etc/selinux/config
$: sudo echo SELINUX=permissive >> /etc/selinux/config
```
> 需要重启系统？

## 启动

```shell
$: sudo service mongod start
$: sudo chkconfig mongod on
$: sudo service mongod stop
$: sudo service mongod restart
```

## 优化
