# cURL

## 获取内容
```shell
#: curl http://www.baidu.com
```

## 只显示HTTP头
```shell
#: curl -l http://www.baidu.com
```

## 同时显示头和内容
```shell
#: curl -i http://www.baidu.com
```

## 同时下载多个文件
```shell
#: curl -o http://www.baidu.com -o http:www.163.com
```

## 跟随链接重定向
```shell
#: curl -L http://www.baidu.com
```

## 自定义User-Agent
```shell
#: curl -A "Mozilla/5.0 (Android; Mobile; rv:35.0) Gecko/35.0 Firefox/35.0"  http://www.baidu.com
```

## 自定义Header
```shell
#: curl -H "Referer: www.example.com" -H "User-Agent: Custom-User-Agent" http://www.baidu.com  
```
## 保存Cookie
```shell
#: curl -c "cookie-example" http://www.baidu.com
```

## 读取Cookie
```shell
#: curl -b "JSESSIONID=D0112A5063D938586B659EF8F939BE24" http://www.example.com  
#: curl -b "cookie-example" http://www.example.com   // 从文件中读取
```

## 发送POST请求
```shell
#: curl -d "userName=tom&passwd=123456" -X POST http://www.example.com/login
#: curl  -d "somedata" -X GET http://www.example.com/api // 强制使用GET
#: curl -d "@data.txt" http://www.example.com/login  //从文件中读取
#: curl -c "cookie-login" -d "userName=tom&passwd=123456" http://www.example.com/login //带Cookies登陆，用-b可以从文件在读取Cookies
```