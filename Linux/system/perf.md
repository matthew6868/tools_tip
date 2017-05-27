# perf

## introduction
>Performance analysis tools for Linux.
>Performance counters for Linux are a new kernel-based subsystem that provide a framework for all things
>performance analysis. It covers hardware level (CPU/PMU, Performance Monitoring Unit) features and
>software features (software counters, tracepoints) as well.

## installation

### ubuntu

```shell
#:sudo apt-get install linux-tools-common
#:sudo apt-get install linux-tools-4.4.0-62-generic linux-cloud-tools-4.4.0-62-generic linux-tools-generic linux-cloud-tools-generic
#:rehash
#:perf
```

## usage

```shell
#:perf help # 查看所有命令
#:perf list # List all symbolic event types
#:perf record ./client # 采样
#:perf stat ./client #
#:perf record -e cpu-clock -g -a ./client # cpu-clock事件，-g(call-graph)显示调用的详细信息消耗
#:perf report -i perf.data|less # 查看，如果出现内核符号加载失败问题，用sudo perf report -f
#:perf report --percent-limit 5 -i fb.data # 只显示5%以上的数据
#:perf stat -I 1000 # 每隔1秒钟刷新显示一次状态
```

## help

```text
[.] : user level
[k]: kernel level
[g]: guest kernel level (virtualization)
[u]: guest os user space
[H]: hypervisor
```

## manual

```text
 usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

 The most commonly used perf commands are:
   annotate        Read perf.data (created by perf record) and display annotated code
   archive         Create archive with object files with build-ids found in perf.data file
   bench           General framework for benchmark suites
   buildid-cache   Manage build-id cache.
   buildid-list    List the buildids in a perf.data file
   data            Data file related processing
   diff            Read perf.data files and display the differential profile
   evlist          List the event names in a perf.data file
   inject          Filter to augment the events stream with additional information
   kmem            Tool to trace/measure kernel memory properties
   kvm             Tool to trace/measure kvm guest os
   list            List all symbolic event types
   lock            Analyze lock events
   mem             Profile memory accesses
   record          Run a command and record its profile into perf.data
   report          Read perf.data (created by perf record) and display the profile
   sched           Tool to trace/measure scheduler properties (latencies)
   script          Read perf.data (created by perf record) and display trace output
   stat            Run a command and gather performance counter statistics
   test            Runs sanity tests.
   timechart       Tool to visualize total system behavior during a workload
   top             System profiling tool.
   trace           strace inspired tool
   probe           Define new dynamic tracepoints

 See 'perf help COMMAND' for more information on a specific command.
```