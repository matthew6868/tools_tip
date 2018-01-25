
# rdesktop
```shell
$: rdesktop -f <ip> # 全屏，按键Ctrl+Alt+Enter退出/进入全屏
$: rdesktop -g 1920x1050 -D -r clipboard:PRIMARYCLIPBOARD -a 24 -x lan -x 0x80 <xuyao-pc> # -g:屏幕大小，-D隐藏窗口条，-r后面的表示共享剪贴板, -x lan表示网络环境，-a 24表示24bit位数, -x 0x80使用clear type字体
```