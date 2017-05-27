# Ubuntu 配置ssh远程登陆服务器
1,安装openssh-server

2,免密码登陆：
添加用户的公钥到用户目录下面的.ssh/authorized_keys
比如:
```shell
#:cat id_rsa.pub >> ~/.ssh/authorized_keys
#:chmod 600 authorized_keys
#:chmod 700 -R ~/.ssh
```

3, Could not open a connection to your authentication agent
```shell
#: eval $(ssh-agent -s) > /dev/null
#: ssh-add ~/.ssh/id_rsa.cmcc
#: ssh-add -l
```