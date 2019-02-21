# iptables


```shell
$: sudo iptables -L
$: sudo iptables -t filter -A INPUT -p tcp  -m iprange --src-range 192.168.240.13-192.168.240.20  -m multiport --dports 80,7480  -j ACCEPT
$: sudo iptables -t filter -A INPUT -p tcp -m multiport --dports  80,7480 -j DROP
```
