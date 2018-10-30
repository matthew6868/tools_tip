# RabbitMQ Guideline

[TOC]

## 概要

> 安装、配置、优化指南

## 安装

## 配置

### 创建用户
```shell
$: rabbitmqctl add_user mxu 123456
```

#### 权限设置

> 设置管理员权限
```shell
$:rabbitmqctl set_user_tags mxu administrator 
```

> 设置访问权限
```shell
$:rabbitmqctl set_permissions -p / mxu ".*" ".*" ".*"
```

### 创建队列

#### 权限配置


## 优化

