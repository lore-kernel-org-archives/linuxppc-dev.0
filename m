MIME-Version: 1.0
Message-Id: <3924D822.22874@mta2>
Date: Fri, 19 May 2000 13:58:58 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re:Re: my port problem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>zzh wrote:
>>
>>      Hi,my port of linux on 8260 ads board run successfully
>> after free_init_mem.I mount root on a ram disk init from
>> initrd.It cannot open the console driver(it is a symbolic
>> to /dev/ttyS0) .
>
>What is the text of the error message.  The entire text of the
>kernel messages during boot would be helpful as well.  This is
>the very first access to the file system, perhaps initrd isn't
>working.
>
>
>	-- Dan
0x00200000 0x002e0f77 'vmlinux'
0x002e0f78 0x002e0f94 board information
0x00000000 0x000d0f94 relocated vmlinux and board info
0x00c00000 0x01000000 relocated initrd
(0x0000000c)(0x000d0f78, 0x00c00000, 0x00400000, 0x00000000, 0x00000000)
Total Memoty = 16MB;unsing 64kb for hash table (at c00d0000).
Linux version 2.2.11.......
Boot arguments:
Calibrating delay loop...14.44 BogoMIPS
remove_mem_piece: bad overlap [c8000,f4000) with [c8000, d0000) [e0000, 1000000)

Memory: 15408k available (552k kernel code, 396k data, 28k init) [c0000000,c1000
000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Sw<6>NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0100 is a SCC        //i use scc2 as ttyS0
info in rs_8xx_init c01d85e0
RAM disk driver initialized:  16 RAM disks of 4096K size
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 4096 blocks [1 disk] into ram disk... done.
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 28k init
After free_initmem
Warning: unable to open an initial console.
/*open("/dev/console",...);*/

In init!      /*this printk calls before execve("/bin/bash",...);


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
