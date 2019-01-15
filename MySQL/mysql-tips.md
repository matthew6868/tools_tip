# mysql tips
1. how to connect localhost?
=> mysql -u <username> -p , e.g:mysql -u root -p

2. show database
=> show databases;
=> use mysql;

3. backup the database
=> mysqldump -h<hostname> -u<user> -p<pwd> database > backup.sql

4. import the database
=> create database wechat;
=> use wechat;
=> source backup.sql;

5. remote connect
=> sudo vim /etc/mysql/my.cnf
=> comment out bind-address and skip-external-locking
=> mysql -u root -p
=> GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY 'passwordxxxx';
=> FLUSH PRIVILEGES;exit;

6. remove root user remote access ability:
=> delete from mysql.user where user='root' and host='%';

7. change password:
=> update mysql.user set password=PASSWORD("123456") where user='root';

8. restrict the special user to one database:
=> revoke all on *.* from test@'%';
=> grant select, insert, update, delete on db_ewj.* to test@'%' ;

9. create new user and set the privileages:
```shell
> create user 'username'@'localhost' identified by 'password'; # 创建一个本地访问用户
> grant select,insert,update,delete on databasename.tablename to 'username'@'host'; # 设置访问权限
> CREATE USER 'finley'@'%' IDENTIFIED BY 'password'; # 创建一个远程访问用户
> GRANT ALL PRIVILEGES ON *.* TO 'finley'@'%' WITH GRANT OPTION; # 设置所有访问权限
```

10. upgrade from 5.7 to 8.0
> 操作之前记得使用mysqldump备份数据和表结构
```shell
$: sudo yum-config-manager --disable mysql57-community
$: sudo yum-config-manager --enable mysql80-community
$: sudo yum update mysql
$: sudo mysql_upgrade -u <user> -p <pwd> # 否则会报用户definer错误 
```
