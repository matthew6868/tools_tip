# gdb 

[TOC]

### 符号表加载
```shell
$: gdb -g hello.c # 产生符合操作系统本地格式的调试信息（stabs、COFF、XCOFF ，或者 DWARF 2）
$: gdb -s hello.c # strip, 编译时去除调试符号信息
$: ojbcopy --only-keep-debug hello hello.debug # 保存调试信息到单独文件
$: strip hello # 删除ELF格式文件符号表信息命令，支持自定义符号表信息
$: gdb > symbol-file xxxx.pdb # 加载独立符号表,默认情况下会根据路径选找对应的.debug后缀的符号表信息
```

### 根据文件名调试指定程序
>gdb debug-sample #加载制定文件符号表
>r arg1 arg2 # 运行该程序

### attach指定程序
>gdb debug-sample #加载制定文件符号表
>attach PID #指定pid

### 继续运行
>c

### 中断运行
>handle SIGINT stop #设置终端信号，然后在其它终端输入:kill -s INT <PID>


### 单步运行
>s # step <count> 单步跟踪，如果有函数调用，进入
>n # next <count> 单步跟踪，跳过函数调用

### 显示所有堆栈
>thread app all bt #show all threads with stack unwind

### 显示当前线程堆栈
>bt
>backtrace #show call stack
>info stack

### 显示当前栈的变量
>i locals

### 重定向
>set logging file xxx.txt
>set logging on
>info functions
>set logging off

### 设置断点
>break [line-number]
>rbreak [regex expression]

### 删除断点
>info break
>delete [num]

### 显示当前栈的参数
>info args

### 显示当前代码内容
>list
>list 10
>list 5, 10

### 显示窗口
>layout src # 显示源码窗口  
>layout cmd # 显示命令行窗口  
>layout regs # 显示寄存器窗口  
>layout asm # 显示汇编窗口  
>layout next #  
>layout prev #  
>layout split #   
>winheight src +5 # 设置src窗口增加高度5行  
>focus src # 聚焦源码窗口  
>info win #显示窗口大小  
>[C-x], a #退出layout  Ctrl + x，再按a

### 输出变量（对象）内容
>set print/p pretty on # pretty输出
>print/p *this  
>print/p this->member  
x 按十六进制格式显示变量。  
d 按十进制格式显示变量。  
u 按十六进制格式显示无符号整型。  
o 按八进制格式显示变量。  
t 按二进制格式显示变量。  
a 按十六进制格式显示变量。  
c 按字符格式显示变量。  
f 按浮点数格式显示变量。  
>p/c <address>  
>p/c *address@len #address和len为地址和长度数值  

### 查找函数符号
>info functions [正则表达式]

### 进入指定frame
>frame 1[number]

### CentOS 7 安装glibc符号表和源代码

```shell
%:sudo vim /etc/yum.repos.d/CentOS-Debuginfo.repo #设置enable => 1 开启调试仓库版本
%:sudo yum install glibc-debuginfo
```
### 设置so库符号表的路径
```shell
gdb> set solib-absolute-prefix -- Set prefix for loading absolute shared library symbol files
gdb> set solib-search-path -- Set the search path for loading non-absolute shared library symbol files
```

### 设置GO语言支持
如果gdb里面有警告加载失败，添加如下到~/.gdbinit文件中
>add-auto-load-safe-path /usr/local/go/src/runtime/runtime-gdb.py
查看goroutines
>info goroutines
>goroutine 1 bt
更多指令参考：https://golang.org/doc/gdb


### info命令
```
"info" must be followed by the name of an info command.
List of info subcommands:

info address -- Describe where symbol SYM is stored
info all-registers -- List of all registers and their contents
info args -- Argument variables of current stack frame
info auto-load -- Print current status of auto-loaded files
info auto-load-scripts -- Print the list of automatically loaded Python scripts
info auxv -- Display the inferior's auxiliary vector
info bookmarks -- Status of user-settable bookmarks
info breakpoints -- Status of specified breakpoints (all user-settable breakpoints if no argument)
info checkpoints -- IDs of currently known checkpoints
info classes -- All Objective-C classes
info common -- Print out the values contained in a Fortran COMMON block
info copying -- Conditions for redistributing copies of GDB
info dcache -- Print information on the dcache performance
info display -- Expressions to display when program stops
info exceptions -- List all Ada exception names
info extensions -- All filename extensions associated with a source language
info files -- Names of targets and files being debugged
info float -- Print the status of the floating point unit
info frame -- All about selected stack frame
info frame-filter -- List all registered Python frame-filters
info functions -- All function names
info guile -- Prefix command for Guile info displays
info handle -- What debugger does when program gets various signals
info inferiors -- IDs of specified inferiors (all inferiors if no argument)
info line -- Core addresses of the code for a source line
info locals -- Local variables of current stack frame
info macro -- Show the definition of MACRO
info macros -- Show the definitions of all macros at LINESPEC
info mem -- Memory region attributes
info os -- Show OS data ARG
info pretty-printer -- GDB command to list all registered pretty-printers
info probes -- Show available static probes
info proc -- Show /proc process information about any running process
info program -- Execution status of the program
info record -- Info record options
info registers -- List of integer registers and their contents
info scope -- List the variables local to a scope
info selectors -- All Objective-C selectors
info set -- Show all GDB settings
---Type <return> to continue, or q <return> to quit---
info sharedlibrary -- Status of loaded shared object libraries
info signals -- What debugger does when program gets various signals
info skip -- Display the status of skips
info source -- Information about the current source file
info sources -- Source files in the program
info stack -- Backtrace of the stack
info static-tracepoint-markers -- List target static tracepoints markers
info symbol -- Describe what symbol is at location ADDR
info target -- Names of targets and files being debugged
info tasks -- Provide information about all known Ada tasks
info terminal -- Print inferior's saved terminal status
info threads -- Display currently known threads
info tracepoints -- Status of specified tracepoints (all tracepoints if no argument)
info tvariables -- Status of trace state variables and their values
info type-printers -- GDB command to list all registered type-printers
info types -- All type names
info unwinder -- GDB command to list unwinders
info variables -- All global and static variable names
info vector -- Print the status of the vector unit
info vtbl -- Show the virtual function table for a C++ object
info warranty -- Various kinds of warranty you do not have
info watchpoints -- Status of specified watchpoints (all watchpoints if no argument)
info win -- List of all displayed windows
info xmethod -- GDB command to list registered xmethod matchers
```

### handle命令
```
(gdb) help handle
Specify how to handle signals.
Usage: handle SIGNAL [ACTIONS]
Args are signals and actions to apply to those signals.
If no actions are specified, the current settings for the specified signals
will be displayed instead.

Symbolic signals (e.g. SIGSEGV) are recommended but numeric signals
from 1-15 are allowed for compatibility with old versions of GDB.
Numeric ranges may be specified with the form LOW-HIGH (e.g. 1-5).
The special arg "all" is recognized to mean all signals except those
used by the debugger, typically SIGTRAP and SIGINT.

Recognized actions include "stop", "nostop", "print", "noprint",
"pass", "nopass", "ignore", or "noignore".
Stop means reenter debugger if this signal happens (implies print).
Print means print a message if this signal happens.
Pass means let program see this signal; otherwise program doesn't know.
Ignore is a synonym for nopass and noignore is a synonym for pass.
Pass and Stop may be combined.

Multiple signals may be specified.  Signal numbers and signal names
may be interspersed with actions, with the actions being performed for
all signals cumulatively specified.
```
