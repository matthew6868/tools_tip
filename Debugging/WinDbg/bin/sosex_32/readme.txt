Quick Ref:
--------------------------------------------------
dlk       (no parameters)                                Displays deadlocks between SyncBlocks and/or ReaderWriterLocks
dumpgen   <GenNum> [-free] [-stat] [-type <TYPE_NAME>]   Dumps the contents of the specified generation
finq      [GenNum] [-stat]                               Displays objects in the finalization queue
frq       [-stat]                                        Displays objects in the Freachable queue
gcgen     <ObjectAddr>                                   Displays the GC generation of the specified object
gch       [HandleType]...                                Lists all GCHandles, optionally filtered by specified handle types
help      [CommandName]                                  Display this screen or details about the specified command
mbc       <SOSEX breakpoint ID | *>                      Clears the specified or all managed breakpoints
mbd       <SOSEX breakpoint ID | *>                      Disables the specified or all managed breakpoints
mbe       <SOSEX breakpoint ID | *>                      Enables the specified or all managed breakpoints
mbl       [SOSEX breakpoint ID]                          Prints the specified or all managed breakpoints
mbm       <Type/MethodFilter> [ILOffset] [Options]       Sets a managed breakpoint on methods matching the specified filter
mbp       <SourceFile> <nLineNum> [ColNum] [Options]     Sets a managed breakpoint at the specified source code location
mdt       [TypeName | VarName | MT] [ADDR] [Options]     Displays the fields of an object or type, optionally recursively
mdv       (no parameters)                                Displays arguments and locals for a managed frame
mframe    [nFrameNum]                                    Displays or sets the current managed frame for the !mdt and !mdv commands
mk        [FrameCount] [-l] [-p] [-a]                    Prints a stack trace of managed and unmanaged frames
mln       [expression]                                   Displays the type of managed data located at the specified address or the current instruction pointer
mx        <Filter String>                                Displays managed type/field/method names matching the specified filter string
refs      <ObjectAddr>                                   Displays all references from and to the specified object
rwlock    [ObjectAddr]                                   Displays all RWLocks or, if provided a RWLock address, details of the specified lock
sosexhelp [CommandName]                                  Display this screen or details about the specified command
strings   [ModulePtr] [Options]                          Lists all strings on managed heaps, or in the specified module, that match the specified criteria

ListGcHandles - See gch

Use !help <command> or !sosexhelp <command> for more details about each command.
``

*!dlk
Performs SyncBlock deadlock detection. If deadlocks are found, the held/needed locks and thread info is displayed.
!dlk is only useful for managed SyncBlock deadlocks, eg. objects locked using Monitor.Enter

Note that the thread ID values reported are the CLR thread numbers, not the debugger native thread numbers.
Use the sos!threads command to see the corresponding debugger native thread number.

Sample output demonstrating the various kinds of deadlock and how they are displayed:

0:027> !sosex.dlk
Examining SyncBlocks...
Scanning for ReaderWriterLocks...
Scanning for lock holders on ReaderWriterLocks...
Scanning for threads waiting on SyncBlocks...
Scanning for threads waiting on ReaderWriterLocks...
Deadlock detected:
CLR Thread 5 is waiting for a Writer lock on orphaned ReaderWriterLock 06254444
The lock was orphaned by CLR thread 4, which was holding a Reader lock when it terminated.
CLR Thread 5 is waiting at System.Threading.ReaderWriterLock.AcquireWriterLock(Int32)(+0x0 IL)(+0x0 Native)

Deadlock detected:
CLR Thread 7 is waiting for a Reader lock on orphaned ReaderWriterLock 06254470
The lock was orphaned by CLR thread 6, which was holding a Writer lock when it terminated.
CLR Thread 7 is waiting at System.Threading.ReaderWriterLock.AcquireReaderLock(Int32)(+0x0 IL)(+0x0 Native)

Deadlock detected:
CLR thread 8 holds a Reader lock on ReaderWriterLock 0625449c
             is waiting for a Writer lock on ReaderWriterLock 062544c8
CLR thread 9 holds a Reader lock on ReaderWriterLock 062544c8
             is waiting for a Writer lock on ReaderWriterLock 0625449c
CLR Thread 8 is waiting at System.Threading.ReaderWriterLock.AcquireWriterLock(Int32)(+0x0 IL)(+0x0 Native)
CLR Thread 9 is waiting at System.Threading.ReaderWriterLock.AcquireWriterLock(Int32)(+0x0 IL)(+0x0 Native)

Deadlock detected:
CLR thread 10 holds a Writer lock on ReaderWriterLock 062544f4
             is waiting for a Reader lock on ReaderWriterLock 06254520
CLR thread 11 holds a Writer lock on ReaderWriterLock 06254520
             is waiting for a Reader lock on ReaderWriterLock 062544f4
CLR Thread 10 is waiting at System.Threading.ReaderWriterLock.AcquireReaderLock(Int32)(+0x0 IL)(+0x0 Native)
CLR Thread 11 is waiting at System.Threading.ReaderWriterLock.AcquireReaderLock(Int32)(+0x0 IL)(+0x0 Native)

Deadlock detected:
CLR thread 12 holds a Writer lock on ReaderWriterLock 0625454c
             is waiting for a Writer lock on ReaderWriterLock 06254578
CLR thread 13 holds a Reader lock on ReaderWriterLock 06254578
             is waiting for a Reader lock on ReaderWriterLock 0625454c
CLR Thread 12 is waiting at System.Threading.ReaderWriterLock.AcquireWriterLock(Int32)(+0x0 IL)(+0x0 Native)
CLR Thread 13 is waiting at System.Threading.ReaderWriterLock.AcquireReaderLock(Int32)(+0x0 IL)(+0x0 Native)

Deadlock detected:
CLR thread 14 owns SyncBlock 007eb640 OBJ:06254200[System.String] STRVAL=MixedLock1
             is waiting for a Reader lock on ReaderWriterLock 062545a4
CLR thread 15 holds a Writer lock on ReaderWriterLock 062545a4
             is waiting for SyncBlock 007eb640 OBJ:06254200[System.String] STRVAL=MixedLock1
CLR Thread 14 is waiting at System.Threading.ReaderWriterLock.AcquireReaderLock(Int32)(+0x0 IL)(+0x0 Native)
CLR Thread 15 is waiting at ConsoleTestApp.ConsoleTestApp.RwLockThread8()(+0x2d IL)(+0x4e Native) [C:\dev\ConsoleTestApp\ConsoleTestApp.cs, @ 468,13]

Deadlock detected:
CLR thread 16 holds a Writer lock on ReaderWriterLock 062545d0
             is waiting for SyncBlock 007eb6dc OBJ:06254224[System.String] STRVAL=MixedLock2
CLR thread 17 owns SyncBlock 007eb6dc OBJ:06254224[System.String] STRVAL=MixedLock2
             is waiting for a Reader lock on ReaderWriterLock 062545d0
CLR Thread 16 is waiting at ConsoleTestApp.ConsoleTestApp.RwLockThread9()(+0x2d IL)(+0x4e Native) [C:\dev\ConsoleTestApp\ConsoleTestApp.cs, @ 482,13]
CLR Thread 17 is waiting at System.Threading.ReaderWriterLock.AcquireReaderLock(Int32)(+0x0 IL)(+0x0 Native)

Deadlock detected:
CLR Thread 19 is waiting for orphaned SyncBlock 007eb744 OBJ:06254180[System.String] STRVAL=SYNC3
The lock was orphaned by CLR thread 18, which has since terminated.
CLR Thread 19 is waiting at ConsoleTestApp.ConsoleTestApp.LockReleaseAndExit()(+0x16 IL)(+0x29 Native) [C:\dev\ConsoleTestApp\ConsoleTestApp.cs, @ 624,13]

Deadlock detected:
CLR thread 21 owns SyncBlock 007eb814 OBJ:06254150[System.String] STRVAL=SYNC1
             is waiting for SyncBlock 007eb7e0 OBJ:06254168[System.String] STRVAL=SYNC2
CLR thread 22 owns SyncBlock 007eb7e0 OBJ:06254168[System.String] STRVAL=SYNC2
             is waiting for SyncBlock 007eb814 OBJ:06254150[System.String] STRVAL=SYNC1
CLR Thread 21 is waiting at ConsoleTestApp.ConsoleTestApp.MonitorDeadlockThreadProc()(+0xc4 IL)(+0x1a9 Native) [C:\dev\ConsoleTestApp\ConsoleTestApp.cs, @ 598,5]
CLR Thread 22 is waiting at ConsoleTestApp.ConsoleTestApp.MonitorDeadlockThreadProc()(+0xc4 IL)(+0x1a9 Native) [C:\dev\ConsoleTestApp\ConsoleTestApp.cs, @ 598,5]

9 deadlocks detected.
``

*!dumpgen
Usage: !sosex.dumpgen <intGenNum> [-free] [-stat] [-type <TYPE_NAME>]

Dumps the contents of the specified generation in the following format:
hexAddr decSize strTypeName

Pass 3 to dump the large object heap

If -free is specified, only FREE object types are included
If -stat is specified, only a statistical summary is presented
If -type is specified, the output is filtered to only include objects where TYPE_NAME is a substring of the full type name.

Sample output:
0:000>!sosex.dumpgen 1
7fff2310	    216	System.Globalization.NumberFormatInfo
7fff23e8	     28	System.Int32[]
7fff28c8	     74	System.String	STRVAL=NLS_CodePage_437_3_2_0_0
7fff2918	     32	Microsoft.Win32.SafeHandles.SafeViewOfFileHandle
``

*!finq
Usage: !sosex.finq [GenNum] [-stat]

Lists objects in the finalization queue, by generation.  To list objects only for a given generation, pass the desired generation number.
Passing -stat prints finalization queue type statisticts, by generation.

Sample Output:
0:027> !finq 1
Generation 1:
Address        Size     Type
---------------------------------------------------------
04bf16e0         24     ConsoleTestApp.FTEST
04bf3e5c         24     ConsoleTestApp.FTEST
04dbd8b0         24     ConsoleTestApp.FTEST
04dc002c         24     ConsoleTestApp.FTEST
090e6bfc         24     ConsoleTestApp.FTEST
090e4480         24     ConsoleTestApp.FTEST
09187228         24     ConsoleTestApp.FTEST
09184aac         24     ConsoleTestApp.FTEST
092bebf8         24     ConsoleTestApp.FTEST
092c1374         24     ConsoleTestApp.FTEST
10 objects, 240 bytes



!finq -stat sample output:

0:028> !finq -stat
Generation 0:
       Count      Total Size      Type
-------------------------------------------------
          93           2232       ConsoleTestApp.FTEST

93 objects, 2232 bytes

Generation 1:
       Count      Total Size      Type
-------------------------------------------------
           2             48       ConsoleTestApp.FTEST

2 objects, 48 bytes

Generation 2:
       Count      Total Size      Type
-------------------------------------------------
           1             24       ConsoleTestApp.FTEST
           1             84       System.Net.Sockets.Socket
           2             40       System.Net.SafeCloseSocket+InnerSafeCloseSocket
           1             24       System.Net.SafeCloseSocket
           1             20       Microsoft.Win32.SafeHandles.SafeTokenHandle
           2            120       System.Runtime.Remoting.Contexts.Context
           7            140       Microsoft.Win32.SafeHandles.SafeRegistryHandle
          10            160       System.WeakReference
          32            640       Microsoft.Win32.SafeHandles.SafeWaitHandle
           1             20       Microsoft.Win32.SafeHandles.SafePEFileHandle
          18            864       System.Threading.Thread
           2             40       System.Security.Cryptography.SafeProvHandle
          24           1056       System.Threading.ReaderWriterLock
           2             40       Microsoft.Win32.SafeHandles.SafeFileHandle
           1             20       Microsoft.Win32.SafeHandles.SafeViewOfFileHandle
           1             20       Microsoft.Win32.SafeHandles.SafeFileMappingHandle

106 objects, 3312 bytes

TOTAL: 201 objects, 5592 bytes
``

*!frq
Usage: !sosex.frq [-stat]

Lists all objects in the f-reachable queue.  Passing -stat causes only type statistics to be printed.

Sample Output:
0:029> !frq
Freachable Queue:
Address        Size     Type
---------------------------------------------------------
021c4994         20     Microsoft.Win32.SafeHandles.SafeTokenHandle
021cde98         20     Microsoft.Win32.SafeHandles.SafeTokenHandle
021c4ac4         20     Microsoft.Win32.SafeHandles.SafeTokenHandle
021e0d88         48     System.Threading.Thread
021c6de4         20     Microsoft.Win32.SafeHandles.SafeTokenHandle
021c48d8         20     Microsoft.Win32.SafeHandles.SafeTokenHandle
021cec40         20     Microsoft.Win32.SafeHandles.SafeTokenHandle
05f2b3e4         24     ConsoleTestApp.FTEST
05f2db60         24     ConsoleTestApp.FTEST
...snip
12659 objects, 303848 bytes

!frq -stat sample output:

0:029> !frq -stat
Freachable Queue:
       Count      Total Size      Type
-------------------------------------------------
       12646         303504       ConsoleTestApp.FTEST
          10            200       Microsoft.Win32.SafeHandles.SafeTokenHandle
           3            144       System.Threading.Thread

12659 objects, 303848 bytes
``

*!gcgen
Usage: !sosex.gcgen <hexObjectAddr>

Indicates the GC generation where the specified object is located
If the object is in the LOH, "Large Object Heap" will be indicated
``

*!gch
Usage: !sosex.gch [-HandleType]

Lists all GCHandle instances. To list handles of a certain type, pass 1 or more types preceded by a dash (-).
e.g. !gch -Pinned -Strong

Valid types:
------------
WeakShort
WeakLong
Strong
Pinned
Variable
RefCounted
AsyncPinned

Sample Output:

0:029> !gch
HandleObj   HandleType  Object         Size	  Type
------------------------------------------------------------------------------------
00161198	Strong     	02c0f9c8	     24   System.Object[]
001611b0	Strong     	021e0ce0	     48   System.Threading.Thread
001613fc	Pinned     	0a1a0048	   4096   System.Object[]
001f10fc	Strong     	061a005c	     84   System.Exception
001f11ec	Pinned     	061ac6e4	     26   System.String	 STRVAL=pinned
001f11f0	Pinned     	0a1a2288	   8176   System.Object[]
001f11f4	Pinned     	0a1a1278	   4096   System.Object[]
001f11f8	Pinned     	0a1a1058	    528   System.Object[]
001f11fc	Pinned     	061a0254	     12   System.Object
005611f0	Strong     	06239f30	     36   System.Security.PermissionSet
005611f8	Strong     	06230144	     80   System.Runtime.Remoting.ServerIdentity
005611fc	Strong     	0622fe90	    112   System.AppDomain
005612f8	Pinned     	0a1a5298	   8176   System.Object[]
005612fc	Pinned     	0a1a4288	   4096   System.Object[]
``

*!mbc
Usage: !sosex.mbc <Managed Breakpoint ID | *>

Removes the specified breakpoint from the managed breakpoint list. If * is specified, removes all managed breakpoints.
``

*!mbd
Usage: !sosex.mbd <Managed Breakpoint ID | *>

Disables, but does not remove, the specified breakpoint. If * is specified, disables all managed breakpoints.
Any corresponding native breakpoints that have been set in support of the specified managed breakpoint will
also be disabled, unless a native breakpoint is shared by multiple managed breakpoints.
``

*!mbe
Usage: !sosex.mbd <Managed Breakpoint ID | *>

Enables the specified breakpoint. If * is specified, enables all managed breakpoints.
Any corresponding native breakpoints that have been set in support of the specified managed breakpoint will
also be enabled.
``

*!mbl
Usage: !sosex.mbl [Managed Breakpoint ID]

Prints the specified breakpoint or a list of all managed breakpoints with status, parameters and corresponding native breakpoint info.

Sample output:
0:000>!sosex.mbl
4 e : tester.cs, line 22: pass=1 oneshot=false thread=ANY
   TestLib!TestLib.Tester.Test<T1, T2>(T1, T2)+0x3(IL) (PENDING JIT)
      0 e 002f0cf3: Test<TestStruct, Int32>(TestStruct, Int32)
3 e : *!TESTLIB.TESTER.TEST ILOffset=0: pass=1 oneshot=false thread=ANY
   TestLib!TestLib.Tester.Test<T1, T2>(T1, T2) (PENDING JIT)
      1 e 002f0cea: Test<TestStruct, Int32>(TestStruct, Int32)
2 e : *!CONSOLETESTAPP.CONSOLETESTAPP.OVERLOADTEST ILOffset=0: pass=1 oneshot=false thread=ANY
   ConsoleTestApp!ConsoleTestApp.ConsoleTestApp.OverloadTest(string) (PENDING JIT)
   ConsoleTestApp!ConsoleTestApp.ConsoleTestApp.OverloadTest(int) (PENDING JIT)
1 eu: consoletestapp.cs, line 170: pass=1 oneshot=false thread=ANY
0 e : *!CONSOLETESTAPP.CONSOLETESTAPP.MAIN ILOffset=0: pass=1 oneshot=false thread=ANY
   ConsoleTestApp!ConsoleTestApp.ConsoleTestApp.Main(string[]) (PENDING JIT)
      2 e 003a0212

For each managed breakpoint, there are three levels of information, each of which is indicated by the indentation
level: 0, 3 and 6 characters, respectively.

LEVEL 1:
As an example of the first level of information, take the following line, indicating a resolved breakpoint:
4 e : tester.cs, line 22: pass=1 oneshot=false thread=ANY

The number 4 is the managed breakpoint ID.  The e indicates that the breakpoint is enabled.
If the breakpoint were disabled, a d would be displayed instead.  Following the first colon,
either the source/line/column info or method name is displayed, depending on whether the 
breakpoint is a source (!mbp) breakpoint or a method (!mbm) breakpoint.  Following the second
colon are the breakpoint parameters.

Here's a sample of an unresolved breakpoint:
1 eu: consoletestapp.cs, line 170: pass=1 oneshot=false thread=ANY

The only difference here is the presence of the u character, indicating that the breakpoint is
unresolved.  For managed breakpoints, unresolved means that the breakpoint has not yet been 
matched to a method definition in any currently-loaded module.


LEVEL 2:
For resolved breakpoints, the second line in the managed breakpoint display, which is indented by 3
characters, indicates information about the method that matched the breakpoint source info or method name.

Example (managed breakpoint 2):
   ConsoleTestApp!ConsoleTestApp.ConsoleTestApp.OverloadTest(string) (PENDING JIT)

This indicates the name of the method that matched the input criteria.  There may be more than
one method displayed here under either of the following conditions: 1) The input to !mbm contained
wildcards that match more than one method, and/or 2) The input to !mbm specified the name of an
overloaded method.  The PENDING JIT prompt indicates either of two conditions: 1) The method has
been resolved, but not yet jitted, and/or 2) The method is a generic method.  Generic methods are
always listed as pending JIT because a new instance of the method can be created at any time.


LEVEL 3:
The third level of information, indented by 6 characters displays information for any native breakpoints 
that have been set in support of the managed breakpoint.

Example (managed breakpoint 3)
      1 e 002f0cea: Test<TestStruct, Int32>(TestStruct, Int32)

The 1 is the debugger ID for the corresponding native breakpoint.  This is the same identifier that 
would be displayed by the bl command.  The e indicates that the native breakpoint is enabled.  A d
could also be displayed, indicating that the native breakpoint is disabled.  Native breakpoints that
correspond to managed breakpoints can be controlled by the native debugger breakpoint commands, 
such as be, bd, bc, etc.  Next, the address of the native breakpoint is listed.  In this particular
example, method signature information is displayed.  This is because the method is a generic method.
In this case, the signature is necessary in order to distinguish between the different method instances.
For generic methods, multiple native breakpoints may be displayed, indicating all the current instances
of the method.  For non-generic methods, no method signature is displayed, because it would be redundant.
``

*!mbm
Usage: !sosex.mbm <method filter> [ILOffset] [Options]

Sets a breakpoint at the specified method and offset.

Method Filter:
The method filter is a wildcard seach string in module!method format.  If module! is not specified, all
modules are searched for matching methods.  The method filter is compared against the fully-qualified
name of each method.

IL Offset:
The IL Offset, if specified, is a decimal integer value.  This offset determines where in the method
the breakpoint will be set.

Options:
/1 - Sets a one-shot breakpoint

/p:n - Sets the pass count for the breakpoint.  This causes the breakpoint to be triggered only when the 
breakpoint has been "hit" the specified number of times.  /p:1 causes the breakpoint to be triggered on the
first hit, /p:3 causes the breakpoint to be triggered only on the third hit.

/t:n - Causes the breakpoint only to be applied to the specified thread.  "n" is the decimal debugger thread ID.

"command" - Exactly one quoted string parameter may be specified. The contents of this string will be passed on
to corresponding native breakpoints as the command parameter.

For further details about these options, see the debugger documentation for the 'bp' command.
``

*!mbp
Usage: !sosex.mbp <source file> <line number> [column number> [Options]

Sets a breakpoint at the specified source file and line/column number.

Source File:
The name of the source code file in which to set the breakpoint.  Do not specify a full path.

Line number:
The decimal number of the line in <source file> at which to set the breakpoint.

Column number:
The decimal number of the column of <line number> at which to set the breakpoint.

Options:
/1 - Sets a one-shot breakpoint

/p:n - Sets the pass count for the breakpoint.  This causes the breakpoint to be triggered only when the 
breakpoint has been "hit" the specified number of times.  /p:1 causes the breakpoint to be triggered on the
first hit, /p:3 causes the breakpoint to be triggered only on the third hit.

/t:n - Causes the breakpoint only to be applied to the specified thread.  "n" is the decimal debugger thread ID.

"command" - Exactly one quoted string parameter may be specified. The contents of this string will be passed on
to corresponding native breakpoints as the command parameter.

For further details about these options, see the debugger documentation for the 'bp' command.
``

*!mdt
Usage: !sosex.mdt [typename | paramname | localname | MT] [ADDR] [-r[:level]] [-e[:level]]

Sample usages:
"!sosex.mdt typeName"  (displays the names of the member fields of the specified type)
"!sosex.mdt argName"   (displays the values of the fields of the specified parameter object. -r is valid)
"!sosex.mdt localName" (displays the values of the fields of the specified local variable. -r is valid)
"!sosex.mdt ADDR"      (displays the values of the fields of the object located at ADDR. -r is valid)
"!sosex.mdt MT ADDR"   (displays the values of the fields of the value type specified by MT located at ADDR. -r is valid)

"!sosex.mdt varName.fieldName.fieldName" (Traverses the specified field path and displays the end value.
-r and -e switches can be used to expand or recurse the end field value.)

Displays the fields of the specified object or type, optionally recursively.

If -r is specified, fields will be displayed recursively down the object graph.  The -r switch is ONLY 
applicable where an address is used, either by passing an address explicitly or when a param/local name 
that resolves to an address is specified.  To limit the levels of the graph that are displayed, append the desired
maximum level, preceded by a colon.  e.g. !mdt myVar -r:3

The -e switch causes certain collection types to be expanded.  The currently expandable collection types are:
Array, ArrayList, List, Hashtable and Dictionary.  You can also specify a maximum expansion level by appending 
the desired maximum level, preceded by a colon.  e.g. !mdt myColl -e:3.  The minimum (and default) level is 2, 
which means that the collection is expanded to show each element address and it's top level fields.

Sample of collection expansion:
0:000> !mdt -e consoletestapp.consoletestapp.__di1
06391948 (System.Collections.Generic.Dictionary`2[[System.Int32, mscorlib],[System.Int32, mscorlib]])
Count = 2
[0] (System.Collections.Generic.Dictionary`2+Entry[[System.Int32, mscorlib],[System.Int32, mscorlib]]) VALTYPE (MT=6cb6a600, ADDR=063948e4)
    key:0x7b (System.Int32)
    value:0x4ce (System.Int32)
[1] (System.Collections.Generic.Dictionary`2+Entry[[System.Int32, mscorlib],[System.Int32, mscorlib]]) VALTYPE (MT=6cb6a600, ADDR=063948f4)
    key:0x1c8 (System.Int32)
    value:0x198c (System.Int32)

0:000> !mdt -e ht2
061ab3f8 (System.Collections.Hashtable)
Count = 2
[0] 061ab438
    key:061ab078 (System.String: "456key")
    val:061ab094 (System.String: "456value")
[1] 061ab444
    key:061ab03c (System.String: "123key")
    val:061ab058 (System.String: "123value")

0:000> !mdt -e stringArr
06394ff4 (System.String[], Elements: 4)
[0] string1
[1] string2
[2] string3
[3] string4

The scope frame defaults to zero, but may be overridden via the !mframe command.  IMPORTANT:  The current
scope frame corresponds to the frames listed by the !mk command.

IMPORTANT NOTE: Sosex distinguishes between numeric and non-numeric strings in order to determine whether an
address or a type/arg/local name is being passed in ambiguous circumstances.  If you want to pass a string value
that could be interpreted as an expression by the debugger, enclose the name in single-quotes.  For example, for
a local named d2, call: !mdt 'd2'.  If the name were not quoted in this circumstance, !mdt would attempt to display
an object located at address 0xd2.

Frame info for the sample output below:
0:000> !mdv
Frame 0x0: (ConsoleTestApp.ConsoleTestApp.Main(System.String[])):
[A0]:args:0x2371804 (System.String[])
[L0]:theGuid:{29b9c9c8-3751-42be-8c7a-8b92ff499588} VALTYPE (MT=6cd46c60, ADDR=002ff1bc) (System.Guid)
[L1]:d2:0x63718e0 (System.AppDomain)
[L2]:hMod:0x67280000 (System.Int32)
[L3]:dummy:0x23721a4 (System.String) STRVAL="This is "THE" way to test!"
[L4]:numThreads:0x2 (System.Int32)
[L5]:theDate:2008/01/02 03:04:05.678 VALTYPE (MT=6cd49e98, ADDR=002ff1ac) (System.DateTime)
[L6]:ts1:VALTYPE (MT=001e3198, ADDR=002ff1a4) (ConsoleTestApp.TestStruct)
[L7]:ft:0x637544c (ConsoleTestApp.FTEST)
[L8]:g1:<Retrieval mechanism not implemented. The variable type may be a generic type.>
[L9]:g2:<Retrieval mechanism not implemented. The variable type may be a generic type.>
[L10]:rnd:null (System.Random)
[L11]:threads:null (System.Threading.Thread[])
[L12]:i:0x0 (System.Int32)
[L13]:ex:null (System.Exception)
[L14]:CS$0$0000:VALTYPE (MT=001e3198, ADDR=002ff198) (ConsoleTestApp.TestStruct)
[L15]:CS$4$0001:0x0 (System.Boolean)


Sample output:
0:000> !mdt theGuid
002ff1bc (System.Guid) {29b9c9c8-3751-42be-8c7a-8b92ff499588} VALTYPE (MT=6cd46c60, ADDR=002ff1bc)

0:000> !mdt ft
0637544c (ConsoleTestApp.FTEST)
   _s1:06375460 (System.String: "String 1")
   _s2:06375484 (System.String: "String 2")
   _arr:063755c4 (System.String[,,], Elements: 8)

0:000> !mdt 63718e0
063718e0 (System.Runtime.Remoting.Proxies.__TransparentProxy)
   _rp:063718b4 (System.Runtime.Remoting.Proxies.RemotingProxy)
   _stubData:023725dc (BOXED System.IntPtr) VALTYPE (MT=6cd6b114, ADDR=023725e0)
   _pMT:6cd6902c (System.IntPtr)
   _pInterfaceMT:00000000 (System.IntPtr)
   _stub:6d601e70 (System.IntPtr)

0:000> !mdt 63718e0 -r
063718e0 (System.Runtime.Remoting.Proxies.__TransparentProxy)
   _rp:063718b4 (System.Runtime.Remoting.Proxies.RemotingProxy)
      _tp:063718e0 (System.Runtime.Remoting.Proxies.__TransparentProxy)
         <RECURSIVE>
      _identity:06371698 (System.Runtime.Remoting.Identity)
         _flags:0x4 (System.Int32)
         _tpOrObject:063718e0 (System.Runtime.Remoting.Proxies.__TransparentProxy)
            <RECURSIVE>
         _ObjURI:02376858 (System.String: "/f578dbe2_cf0c_4e30_882b_14126f0b1654/kq_om1xc5idnrbhnqnr77cs0_1.rem")
         _URL:NULL (System.String)
         _objRef:023769e0 (System.Runtime.Remoting.ObjRef)
            uri:02376858 (System.String: "/f578dbe2_cf0c_4e30_882b_14126f0b1654/kq_om1xc5idnrbhnqnr77cs0_1.rem")
            typeInfo:02376cc4 (System.Runtime.Remoting.TypeInfo)
               serverType:02377ea4 (System.String: "System.AppDomain, mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
               serverHierarchy:NULL (System.Object[])
               interfacesImplemented:0237808c (System.String[], Elements: 2)
            envoyInfo:NULL (System.Runtime.Remoting.IEnvoyInfo)
            channelInfo:0237872c (System.Runtime.Remoting.ChannelInfo)
               channelData:02378738 (System.Object[], Elements: 1)
            objrefFlags:0x0 (System.Int32)
            srvIdentity:023769fc (System.Runtime.InteropServices.GCHandle) VALTYPE (MT=6cd6bcb8, ADDR=023769fc)
               m_handle:004e11ec (System.IntPtr)
            domainID:0x2 (System.Int32)
         _channelSink:06371890 (System.Runtime.Remoting.Channels.CrossAppDomainSink)
            _xadData:023753c0 (System.Runtime.Remoting.Channels.CrossAppDomainData)
               _ContextID:023753e0 (BOXED System.Int32) BOXEDVAL=0x69B9B0
               _DomainID:0x2 (System.Int32)
               _processGuid:023750bc (System.String: "81174e11_728a_4211_a674_f6f4d79419ba")
         _envoyChain:063718a8 (System.Runtime.Remoting.Messaging.EnvoyTerminatorSink)
         _dph:NULL (System.Runtime.Remoting.Contexts.DynamicPropertyHolder)
         _lease:NULL (System.Runtime.Remoting.Lifetime.Lease)
      _serverObject:NULL (System.MarshalByRefObject)
      _flags:0x3 (System.Runtime.Remoting.Proxies.RealProxyFlags)
      _srvIdentity:063718d0 (System.Runtime.InteropServices.GCHandle) VALTYPE (MT=6cd6bcb8, ADDR=063718d0)
         m_handle:004e11ec (System.IntPtr)
      _optFlags:0x7000000 (System.Int32)
      _domainID:0x2 (System.Int32)
      _ccm:NULL (System.Runtime.Remoting.Messaging.ConstructorCallMessage)
      _ctorThread:0x0 (System.Int32)
   _stubData:023725dc (BOXED System.IntPtr) VALTYPE (MT=6cd6b114, ADDR=023725e0)
      m_value:ffffffff (System.UIntPtr)
   _pMT:6cd6902c (System.IntPtr)
   _pInterfaceMT:00000000 (System.IntPtr)
   _stub:6d601e70 (System.IntPtr)

0:000> !mdt args
02371804 (System.String[], Elements: 0)

0:000> !mdt 001e3198 002ff1a4 -r
002ff1a4 (ConsoleTestApp.TestStruct) VALTYPE (MT=001e3198, ADDR=002ff1a4)
   Member1:0x4D2 (System.UInt32)
   Member2:0x162E (System.UInt32)
``

*!mdv
Usage: !sosex.mdv

Displays parameter and local variable information for the current frame, as specified by the !mframe command.

The scope frame defaults to zero, but may be overridden via the !mframe command.  IMPORTANT:  The current
scope frame corresponds to the frames listed by the !mk command.

Sample output:
0:000> !mdv
Frame 0x0: (ConsoleTestApp.ConsoleTestApp.Main(System.String[])):
[A0]:args:0x2371804 (System.String[])
[L0]:theGuid:{29b9c9c8-3751-42be-8c7a-8b92ff499588} VALTYPE (MT=6cd46c60, ADDR=002ff1bc) (System.Guid)
[L1]:d2:0x63718e0 (System.AppDomain)
[L2]:hMod:0x67280000 (System.Int32)
[L3]:dummy:0x23721a4 (System.String) STRVAL="This is "THE" way to test!"
[L4]:numThreads:0x2 (System.Int32)
[L5]:theDate:2008/01/02 03:04:05.678 VALTYPE (MT=6cd49e98, ADDR=002ff1ac) (System.DateTime)
[L6]:ts1:VALTYPE (MT=001e3198, ADDR=002ff1a4) (ConsoleTestApp.TestStruct)
[L7]:ft:0x637544c (ConsoleTestApp.FTEST)
[L8]:g1:<Retrieval mechanism not implemented. The variable type may be a generic type.>
[L9]:g2:<Retrieval mechanism not implemented. The variable type may be a generic type.>
[L10]:rnd:null (System.Random)
[L11]:threads:null (System.Threading.Thread[])
[L12]:i:0x0 (System.Int32)
[L13]:ex:null (System.Exception)
[L14]:CS$0$0000:VALTYPE (MT=001e3198, ADDR=002ff198) (ConsoleTestApp.TestStruct)
[L15]:CS$4$0001:0x0 (System.Boolean)

A = Argument
L = Local
``

*!mframe
Usage: !sosex.mframe [frame number]

Displays or sets the current managed frame for the !mdt and !mdv commands.

If no frame number is passed, the current scope frame for !mdt and !mdv is displayed.

If a frame number is passed, the current scope frame for !mdt and !mdv is changed.
IMPORTANT:  This frame number must be retrieved by using the !mk command, because the 
merged stack trace that is displayed by the !mk command (which is different than that 
of !sos.clrstack and the 'k' command) is the reference point for scoping !mdt and !mdv.
``

*!mk
Usage: !sosex.mk [-l] [-p] [-a]

Produces and displays a merged stack trace of managed and unmanaged frames.
Local variables and parameters can be listed by passing -l, -p, or -a
-l = Locals
-p = Parameters
-a = Locals and Parameters

Sample output:
0:009> !mk
00:U 0f2fed78 77c06b65 ntdll!NtWaitForMultipleObjects+0x15
01:U 0f2fed80 761e2091 KERNELBASE!WaitForMultipleObjectsEx+0x100
02:U 0f2fee1c 77267e91 KERNEL32!WaitForMultipleObjectsExStub+0xe0
03:U 0f2fee64 6d6f4a6a mscorwks!WaitForMultipleObjectsEx_SO_TOLERANT+0x6f
04:U 0f2feecc 6d6f469b mscorwks!Thread::DoAppropriateAptStateWait+0x3c
05:U 0f2feeec 6d6f47a4 mscorwks!Thread::DoAppropriateWaitWorker+0x13c
06:U 0f2fef70 6d6f4839 mscorwks!Thread::DoAppropriateWait+0x40
07:U 0f2fefc0 6d6f49b9 mscorwks!CLREvent::WaitEx+0xf7
08:U 0f2ff01c 6d61c54e mscorwks!CLREvent::Wait+0x17
09:U 0f2ff030 6d7386ba mscorwks!AwareLock::EnterEpilog+0x8c
0a:U 0f2ff0bc 6d63e3cc mscorwks!AwareLock::Enter+0x61
0b:U 0f2ff0d8 6d63e350 mscorwks!JIT_MonEnterWorker_Portable+0xb3
0c:M 0f2ff178 005007c1 ConsoleTestApp.ConsoleTestApp.LockReleaseAndExit()(+0xc IL)(+0x18 Native) [C:\dev\ConsoleTestApp\ConsoleTestApp.cs, @ 293,13]
0d:M 0f2ff180 6cd16e36 System.Threading.ThreadHelper.ThreadStart_Context(System.Object)(+0x14 IL)(+0x60 Native)
0e:M 0f2ff18c 6cd202bf System.Threading.ExecutionContext.Run(System.Threading.ExecutionContext, System.Threading.ContextCallback, System.Object)(+0x58 IL)(+0x65 Native)
0f:M 0f2ff1a0 6cd16db4 System.Threading.ThreadHelper.ThreadStart()(+0x8 IL)(+0x2a Native)
10:U 0f2ff1b8 6d601b4c mscorwks!CallDescrWorker+0x33
11:U 0f2ff1c8 6d6121b9 mscorwks!CallDescrWorkerWithHandler+0xa3
12:U 0f2ff248 6d626531 mscorwks!MethodDesc::CallDescr+0x19c
13:U 0f2ff380 6d626564 mscorwks!MethodDesc::CallTargetWorker+0x1f
14:U 0f2ff39c 6d626582 mscorwks!MethodDescCallSite::Call+0x1a
15:U 0f2ff3b4 6d6e59e3 mscorwks!ThreadNative::KickOffThread_Worker+0x192
16:U 0f2ff59c 6d62848f mscorwks!Thread::DoADCallBack+0x32a
17:U 0f2ff5b0 6d62842b mscorwks!Thread::ShouldChangeAbortToUnload+0xe3
18:U 0f2ff644 6d628351 mscorwks!Thread::ShouldChangeAbortToUnload+0x30a
19:U 0f2ff680 6d6284dd mscorwks!Thread::ShouldChangeAbortToUnload+0x33e
1a:U 0f2ff6a8 6d6e57b4 mscorwks!ManagedThreadBase::KickOff+0x13
1b:U 0f2ff6c0 6d6e588e mscorwks!ThreadNative::KickOffThread+0x269
1c:U 0f2ff75c 6d71d5bd mscorwks!Thread::intermediateThreadProc+0x49
1d:U 0f2ff8fc 7726816c KERNEL32!BaseThreadInitThunk+0xe
1e:U 0f2ff908 77c42404 ntdll!__RtlUserThreadStart+0x23
1f:U 0f2ff948 77c42618 ntdll!_RtlUserThreadStart+0x1b

For the explanation, we will use the following line:
0c:M 0f2ff178 005007c1 ConsoleTestApp.ConsoleTestApp.LockReleaseAndExit()(+0xc IL)(+0x18 Native) [C:\dev\ConsoleTestApp\ConsoleTestApp.cs, @ 293,13]

0c is the frame number.
M indicates that the frame is a managed frame.  Unmanaged frames are indicated with a U.
The first address is the ESP value for the frame.
The second address is the EIP value for the frame.
Following the addresses is the name of the method.
Following the method name is the IL and/or native offset within the method
Following the offset info is the source code information, if available.
``

*!mln
Usage !sosex.mln [address expression]

Displays the type of CLR data residing at the given address, if it can be determined.
If no address is specified, the current instruction pointer is used as the address.

Sample output:
0:011> !mln 6cd16db4
Method instance: 6cd16d70[System.Threading.ThreadHelper.ThreadStart()]

0:011> !mln 0f85ec88 
Stack: debugger thread 11, frame 5
``

*!mx
Usage: !sosex.mx <Filter String>

Displays any matching type, method or field for <Filter String>, where <Filter String> is a string in 
module!metadataname format.  If module! is not specified, all modules are searched for the specified 
metadata.  Searched info includes types, methods and fields.

Each type, method or field is preceded by a type specifier in brackets.  The following are possible values:
 T - Type
VT - Value type
RT - Reference type
 I - Interface
 F - Field
 M - Method
SF - Static field
SM - Static method

Types are followed by their MethodTable (MT) address in parentheses.
Methods are followed by their MethodDesc (MD) address in parentheses.
Fields are followed by their field type

Sample output:
0:027> !mx consoletestapp!consoletestapp.*struct*
[VT] ConsoleTestApp!ConsoleTestApp.TestStruct (MT=00213c48)
[ F] ConsoleTestApp!ConsoleTestApp.TestStruct.Member1 (FIELDTYPE=uint)
[ F] ConsoleTestApp!ConsoleTestApp.TestStruct.Member2 (FIELDTYPE=uint)
[RT] ConsoleTestApp!ConsoleTestApp.TestStruct1 (MT=002161b4)
[ M] ConsoleTestApp!ConsoleTestApp.TestStruct1..ctor(): void (MD=002161a4)
[SM] ConsoleTestApp!ConsoleTestApp.TestStruct1..cctor(): void (MD=002161ac)
[SF] ConsoleTestApp!ConsoleTestApp.TestStruct1.__sf1 (FIELDTYPE=int)
[ F] ConsoleTestApp!ConsoleTestApp.TestStruct1.Member1 (FIELDTYPE=uint)
[ F] ConsoleTestApp!ConsoleTestApp.TestStruct1.Member2 (FIELDTYPE=uint)
[RT] ConsoleTestApp!ConsoleTestApp.TestStruct2 (MT=0021623c)
[ M] ConsoleTestApp!ConsoleTestApp.TestStruct2..ctor(): void (MD=0021622c)
[SM] ConsoleTestApp!ConsoleTestApp.TestStruct2..cctor(): void (MD=00216234)
[SF] ConsoleTestApp!ConsoleTestApp.TestStruct2.__sf2 (FIELDTYPE=int)
[ F] ConsoleTestApp!ConsoleTestApp.TestStruct2.Member3 (FIELDTYPE=uint)
``

*!refs
Usage:
!sosex.refs <hexObjectAddr>

Lists all references held by the specified object
Lists all references to the specified object (searches heaps, stacks, registers, handle tables and the freachable queue)

Refs are listed in the following format:
hexAddr decSize strTypeName

Sample output:
0:000> !sosex.refs 7fff2970
Objects referenced by 7fff2970:
7fff1100	     64	System.IO.__ConsoleStream
7fff1388	    136	System.Text.SBCSCodePageEncoding
7fff2c50	     48	System.Text.DecoderNLS
7fff2c80	    280	System.Byte[]
7fff2d98	    536	System.Char[]
7fff1140	     24	System.Byte[]

Objects referencing 7fff2970:
7fff2fb0	     32	System.IO.TextReader+SyncTextReader
``

*!rwlock
Usage:
!sosex.rwlock    [ObjectAddr>
Displays all RWLocks or, if provided a RWLock address, details of the specified lock

Sample Output:
0:027> !rwlock
Address    ReaderCount   WaitingReaderCount   WriterThread   WaitingWriterCount
---------------------------------------------------------------------------------------
061a9ff8             0                    0              0                    0
061aa374             1                    0              0                    1
061aa3a0             0                    1              7                    0
061aa3cc             1                    0              0                    1
061aa3f8             1                    0              0                    1
061aa424             0                    1             11                    0
061aa450             0                    1             12                    0
061aa47c             0                    1             13                    0
061aa4a8             1                    0              0                    1
061aa4d4             0                    1             16                    0
061aa500             0                    1             17                    0
0623cddc             0                    0              0                    0

0:027> !rwlock 061aa4d4             
WriterThread:           16
WriterLevel:            1
WaitingWriterCount:     0
WriterEvent:            0
WaitingWriterThreadIds: None
ReaderCount:            0
CurrentReaderThreadIds: None
WaitingReaderCount:     1
ReaderEvent:            414
WaitingReaderThreadIds: 15
``

*!strings
Lists all strings on managed heaps that match the specified criteria.
Usage: !sosex.strings [ModulePtr] [Options]

If you pass a ModulePtr, !strings searches the UserString metadata.  If no ModulePtr is passed, the managed heaps are searched
for string instances.

Options:
g:<min gen>       Lists strings only in the specified GC generation.  Valid parameters are 0, 1, 2 and 3 (Large Object Heap).
m:<match filter>  Limits output to strings matching the specified filter string.  Filter may contain * and ? wildcards.
n:<min length>    Limits output to strings whose length is greater than or equal to the specified decimal integer.
x:<max length>    Limits output to strings whose length is less than or equal to the specified decimal integer.

Sample output:
0:000> !sosex.strings /g:2 /n:3
Address    Gen  Value
---------------------------
05cce580	2	yactpju7foti0zzva_6exij1_3.rem
05cce818	2	System.Runtime.Remoting.ObjectHandle, mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
05ccebf0	2	System.Runtime.Remoting.IObjectHandle
05ccec4c	2	System.Runtime.Remoting.IObjectHandle, mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
05ccf230	2	/dd626c52_630c_4206_833d_ffd9ac214b3e/yactpju7foti0zzva_6exij1_3.rem
05ccf2cc	2	dd626c52_630c_4206_833d_ffd9ac214b3e/yactpju7foti0zzva_6exij1_3.rem
05ccfb10	2	TestLib.Tester.InstanceTest called.
05ccfbc0	2	111
05ccfbd8	2	123
...
---------------------------------------
394 strings
``

*!ListGcHandles
See documentation for !gch
``
