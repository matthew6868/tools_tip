typedef struct _DUMP_HEADER32 {
    /* 0x000 */ ULONG Signature;
    /* 0x004 */ ULONG ValidDump;
    /* 0x008 */ ULONG MajorVersion;
    /* 0x00C */ ULONG MinorVersion;
    /* 0x010 */ ULONG DirectoryTableBase;
    /* 0x014 */ ULONG PfnDataBase;
    /* 0x018 */ PLIST_ENTRY PsLoadedModuleList;
    /* 0x01C */ PLIST_ENTRY PsActiveProcessHead;
    /* 0x020 */ ULONG MachineImageType;
    /* 0x024 */ ULONG NumberOfProcessors;
    /* 0x028 */ ULONG BugCheckCode;
    /* 0x02C */ ULONG BugCheckParameter1;
    /* 0x030 */ ULONG BugCheckParameter2;
    /* 0x034 */ ULONG BugCheckParameter3;
    /* 0x038 */ ULONG BugCheckParameter4;
    /* 0x03C */ UCHAR VersionUser[32];
    /* 0x05C */ UCHAR PaeEnabled;
    /* 0x05d */ UCHAR KdSecondaryVersion;
    /* 0x05e */ UCHAR Spare3[2];
    /* 0x060 */ PKDDEBUGGER_DATA64
      KdDebuggerDataBlock;
    union {
        /* 0x064 */ PHYSICAL_MEMORY_DESCRIPTOR32
           PhysicalMemoryBlock;
        /* 0x064 */ UCHAR
           PhysicalMemoryBlockBuffer[700];
    }
    union {
        /* 0x320 */ CONTEXT Context;
        /* 0x320 */ UCHAR ContextRecord[120];
    }
    /* 0x7d0 */ EXCEPTION_RECORD32 Exception;
    /* 0x820 */ UCHAR Comment[128];
    /* 0x8a0 */ UCHAR _reserved0[1768];
    /* 0xf88 */ ULONG DumpType;
    /* 0xf8c */ ULONG MiniDumpFields;
    /* 0xf90 */ ULONG SecondaryDataState;
    /* 0xf94 */ ULONG ProductType;
    /* 0xf98 */ ULONG SuiteMask;
    /* 0xf9c */ ULONG WriterStatus;
    /* 0xfa0 */ LARGE_INTEGER RequiredDumpSpace;
    /* 0xfa8 */ UCHAR _reserved2[16];
    /* 0xfb8 */ LARGE_INTEGER SystemUpTime;
    /* 0xfc0 */ LARGE_INTEGER SystemTime;
    /* 0xfc8 */ UCHAR _reserved3[56];
} DUMP_HEADER32, *PDUMP_HEADER32;