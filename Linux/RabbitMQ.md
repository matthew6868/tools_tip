# RabbitMQ Guideline

[TOC]

## 概要

> 安装、配置、优化指南

## 安装
> http://www.rabbitmq.com/install-rpm.html

> cat /etc/yum.repos.d/rabbitmq.repo
```text
[bintray-rabbitmq-server]
name=bintray-rabbitmq-rpm
baseurl=https://dl.bintray.com/rabbitmq/rpm/rabbitmq-server/v3.7.x/el/7/
gpgcheck=0
repo_gpgcheck=0
enabled=1
```

```shell
$:sudo rpm --import https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc
$:sudo yum install rabbitmq-server
```

## 启动

```shell
$:sudo chkconfig rabbitmq-server on
$:sudo /sbin/service rabbitmq-server start
```

## 配置

### 插件
> http://www.rabbitmq.com/plugins.html

#### 添加管理插件
> http://www.rabbitmq.com/management.html

```shell
$:sudo rabbitmq-plugins enable rabbitmq_management
$:sudo service rabbitmq-server restart
```

### 创建用户
```shell
$:sudo rabbitmqctl add_user <username> 123456
```

#### 权限设置

> 设置管理员权限
```shell
$:sudo rabbitmqctl set_user_tags <username> administrator 
```

> 设置访问权限
```shell
$:sudo rabbitmqctl set_permissions -p / <username> ".*" ".*" ".*"
```

### 创建队列

#### 权限配置

## 常见命令
1. 查看状态，包括文件描述符个数信息等

```shell
$:sudo rabbitmqctl status
```

2. 插件命令
```shell
$:sudo rabbitmq-plugins list
$:sudo rabbitmq-plugins enable <plugin-name>
$:sudo rabbitmq-plugins disable <plugin-name>
```
## 优化
### 系统参数配置

#### 修改系统文件描述符个数限制
> cat /etc/systemd/system/rabbitmq-server.service.d/limits.conf
```conf
[Service]
LimitNOFILE=300000
```
