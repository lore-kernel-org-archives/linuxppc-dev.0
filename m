Message-ID: <20030119152356.47054.qmail@web16713.mail.tpe.yahoo.com>
Date: Sun, 19 Jan 2003 23:23:56 +0800 (CST)
From: =?big5?q?=20=20=20?= <carllintw@yahoo.com.tw>
Subject: 405GPr with GLIBC 2.2.1 (ELDK) and 64MB OK, but panic with 128 MB
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a board with 405GPr and 128MB SDRAM. When
booting linuxppc 2.4.20 with the "mem=64m" parameter,
it works fine. When booting without "mem=64m", it will
hang at running init. In real mode, all 128MB SDRAM
could be accessed without problems. With "mem=64m",
if I use "ioremap" to remap the upper 64MB
(0x04000000-0x07FFFFFF), the kernel could access that
memory region without problems.

What is the problem ? Please help.


Linux version 2.4.20 (root@carl.home.net) (gcc version
2.95.3 20010315 (release)) #199 1 18 16:22:13 CST 2003
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
Calibrating delay loop... 332.59 BogoMIPS
Memory: 123336k available (1284k kernel code, 568k
data, 88k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5,
131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536
bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384
bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768
bytes)
Page-cache hash table entries: 32768 (order: 5, 131072
bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
OCP uart ver 1.6.2 init complete
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch
(rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Found 2x16bit 16MByte CFI flash device of type
Intel/Sharp extended at FF000000
Registered flash device /dev/flasha (minor 0, 4
partitions)
Serial driver version 5.05c (2001-07-08) with
MANY_PORTS SHARE_IRQ SERIAL_PCI en
abled
ttyS0 at 0xef600300 (irq = 0) is a 16550A
ttyS1 at 0xef600400 (irq = 1) is a 16550A
PPC 405 watchdog driver v0.6
IBM gpio driver version 07.25.02
GPIO #0 at 0xcb10f700
RAMDISK driver initialized: 16 RAM disks of 12288K
size 1024 blocksize
loop: loaded (max 8 devices)
IBM On-chip iic (i2c) algorithm module 2002.30.04
iic_ibmocp_init: IBM on-chip iic adapter module
i2c-dev.o: Registered 'IBM OCP IIC adapter' as minor 0
i2c-core.o: adapter IBM OCP IIC adapter registered as
adapter 0.
i2c-core.o: driver ds1307 registered.
i2c-core.o: client [ds1307] registered to adapter [IBM
OCP IIC adapter](pos. 0).
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind
8192)
ip_conntrack version 2.1 (1024 buckets, 8192 max) -
320 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4229k freed
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 88k init
Starting system services,please wait.......



-----------------------------------------------------------------
–ぱ常Yahoo!集
Yahoo! 集╃芥 - ぐ或常Τぐ或常芥ぐ或常ぃ┣
bid.yahoo.com.tw

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
