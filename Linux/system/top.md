##
## top 命令说明
us: is meaning of "user CPU time",用户空间占用CPU百分比
sy: is meaning of "system CPU time",内核空间占用CPU百分比
ni: is meaning of" nice CPU time", 用户进程空间内改变过优先级的进程占用CPU百分比
id: is meaning of "idle",空闲CPU百分比
wa: is meaning of "iowait" ,等待输入输出的CPU时间百分比
hi：is meaning of "hardware irq",硬件中断
si : is meaning of "software irq",软件中断 
st : is meaning of "steal time",实时

快捷键：
f
j
V - 树视图
1 - 显示cpu核心详情
i - 切换显示运行/闲时进程
c - 显示进程命令行全路径

## mpstat 命令 ==> Report processors related statistics.
$:mpstat -I SUM -P ALL 5 => 查看一下每个cpu的终端情况

## cat /proc/interrupts  ==> 查看中断
